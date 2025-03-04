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
import com.mindful.android.enums.PlatformFeatures
import com.mindful.android.helpers.device.PermissionsHelper
import com.mindful.android.helpers.storage.SharedPrefsHelper
import com.mindful.android.models.WellBeingSettings
import com.mindful.android.receivers.DeviceAppsChangedReceiver
import com.mindful.android.receivers.alarm.MidnightResetReceiver
import com.mindful.android.utils.AppConstants.FACEBOOK_PACKAGE
import com.mindful.android.utils.AppConstants.INSTAGRAM_PACKAGE
import com.mindful.android.utils.AppConstants.REDDIT_PACKAGE
import com.mindful.android.utils.AppConstants.SETTINGS_PACKAGE
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
        const val ACTION_MIDNIGHT_ACCESSIBILITY_RESET: String =
            "com.mindful.android.MindfulAccessibilityService.MIDNIGHT_ACCESSIBILITY_RESET"

        const val ACTION_TAMPER_PROTECTION_CHANGED: String =
            "com.mindful.android.MindfulAccessibilityService.TAMPER_PROTECTION_CHANGED"

        // Set of desired events which will be processed
        private val desiredEvents = setOf(
            AccessibilityEvent.TYPE_WINDOWS_CHANGED,
            AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED,
            AccessibilityEvent.TYPE_VIEW_SCROLLED
        )

        //  The minimum interval between every Back Action [BACK PRESS] call from service
        private const val BACK_ACTION_INVOKE_INTERVAL_MS = 500L

        private val browserPackages = mutableSetOf<String>()
        private val shortsPlatformPackages = mutableSetOf<String>()
        private val devicePlatformPackages = mutableSetOf<String>()
    }


    // Fixed thread pool for parallel event processing
    private val mExecutorService: ExecutorService = Executors.newFixedThreadPool(4)
    private val deviceAppsChangedReceiver: DeviceAppsChangedReceiver =
        DeviceAppsChangedReceiver(onAppsChanged = { refreshServiceConfig() })

    // Managers
    private lateinit var shortsPlatformManager: ShortsPlatformManager
    private lateinit var browserManager: BrowserManager
    private lateinit var deviceFeaturesManager: DeviceFeaturesManager
    private lateinit var trackingManager: TrackingManager

    private var mWellBeingSettings = WellBeingSettings(JSONObject())
    private var lastTimeBackActioned = 0L

    override fun onCreate() {
        super.onCreate()
        trackingManager = TrackingManager(context = this)

        deviceFeaturesManager = DeviceFeaturesManager(
            context = this,
            blockedContentGoBack = this::goBackWithToast
        )

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
        when (intent?.action) {
            ACTION_MIDNIGHT_ACCESSIBILITY_RESET -> {
                shortsPlatformManager.resetShortsScreenTime()
                Log.d(TAG, "onStartCommand: Midnight reset completed")
            }

            ACTION_TAMPER_PROTECTION_CHANGED -> {
                Log.d(TAG, "onStartCommand: Tamper protection changed")
                refreshServiceConfig()
            }
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

        refreshServiceConfig()
        trackingManager.stopManualTracking()
        Log.d(TAG, "onCreate: Accessibility service started successfully")
        super.onServiceConnected()
    }

    override fun onAccessibilityEvent(event: AccessibilityEvent) {
        try {
            // If not desired event or executor is shutdown, then just return
            if (!desiredEvents.contains(event.eventType) || mExecutorService.isShutdown) return

            // submit event for tracking
            val packageName = event.packageName.toString()
            mExecutorService.submit { trackingManager.onNewEvent(packageName) }

            // If no reason to process event then just return
            if (!shouldBlockContent()) return

            // Determine node source
            val node = if (packageName == REDDIT_PACKAGE) event.source
            else rootInActiveWindow ?: event.source

            node?.let {
                mExecutorService.submit {
                    processEventInBackground(
                        packageName,
                        it,
                        mWellBeingSettings.copy()
                    )
                }
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
    private fun processEventInBackground(
        packageName: String,
        node: AccessibilityNodeInfo,
        wellBeingSettings: WellBeingSettings,
    ) {
        try {
            when (packageName) {
                in devicePlatformPackages ->
                    deviceFeaturesManager.blockFeatures(packageName, node, wellBeingSettings)

                in shortsPlatformPackages ->
                    shortsPlatformManager.blockDistraction(packageName, node, wellBeingSettings)

                in browserPackages ->
                    browserManager.blockDistraction(packageName, node, wellBeingSettings)
            }

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
        return mWellBeingSettings.blockedFeatures.isNotEmpty() ||
                mWellBeingSettings.blockedWebsites.isNotEmpty() ||
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
    private fun refreshServiceConfig() {
        try {
            // Using hashset to avoid duplicates
            browserPackages.clear()
            devicePlatformPackages.clear()
            shortsPlatformPackages.clear()
            val pm = packageManager

            // Check admin and add settings to blocked packages
            if (PermissionsHelper.getAndAskAdminPermission(this, false)) {
                devicePlatformPackages.add(SETTINGS_PACKAGE)
            }

            // Fetch installed browser packages
            val browserIntent = Intent(Intent.ACTION_VIEW, Uri.parse("http://www.google.com"))
            pm.queryIntentActivities(browserIntent, PackageManager.MATCH_ALL).forEach {
                browserPackages.add(it.activityInfo.packageName)
            }

            mWellBeingSettings.blockedFeatures.forEach { feature ->
                when (feature) {
                    /// Instagram
                    PlatformFeatures.INSTAGRAM_REELS,
                    PlatformFeatures.INSTAGRAM_EXPLORE,
                    -> shortsPlatformPackages.add(INSTAGRAM_PACKAGE)

                    // Snapchat
                    PlatformFeatures.SNAPCHAT_SPOTLIGHT,
                    PlatformFeatures.SNAPCHAT_DISCOVER,
                    -> shortsPlatformPackages.add(SNAPCHAT_PACKAGE)

                    // Facebook
                    PlatformFeatures.FACEBOOK_REELS ->
                        shortsPlatformPackages.add(FACEBOOK_PACKAGE)

                    // Reddit
                    PlatformFeatures.REDDIT_SHORTS ->
                        shortsPlatformPackages.add(REDDIT_PACKAGE)

                    // Youtube
                    PlatformFeatures.YOUTUBE_SHORTS -> {
                        // Add official package
                        shortsPlatformPackages.add(YOUTUBE_PACKAGE)

                        // Now add other unofficial clients
                        val ytIntent =
                            Intent(Intent.ACTION_VIEW, Uri.parse("https://www.youtube.com"))
                        pm.queryIntentActivities(ytIntent, PackageManager.MATCH_ALL)
                            .filterNot { browserPackages.contains(it.activityInfo.packageName) }
                            .forEach {
                                shortsPlatformPackages.add(it.activityInfo.packageName)
                            }
                    }
                }
            }


            // Load nsfw website domains if needed
            if (mWellBeingSettings.blockNsfwSites) BrowserManager.initializeNsfwDomains()
            else BrowserManager.clearNsfwDomains()

            Log.d(
                TAG, "refreshServiceConfig: Accessibility service config updated successfully: " +
                        "\n settings: $mWellBeingSettings" +
                        "\n device platforms: $devicePlatformPackages" +
                        "\n short platforms: $shortsPlatformPackages" +
                        "\n browsers: $browserPackages"
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
                refreshServiceConfig()
            }
        }
    }

    override fun onInterrupt() {
    }

    override fun onDestroy() {
        mExecutorService.shutdown()
        trackingManager.startManualTracking()

        // Unregister prefs listener and receiver
        unregisterReceiver(deviceAppsChangedReceiver)
        SharedPrefsHelper.registerUnregisterListenerToListenablePrefs(this, false, this)

        Log.d(TAG, "onDestroy: Accessibility service destroyed")
        super.onDestroy()
    }
}
