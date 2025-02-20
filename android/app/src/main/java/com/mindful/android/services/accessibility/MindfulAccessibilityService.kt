/*
 *
 *  *
 *  *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *  *
 *  *  * This source code is licensed under the GPL-2.0 license license found in the
 *  *  * LICENSE file in the root directory of this source tree.
 *  *
 *
 */
package com.mindful.android.services.accessibility

import android.accessibilityservice.AccessibilityService
import android.accessibilityservice.AccessibilityServiceInfo
import android.content.Intent
import android.content.IntentFilter
import android.content.SharedPreferences
import android.content.SharedPreferences.OnSharedPreferenceChangeListener
import android.content.pm.PackageManager
import android.net.Uri
import android.util.Log
import android.view.accessibility.AccessibilityEvent
import android.view.accessibility.AccessibilityNodeInfo
import android.widget.Toast
import com.mindful.android.R
import com.mindful.android.helpers.storage.SharedPrefsHelper
import com.mindful.android.models.WellBeingSettings
import com.mindful.android.receivers.DeviceAppsChangedReceiver
import com.mindful.android.receivers.alarm.MidnightResetReceiver
import com.mindful.android.utils.AppConstants.FACEBOOK_PACKAGE
import com.mindful.android.utils.AppConstants.INSTAGRAM_PACKAGE
import com.mindful.android.utils.AppConstants.REDDIT_PACKAGE
import com.mindful.android.utils.AppConstants.SNAPCHAT_PACKAGE
import com.mindful.android.utils.AppConstants.YOUTUBE_PACKAGE
import com.mindful.android.utils.ThreadUtils
import org.json.JSONObject
import java.util.concurrent.ExecutorService
import java.util.concurrent.Executors

/**
 * An AccessibilityService that monitors app usage and blocks access to specified content based on user settings.
 */
class MindfulAccessibilityService : AccessibilityService(), OnSharedPreferenceChangeListener {
    companion object {
        private const val TAG = "Mindful.MindfulAccessibilityService"

        //  The minimum interval between every Back Action [BACK PRESS] call from service
        private const val BACK_ACTION_INVOKE_INTERVAL_MS = 500L
    }


    // Fixed thread pool for parallel event processing
    private val mExecutorService: ExecutorService = Executors.newFixedThreadPool(4)
    private val deviceAppsChangedReceiver: DeviceAppsChangedReceiver =
        DeviceAppsChangedReceiver(onAppsChanged = { refreshServiceInfo() })

    // Short content management
    private lateinit var shortsPlatformManager: ShortsPlatformManager

    // Browser management
    private lateinit var browserManager: BrowserManager

    private var mWellBeingSettings = WellBeingSettings(JSONObject())
    private var lastTimeBackActioned = 0L

