package com.mindful.android.services.tracking

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
import com.mindful.android.services.accessibility.MindfulAccessibilityService
import com.mindful.android.services.accessibility.TrackingManager.Companion.ACTION_NEW_APP_LAUNCHED
import com.mindful.android.services.accessibility.TrackingManager.Companion.ACTION_START_MANUAL_TRACKING
import com.mindful.android.services.accessibility.TrackingManager.Companion.ACTION_STOP_MANUAL_TRACKING
import com.mindful.android.services.accessibility.TrackingManager.Companion.EXTRA_PACKAGE_NAME
import com.mindful.android.utils.Utils
import java.util.concurrent.Executors
import java.util.concurrent.ScheduledExecutorService
import java.util.concurrent.ScheduledFuture
import java.util.concurrent.TimeUnit


class LaunchTrackingManager(
    private val context: Context,
    private val onNewAppLaunched: (packageName: String) -> Unit,
    private val dismissOverlay: () -> Unit,
    private val cancelReminders: () -> Unit,
) {
    companion object {
        private const val TAG = "Mindful.LaunchTrackingManager"

        // Interval for tracking app launches in milliseconds
        private const val TIMER_RATE: Long = 750
    }

    private val executorService: ScheduledExecutorService = Executors.newScheduledThreadPool(2)
    private val accessibilityReceiver: AccessibilityReceiver = AccessibilityReceiver()
    private val lockUnlockReceiver: DeviceLockUnlockReceiver =
        DeviceLockUnlockReceiver { isUnlocked ->
            if (isUnlocked) onDeviceUnlocked()
            else onDeviceLocked()
        }

    private var periodicTaskHandle: ScheduledFuture<*>? = null
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


        // Start tracking
        onDeviceUnlocked()
    }


    @MainThread
    private fun onDeviceUnlocked() {
        // Check if accessibility is already running
        isManualTrackingOn =
            !Utils.isServiceRunning(context, MindfulAccessibilityService::class.java)

        // Start tracking manually only if accessibility is not running
        if (isManualTrackingOn) {
            // First cancel earlier task if already not cancelled
            periodicTaskHandle?.cancel(true)

            // Schedule new task
            periodicTaskHandle = executorService.scheduleWithFixedDelay(
                { findLaunchedApp() },
                0L,
                TIMER_RATE,
                TimeUnit.MILLISECONDS
            )

            Log.d(TAG, "onDeviceUnlocked: Manual usage tracking started")
        }

        executorService.submit { invokeNewAppLaunched() }
    }

    @MainThread
    private fun onDeviceLocked() {
        periodicTaskHandle?.cancel(true)
        periodicTaskHandle = null

        // Cancel reminders and remove overlay
        cancelReminders.invoke()
        dismissOverlay.invoke()
        Log.d(TAG, "onDeviceLocked: Manual usage tracking stopped")
    }

    /**
     * Detect if any app is opened using usage states.
     * @param msInPastFromLastCheck  past millis from the last check
     */
    @WorkerThread
    private fun findLaunchedApp(msInPastFromLastCheck: Long = 0L) {
        // Initialize usage states manager
        if (usageStatsManager == null) {
            usageStatsManager =
                context.getSystemService(USAGE_STATS_SERVICE) as UsageStatsManager
        }

        val timeNow = System.currentTimeMillis()
        val start = lastUsageQueryTimestamp - msInPastFromLastCheck
        lastUsageQueryTimestamp = timeNow

        val usageEvents = usageStatsManager?.queryEvents(start, timeNow)
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
        }

        activeApps.lastOrNull()?.let {
            if (lastLaunchedApp == it) return@let

            lastLaunchedApp = it
            invokeNewAppLaunched()
        }
    }

    /**
     * Broadcasts an event indicating the last launched app package name.
     */
    private fun invokeNewAppLaunched() {
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
        if (!shouldPause) invokeNewAppLaunched()
    }

    /**
     * Detect if any app is opened in last 6 hours and it is still active.
     * Show overlay if that app is marked as distracting bedtime app.
     */
    fun detectActiveAppForBedtime() {
        findLaunchedApp(6 * 60 * 60 * 1000)
    }

    fun dispose() {
        periodicTaskHandle?.cancel(true)
        executorService.shutdownNow()
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

                ACTION_NEW_APP_LAUNCHED ->
                    intent.getStringExtra(EXTRA_PACKAGE_NAME)?.let {
                        executorService.submit { onNewAppLaunched(it) }
                    }
            }
        }
    }
}