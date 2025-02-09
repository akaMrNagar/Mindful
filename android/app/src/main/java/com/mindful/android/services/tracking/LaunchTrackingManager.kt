package com.mindful.android.services.tracking

import android.app.Service.USAGE_STATS_SERVICE
import android.app.usage.UsageEvents
import android.app.usage.UsageStatsManager
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.content.SharedPreferences
import android.content.SharedPreferences.OnSharedPreferenceChangeListener
import android.util.Log
import androidx.annotation.MainThread
import androidx.annotation.WorkerThread
import com.mindful.android.receivers.DeviceLockUnlockReceiver
import java.util.concurrent.Executors
import java.util.concurrent.ScheduledExecutorService
import java.util.concurrent.TimeUnit


class LaunchTrackingManager(
    private val context: Context,
    private val onNewAppLaunched: (packageName: String) -> Unit,
) : OnSharedPreferenceChangeListener {
    companion object {
        private const val TAG = "Mindful.LaunchTrackingManager"

        // Interval for tracking app launches in milliseconds
        private const val TIMER_RATE: Long = 500
    }

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
    private var lastLaunchedApp = ""

    init {
        // Register lock/unlock receiver
        val lockUnlockFilter = IntentFilter()
        lockUnlockFilter.addAction(Intent.ACTION_USER_PRESENT)
        lockUnlockFilter.addAction(Intent.ACTION_SCREEN_OFF)
        context.registerReceiver(lockUnlockReceiver, lockUnlockFilter)

        // Start tracking
        onDeviceUnlocked()
    }


    @MainThread
    private fun onDeviceUnlocked() {
        // TODO: Use accessibility for tracking if permission is granted to improve battery health.
        if (isManualTrackingOn) {
            // First cancel earlier task if already not cancelled
            trackingExecutor?.shutdownNow()
            trackingExecutor = Executors.newScheduledThreadPool(1)

            // Initialize usage states manager
            if (usageStatsManager == null) {
                usageStatsManager =
                    context.getSystemService(USAGE_STATS_SERVICE) as UsageStatsManager
            }

            // Schedule new task
            trackingExecutor?.scheduleWithFixedDelay(
                { findLaunchedApp() },
                0L,
                TIMER_RATE,
                TimeUnit.MILLISECONDS
            )

            Log.d(TAG, "onDeviceUnlocked: Usage tracking started")
            Thread { broadcastLastAppLaunchEvent() }.start()
        }
    }

    @MainThread
    private fun onDeviceLocked() {
        trackingExecutor?.shutdownNow()
        trackingExecutor = null

        Log.d(TAG, "onDeviceLocked: Usage tracking stopped")
    }

    @WorkerThread
    private fun findLaunchedApp(interval: Long = TIMER_RATE * 2) {
        val now = System.currentTimeMillis()
        val usageEvents = usageStatsManager?.queryEvents(now.minus(interval), now)

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
        onDeviceLocked()
    }

    override fun onSharedPreferenceChanged(sharedPreferences: SharedPreferences?, key: String?) {
        TODO("Not yet implemented")
    }
}