package com.mindful.android.services.tracking

import android.app.Service
import android.content.Intent
import android.os.IBinder
import android.util.Log
import androidx.annotation.WorkerThread
import com.mindful.android.R
import com.mindful.android.generics.ServiceBinder
import com.mindful.android.helpers.device.NotificationHelper
import com.mindful.android.helpers.storage.SharedPrefsHelper
import com.mindful.android.utils.AppConstants

class MindfulTrackerService : Service() {
    companion object {
        private const val TAG = "Mindful.MindfulTrackerService"
    }

    private val mBinder = ServiceBinder(this@MindfulTrackerService)

    private lateinit var overlayManager: OverlayManager
    private lateinit var reminderManager: ReminderManager

    private lateinit var restrictionManager: RestrictionManager
    val getRestrictionManager get() = restrictionManager

    private lateinit var launchTrackingManager: LaunchTrackingManager
    val getLaunchTrackingManager get() = launchTrackingManager


    override fun onCreate() {
        overlayManager = OverlayManager(this)
        reminderManager = ReminderManager(overlayManager, ::onNewAppLaunch)
        restrictionManager = RestrictionManager(this, ::stopIfNoUsage)
        launchTrackingManager = LaunchTrackingManager(this, ::onNewAppLaunch)
        super.onCreate()
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {

        if (intent?.action == ServiceBinder.ACTION_START_MINDFUL_SERVICE) {
            startFgService()
            return START_STICKY
        }

        stopIfNoUsage()
        return START_NOT_STICKY
    }

    private fun startFgService() {
        try {
            val notification = NotificationHelper.buildFgServiceNotification(
                this,
                getString(R.string.app_blocker_running_notification_info)
            )
            startForeground(AppConstants.TRACKER_SERVICE_NOTIFICATION_ID, notification)
            Log.d(TAG, "startFgService: TRACKER service started successfully")
        } catch (e: Exception) {
            Log.e(TAG, "startFgService: Failed to start TRACKER service", e)
            SharedPrefsHelper.insertCrashLogToPrefs(this, e)
            stopIfNoUsage()
        }
    }

    fun onMidnightReset() {
        restrictionManager.resetCache()
//        overlayManager.dismissOverlay()
//        reminderManager.cancelReminders()
    }


    @WorkerThread
    private fun onNewAppLaunch(packageName: String) {
        try {

            /// Cancel previous reminders and dismiss overlay
            reminderManager.cancelReminders()
            overlayManager.dismissOverlay()

            /// check current restrictions
        val currentOrFutureState = restrictionManager.isAppRestricted(packageName)

            Log.d(TAG, "onNewAppLaunch: $packageName's evaluated state $currentOrFutureState")
            currentOrFutureState?.let {

                /// Already restricted
                if (it.expirationFutureMs <= 0L) {
                    overlayManager.showOverlay(
                        packageName = packageName,
                        restrictionState = it
                    )
                }
                /// Under limit but will be exhausted in some time
                else {
                    reminderManager.scheduleReminders(
                        packageName = packageName,
                        state = it,
                    )
                }
            }
        } catch (e: Exception) {
            SharedPrefsHelper.insertCrashLogToPrefs(this, e)
            Log.e(TAG, "onNewAppLaunch: Failed to process new app launch event", e)
        }
    }

    private fun stopIfNoUsage() {
        if (restrictionManager.isIdle) {
            Log.d(TAG, "Service no longer needed, stopping")
            launchTrackingManager.dispose()
            reminderManager.cancelReminders()
            overlayManager.dismissOverlay()
            stopForeground(STOP_FOREGROUND_REMOVE)
            stopSelf()
        }
    }

    override fun onDestroy() {
        Log.d(TAG, "onDestroy: TRACKER service destroyed successfully")
        super.onDestroy()
    }


    override fun onBind(intent: Intent): IBinder? {
        return if (intent.action == ServiceBinder.ACTION_BIND_TO_MINDFUL) mBinder else null
    }
}