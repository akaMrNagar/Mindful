package com.mindful.android.services.tracking

import android.accessibilityservice.AccessibilityService
import android.app.Service.USAGE_STATS_SERVICE
import android.app.usage.UsageEvents
import android.app.usage.UsageStatsManager
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Build
import android.util.Log
import androidx.annotation.MainThread
import androidx.annotation.WorkerThread
import com.mindful.android.receivers.DeviceLockUnlockReceiver
import com.mindful.android.services.accessibility.TrackingManager.Companion.ACTION_NEW_APP_LAUNCHED
import com.mindful.android.services.accessibility.TrackingManager.Companion.ACTION_START_MANUAL_TRACKING
import com.mindful.android.services.accessibility.TrackingManager.Companion.ACTION_STOP_MANUAL_TRACKING
import com.mindful.android.utils.AppConstants
import com.mindful.android.utils.Utils
import java.util.concurrent.Executors
import java.util.concurrent.ScheduledExecutorService
import java.util.concurrent.TimeUnit


class LaunchTrackingManager(
    private val context: Context,
    private val onNewAppLaunched: (packageName: String) -> Unit,
) {
    companion object {
        private const val TAG = "Mindful.LaunchTrackingManager"

        // Interval for tracking app launches in milliseconds
        private const val TIMER_RATE: Long = 750
    }

    private val accessibilityReceiver: AccessibilityReceiver = AccessibilityReceiver()
    private val lockUnlockReceiver: DeviceLockUnlockReceiver =
        DeviceLockUnlockReceiver { isUnlocked ->
            if (isUnlocked) onDeviceUnlocked()
            else onDeviceLocked()
        }

    private var trackingExecutor: ScheduledExecutorService? = null
    private var usageStatsManager: UsageStatsManager? = null

    private var isManualTrackingOn: Boolean = true
    private var isTrackingPaused: Boolean = false

    private val activeApps: MutableSet<String> = mutableSetOf()
    private var lastUsageQueryTimestamp = System.currentTimeMillis()
    private var lastLaunchedApp = ""

    init {
        // Register lock/unlock receiver
        val lockUnlockFilter = IntentFilter().apply {
            addAction(Intent.ACTION_USER_PRESENT)
            addAction(Intent.ACTION_SCREEN_OFF)
        }
        context.registerReceiver(lockUnlockReceiver, lockUnlockFilter)

        // Register accessibility receiver
        val accessibilityFilter = IntentFilter().apply {
            addAction(ACTION_START_MANUAL_TRACKING)
            addAction(ACTION_NEW_APP_LAUNCHED)
            addAction(ACTION_STOP_MANUAL_TRACKING)
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            context.registerReceiver(
                accessibilityReceiver,
                accessibilityFilter,
                Context.RECEIVER_NOT_EXPORTED
            )
        } else {
            context.registerReceiver(accessibilityReceiver, accessibilityFilter)
        }

        // Check if accessibility is already running
        isManualTrackingOn = !Utils.isServiceRunning(context, AccessibilityService::class.java)

        // Start tracking
        onDeviceUnlocked()
    }


    @MainThread
    private fun onDeviceUnlocked() {
        // Start tracking manually only if accessibility is not running
        if (isManualTrackingOn) {
            // First cancel earlier task if already not cancelled
            trackingExecutor?.shutdownNow()
            trackingExecutor = Executors.newScheduledThreadPool(1)

            // Schedule new task
            trackingExecutor?.scheduleWithFixedDelay(
                { findLaunchedApp() },
                0L,
                TIMER_RATE,
                TimeUnit.MILLISECONDS
            )

            Log.d(TAG, "onDeviceUnlocked: Manual usage tracking started")
            Thread { broadcastLastAppLaunchEvent() }.start()
        }
    }

    @MainThread
    private fun onDeviceLocked() {
        trackingExecutor?.shutdownNow()
        trackingExecutor = null

        Log.d(TAG, "onDeviceLocked: Manual usage tracking stopped")
    }

    @WorkerThread
    private fun findLaunchedApp(pastTime: Long = 0) {
        // Initialize usage states manager
        if (usageStatsManager == null) {
            usageStatsManager =
                context.getSystemService(USAGE_STATS_SERVICE) as UsageStatsManager
        }


        val now = System.currentTimeMillis()
        val usageEvents =
            usageStatsManager?.queryEvents(lastUsageQueryTimestamp.minus(pastTime), now)
        lastUsageQueryTimestamp = now

        usageEvents?.let {
            val currentEvent = UsageEvents.Event()

            while (it.hasNextEvent()) {
                it.getNextEvent(currentEvent)

                val packageName = currentEvent.packageName
                when (currentEvent.eventType) {
                    UsageEvents.Event.ACTIVITY_RESUMED,
                    -> activeApps.add(packageName)

                    UsageEvents.Event.ACTIVITY_PAUSED,
                    UsageEvents.Event.ACTIVITY_STOPPED,
                    -> activeApps.remove(packageName)

                    else -> {}
                }
            }

            if (activeApps.isNotEmpty() && lastLaunchedApp != activeApps.first()) {
                lastLaunchedApp = activeApps.first()
                broadcastLastAppLaunchEvent()
            }
        }
    }

    /**
     * Broadcasts an event indicating the last launched app package name.
     */
    private fun broadcastLastAppLaunchEvent() {
        if (isTrackingPaused || lastLaunchedApp.isEmpty()) return
        onNewAppLaunched.invoke(lastLaunchedApp)
    }

    /**
     * Pauses or resumes app launch tracking.
     *
     * @param shouldPause True to pause tracking, false to resume.
     */
    fun pauseResumeTracking(shouldPause: Boolean) {
        isTrackingPaused = shouldPause
        if (!shouldPause) broadcastLastAppLaunchEvent()
    }

    /**
     * Detect if any app is opened in last 6 hours and it is still active.
     * Show overlay if that app is marked as distracting bedtime app.
     */
    fun detectActiveAppForBedtime() {
        findLaunchedApp(6 * 60 * 60 * 1000)
    }

    fun dispose() {
        context.unregisterReceiver(lockUnlockReceiver)
        context.unregisterReceiver(accessibilityReceiver)
        onDeviceLocked()
    }


    private inner class AccessibilityReceiver : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent?) {
            when (intent?.action) {
                ACTION_START_MANUAL_TRACKING -> {
                    isManualTrackingOn = true
                    onDeviceUnlocked()
                }

                ACTION_STOP_MANUAL_TRACKING -> {
                    isManualTrackingOn = false
                    onDeviceLocked()
                }

                ACTION_NEW_APP_LAUNCHED -> intent.getStringExtra(AppConstants.INTENT_EXTRA_PACKAGE_NAME)
                    ?.let {
                        Thread { onNewAppLaunched.invoke(it) }.start()
                    }

            }
        }
    }
}