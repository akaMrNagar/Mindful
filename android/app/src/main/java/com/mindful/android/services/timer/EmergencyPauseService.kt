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
package com.mindful.android.services.timer

import android.app.Service
import android.content.Intent
import android.os.IBinder
import android.util.Log
import com.mindful.android.R
import com.mindful.android.generics.SafeServiceConnection
import com.mindful.android.generics.ServiceBinder
import com.mindful.android.helpers.device.NotificationHelper.NOTIFICATION_CRITICAL_CHANNEL_ID
import com.mindful.android.helpers.storage.SharedPrefsHelper
import com.mindful.android.services.tracking.MindfulTrackerService
import com.mindful.android.utils.AppConstants.EMERGENCY_PAUSE_SERVICE_NOTIFICATION_ID
import com.mindful.android.utils.Utils

class EmergencyPauseService : Service() {
    private lateinit var mNotificationTimer: NotificationTimer
    private lateinit var mTrackerServiceConn: SafeServiceConnection<MindfulTrackerService>

    override fun onCreate() {
        super.onCreate()
        mTrackerServiceConn = SafeServiceConnection(MindfulTrackerService::class.java, this)
        mNotificationTimer = NotificationTimer(
            context = this,
            title = getString(R.string.emergency_pause_notification_title),
            timerDurationSeconds = DEFAULT_EMERGENCY_PASS_PERIOD_SECONDS,
            notificationId = EMERGENCY_PAUSE_SERVICE_NOTIFICATION_ID,
            notificationChannelId = NOTIFICATION_CRITICAL_CHANNEL_ID,
            onTicked = { remainingTime ->
                getString(
                    R.string.emergency_pause_notification_info,
                    Utils.secondsToTimeStr(remainingTime)
                )
            },
            onFinished = { getString(R.string.emergency_pause_ended_notification_info) },
            onDispose = {
                Log.d(
                    TAG,
                    "startEmergencyTimer: Emergency pause is over. App blocker is resumed successfully"
                )
                stopSelf()
            }
        )
    }

    override fun onStartCommand(intent: Intent, flags: Int, startId: Int): Int {
        if (intent.action == ServiceBinder.ACTION_START_MINDFUL_SERVICE) {
            startEmergencyTimer()
            return START_STICKY
        }

        stopSelf()
        return START_NOT_STICKY
    }

    private fun startEmergencyTimer() {
        try {
            startForeground(
                EMERGENCY_PAUSE_SERVICE_NOTIFICATION_ID,
                mNotificationTimer.getInitialNotification
            )

            mTrackerServiceConn.setOnConnectedCallback { service: MindfulTrackerService ->
                service.getLaunchTrackingManager.pauseResumeTracking(true)
            }
            mTrackerServiceConn.bindService()
            mNotificationTimer.startTimer()
            Log.d(TAG, "startEmergencyTimer: EMERGENCY service started successfully")
        } catch (e: Exception) {
            Log.d(TAG, "startEmergencyTimer: Failed to start EMERGENCY service: ", e)
            SharedPrefsHelper.insertCrashLogToPrefs(this, e)
            stopSelf()
        }
    }


    override fun onDestroy() {
        super.onDestroy()
        mTrackerServiceConn.service?.getLaunchTrackingManager?.pauseResumeTracking(false)
        mTrackerServiceConn.unBindService()
        stopForeground(STOP_FOREGROUND_DETACH)
        Log.d(TAG, "onDestroy: EMERGENCY service destroyed successfully")
    }

    override fun onBind(intent: Intent): IBinder? {
        return null
    }

    companion object {
        private const val DEFAULT_EMERGENCY_PASS_PERIOD_SECONDS: Long = 5 * 60L
        private const val TAG = "Mindful.EmergencyPauseService"
    }
}