    override fun onCreate() {
        super.onCreate()
        shortsPlatformManager = ShortsPlatformManager(
            context = this,
            blockedContentGoBack = this::goBackWithToast
        )

        browserManager = BrowserManager(
            context = this,
            shortsPlatformManager = shortsPlatformManager,
            blockedContentGoBack = this::goBackWithToast
        )
    }


    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        if (intent?.action == MidnightResetReceiver.ACTION_MIDNIGHT_ACCESSIBILITY_RESET) {
            shortsPlatformManager.resetShortsScreenTime()
            Log.d(TAG, "onStartCommand: Midnight reset completed")
        }
        return super.onStartCommand(intent, flags, startId)
    }

    override fun onServiceConnected() {
        // Register shared prefs listener and load data
        SharedPrefsHelper.registerUnregisterListenerToListenablePrefs(this, true, this)
        mWellBeingSettings = SharedPrefsHelper.getSetWellBeingSettings(this, null)

        // Register listener for install and uninstall events
        val filter = IntentFilter()
        filter.addAction(Intent.ACTION_PACKAGE_ADDED)
        filter.addAction(Intent.ACTION_PACKAGE_REMOVED)
        filter.addDataScheme("package")
        registerReceiver(deviceAppsChangedReceiver, filter)

        refreshServiceInfo()
        Log.d(TAG, "onCreate: Accessibility service started successfully")
        super.onServiceConnected()
    }

    override fun onAccessibilityEvent(event: AccessibilityEvent) {
        // Minimal checks on the main thread
        if (!shouldBlockContent() || event.eventType != AccessibilityEvent.TYPE_WINDOW_CONTENT_CHANGED) {
            return
        }

        // Offload the main processing to a background thread
        try {
            if (mExecutorService.isShutdown) return
            event.source?.let {
                mExecutorService.submit { processEventInBackground(it.packageName.toString(), it) }
            }
        } catch (ignored: Exception) {
        }
    }

    /**
     * Processes accessibility event in background thread instead of main thread.
     *
     * @param packageName The package name of the app generating the event.
     * @param node        The accessibility node representing the UI element currently in focus.
     */
    private fun processEventInBackground(packageName: String, node: AccessibilityNodeInfo) {
        try {
            // Copy settings for this thread
            val settings = mWellBeingSettings.copy()

            shortsPlatformManager.checkAndBlockShortsOnPlatforms(packageName, node, settings)
                ?: browserManager.blockDistraction(packageName, node, settings)


        } catch (e: Exception) {
            Log.e(
                TAG,
                "processEventInBackground: Failed to process accessibility event in background",
                e
            )
            SharedPrefsHelper.insertCrashLogToPrefs(this, e)
        }
    }


    /**
     * Determines whether content should be blocked based on the current settings.
     *
     * @return `true` if content should be blocked based on the current settings,
     * `false` otherwise.
     */
    private fun shouldBlockContent(): Boolean {
        return mWellBeingSettings.blockedWebsites.isNotEmpty() ||
                mWellBeingSettings.blockInstaReels ||
                mWellBeingSettings.blockYtShorts ||
                mWellBeingSettings.blockSnapSpotlight ||
                mWellBeingSettings.blockFbReels ||
                mWellBeingSettings.blockNsfwSites
    }


    /**
     * Performs the back action and shows a toast message indicating that the content is blocked.
     */
    private fun goBackWithToast() {
        val currentTime = System.currentTimeMillis()
        if (currentTime - lastTimeBackActioned >= BACK_ACTION_INVOKE_INTERVAL_MS) {
            lastTimeBackActioned = currentTime

            ThreadUtils.runOnMainThread {
                // Perform the back action (can be done on background thread)
                performGlobalAction(GLOBAL_ACTION_BACK)

                // Post Toast to main thread
                Toast.makeText(
                    this@MindfulAccessibilityService,
                    getString(R.string.toast_blocked_content),
                    Toast.LENGTH_LONG
                ).show()
            }
        }
    }

    /**
     * Updates the service info with the latest settings and registered packages.
     */
    private fun refreshServiceInfo() {
        try {// Using hashset to avoid duplicates
            val pm = packageManager
            val allowedPackages = mutableSetOf<String>()

            // Fetch installed browser packages
            val browserIntent = Intent(Intent.ACTION_VIEW, Uri.parse("http://www.google.com"))
            pm.queryIntentActivities(browserIntent, PackageManager.MATCH_ALL).forEach {
                allowedPackages.add(it.activityInfo.packageName)
            }


            // For short form content blocking on their native apps
            if (mWellBeingSettings.blockInstaReels) allowedPackages.add(INSTAGRAM_PACKAGE)
            if (mWellBeingSettings.blockSnapSpotlight) allowedPackages.add(SNAPCHAT_PACKAGE)
            if (mWellBeingSettings.blockFbReels) allowedPackages.add(FACEBOOK_PACKAGE)
            if (mWellBeingSettings.blockRedditShorts) allowedPackages.add(REDDIT_PACKAGE)

            if (mWellBeingSettings.blockYtShorts) {
                // Fetch all the clients available for youtube. It can also include browsers too.
                val ytIntent = Intent(Intent.ACTION_VIEW, Uri.parse("https://www.youtube.com"))
                pm.queryIntentActivities(ytIntent, PackageManager.MATCH_ALL).forEach {
                    allowedPackages.add(it.activityInfo.packageName)
                }

                // Regardless of the results add original youtube package.
                allowedPackages.add(YOUTUBE_PACKAGE)
            }

            // Load nsfw website domains if needed
            if (mWellBeingSettings.blockNsfwSites) BrowserManager.initializeNsfwDomains()
            else BrowserManager.clearNsfwDomains()

            val info = AccessibilityServiceInfo()
            info.eventTypes = AccessibilityEvent.TYPE_WINDOW_CONTENT_CHANGED
            info.feedbackType = AccessibilityServiceInfo.FEEDBACK_ALL_MASK
            info.flags = AccessibilityServiceInfo.DEFAULT or
                    AccessibilityServiceInfo.FLAG_INCLUDE_NOT_IMPORTANT_VIEWS or
                    AccessibilityServiceInfo.FLAG_REPORT_VIEW_IDS or
                    AccessibilityServiceInfo.FLAG_RETRIEVE_INTERACTIVE_WINDOWS
            info.notificationTimeout = 1000
            info.packageNames = allowedPackages.toTypedArray()
            serviceInfo = info

            Log.d(
                TAG, "refreshServiceInfo: Accessibility service updated successfully: " +
                        "\n settings: $mWellBeingSettings" +
                        "\n packages: $allowedPackages"
            )
        } catch (e: Exception) {
            Log.e(TAG, "refreshServiceInfo: Failed to refresh service info", e)
            SharedPrefsHelper.insertCrashLogToPrefs(this, e)
        }
    }

    override fun onSharedPreferenceChanged(prefs: SharedPreferences, changedKey: String?) {
        changedKey?.let { key ->
            if (key == SharedPrefsHelper.PREF_KEY_WELLBEING_SETTINGS) {
                Log.d(TAG, "OnSharedPrefsChanged: Key changed = $changedKey")
                mWellBeingSettings = SharedPrefsHelper.getSetWellBeingSettings(this, null)
                refreshServiceInfo()
            }
        }
    }

    override fun onInterrupt() {
    }

    override fun onDestroy() {
        mExecutorService.shutdown()
        // Unregister prefs listener and receiver
        unregisterReceiver(deviceAppsChangedReceiver)
        SharedPrefsHelper.registerUnregisterListenerToListenablePrefs(this, false, this)
        Log.d(TAG, "onDestroy: Accessibility service destroyed")
        super.onDestroy()
    }
}
