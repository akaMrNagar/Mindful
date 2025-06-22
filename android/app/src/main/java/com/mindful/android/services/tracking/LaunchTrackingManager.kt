package com.mindful.android.services.tracking

import android.app.Service.USAGE_STATS_SERVICE
import android.app.usage.UsageEvents
import android.app.usage.UsageStatsManager
import android.content.Context
import android.util.Log
import androidx.annotation.MainThread
import androidx.annotation.WorkerThread
import com.mindful.android.receivers.AccessibilityReceiver
import com.mindful.android.receivers.DeviceLockUnlockReceiver
import com.mindful.android.services.accessibility.MindfulAccessibilityService
import com.mindful.android.utils.Utils
import java.util.concurrent.Executors
import java.util.concurrent.ScheduledExecutorService
import java.util.concurrent.ScheduledFuture
import java.util.concurrent.TimeUnit


class LaunchTrackingManager(
    private val context: Context,
    private val onNewWebEvent: (host: String) -> Unit,
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
    private val lockUnlockReceiver = DeviceLockUnlockReceiver { isUnlocked ->
        if (isUnlocked) onDeviceUnlocked() else onDeviceLocked()
    }
    private val accessibilityReceiver = AccessibilityReceiver(
        onNewWebEvent = { executorService.submit { invokeNewWebEvent(it) } },
        onNewAppLaunched = { executorService.submit { invokeNewAppLaunched(it) } },
        onServiceStatusChanged = { isActive ->
            isManualTrackingOn = !isActive
            if (isActive) onDeviceLocked() else onDeviceUnlocked()
        },
    )

    private var periodicTaskHandle: ScheduledFuture<*>? = null
    private var usageStatsManager: UsageStatsManager? = null
    private var isManualTrackingOn: Boolean = true
    private var isTrackingPaused: Boolean = false

    private var lastUsageQueryTimestamp = System.currentTimeMillis()
    private var lastLaunchedApp = ""
    private var activeApps = mutableListOf<String>()

    init {
        // Register receivers
        lockUnlockReceiver.register(context)
        accessibilityReceiver.register(context)

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
        }

        Log.d(TAG, "onDeviceUnlocked: Usage tracking started (isManual=$isManualTrackingOn)")
        executorService.submit { invokeNewAppLaunched(lastLaunchedApp) }
    }

    @MainThread
    private fun onDeviceLocked() {
        periodicTaskHandle?.cancel(true)
        periodicTaskHandle = null

        // Cancel reminders and remove overlay
        cancelReminders.invoke()
        dismissOverlay.invoke()
        Log.d(TAG, "onDeviceLocked: Usage tracking stopped")
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

        activeApps.firstOrNull()?.let {
            if (lastLaunchedApp == it) return
            invokeNewAppLaunched(it)
        }
        Log.d(TAG, "findLaunchedApp: Opened app:$lastLaunchedApp Active apps: $activeApps ")
    }

    /**
     * Check and Invoke method when new web event and tracking is not paused.
     */
    private fun invokeNewWebEvent(host: String) {
      if (isTrackingPaused) return
      onNewWebEvent.invoke(host)
    }

    /**
     * Check and Invoke method when new app is launched and tracking is not paused.
     */
    private fun invokeNewAppLaunched(packageName: String) {
        lastLaunchedApp = packageName
        if (isTrackingPaused || packageName.isEmpty()) return

        onNewAppLaunched.invoke(packageName)
    }

    fun reInvokeLastLaunchEvent() = invokeNewAppLaunched(lastLaunchedApp)

    /**
     * Pauses or resumes app launch tracking.
     *
     * @param shouldPause True to pause tracking, false to resume.
     */
    fun pauseResumeTracking(shouldPause: Boolean) {
        isTrackingPaused = shouldPause
        if (!shouldPause) invokeNewAppLaunched(lastLaunchedApp)
    }

    /**
     * Detect if any app is opened in last 6 hours and it is still active.
     * Show overlay if that app is marked as distracting bedtime app.
     */
    fun detectActiveAppForBedtime() {
        findLaunchedApp(6 * 60 * 60 * 1000)
    }

    fun dispose() {
        // Un-Register receivers
        lockUnlockReceiver.unRegister(context)
        accessibilityReceiver.unRegister(context)

        periodicTaskHandle?.cancel(true)
        executorService.shutdownNow()

        onDeviceLocked()
    }
}
