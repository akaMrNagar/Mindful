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
package com.mindful.android.receivers.alarm

import android.app.NotificationManager
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log
import androidx.core.app.NotificationCompat
import androidx.work.Data
import androidx.work.ExistingWorkPolicy
import androidx.work.OneTimeWorkRequest
import androidx.work.WorkManager
import androidx.work.Worker
import androidx.work.WorkerParameters
import com.mindful.android.R
import com.mindful.android.generics.SafeServiceConnection
import com.mindful.android.helpers.AlarmTasksSchedulingHelper.ALARM_EXTRA_JSON
import com.mindful.android.helpers.AlarmTasksSchedulingHelper.scheduleBedtimeRoutineTasks
import com.mindful.android.helpers.device.NotificationHelper
import com.mindful.android.helpers.storage.SharedPrefsHelper
import com.mindful.android.models.BedtimeSettings
import com.mindful.android.services.tracking.MindfulTrackerService
import com.mindful.android.utils.AppConstants
import com.mindful.android.utils.ThreadUtils
import com.mindful.android.utils.Utils
import org.json.JSONObject
import java.util.Calendar

class BedtimeRoutineReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        when (intent.action) {
            ACTION_ALERT_BEDTIME, ACTION_START_BEDTIME, ACTION_STOP_BEDTIME -> {
                /// Schedule worker
                WorkManager.getInstance(context).enqueueUniqueWork(
                    TAG,
                    ExistingWorkPolicy.KEEP,
                    OneTimeWorkRequest.Builder(BedtimeRoutineWorker::class.java)
                        .setInputData(
                            Data.Builder()
                                .putString("action", intent.action)
                                .putString(
                                    ALARM_EXTRA_JSON,
                                    intent.extras?.getString(ALARM_EXTRA_JSON) ?: ""
                                )
                                .build()
                        )
                        .build()
                )
            }
        }
    }


    class BedtimeRoutineWorker(
        private val context: Context,
        params: WorkerParameters,
    ) : Worker(context, params) {
        private val jsonBedtimeSettings = inputData.getString(ALARM_EXTRA_JSON) ?: ""
        private val bedtimeSettings = BedtimeSettings(JSONObject(jsonBedtimeSettings))
        private val trackerServiceConn = SafeServiceConnection(
            MindfulTrackerService::class.java, context
        )

        private val canStartRoutineToday: Boolean

        init {
            // (dayOfWeek -1) for zero based indexing (0-6) of week days (1-7)
            val dayOfWeek = Calendar.getInstance()[Calendar.DAY_OF_WEEK] - 1
            this.canStartRoutineToday = bedtimeSettings.scheduleDays[dayOfWeek]
        }


        override fun doWork(): Result {
            try {
                val action = inputData.getString("action")

                when (action) {
                    ACTION_ALERT_BEDTIME -> pushAlertNotification(context.getString(R.string.bedtime_upcoming_notification_info))
                    ACTION_START_BEDTIME -> startBedtimeRoutine()
                    ACTION_STOP_BEDTIME -> {
                        stopBedtimeRoutine()

                        // Reschedule bedtime tasks for next day
                        ThreadUtils.runOnMainThread(1000L) {
                            scheduleBedtimeRoutineTasks(
                                context,
                                jsonBedtimeSettings
                            )
                        }
                    }
                }
                return Result.success()
            } catch (e: Exception) {
                Log.e(TAG, "doWork: Error during work execution", e)
                SharedPrefsHelper.insertCrashLogToPrefs(context, e)
                return Result.failure()
            } finally {
                // Unbind service
                trackerServiceConn.unBindService()
            }
        }

        private fun startBedtimeRoutine() {
            if (!canStartRoutineToday) return
            trackerServiceConn.setOnConnectedCallback { service: MindfulTrackerService ->
                service.getRestrictionManager.updateBedtimeApps(bedtimeSettings.distractingApps)
            }
            trackerServiceConn.startAndBind()

            // Start DND if needed
            if (bedtimeSettings.shouldStartDnd) NotificationHelper.toggleDnd(context, true)
            pushAlertNotification(context.getString(R.string.bedtime_started_notification_info))
        }

        private fun stopBedtimeRoutine() {
            trackerServiceConn.setOnConnectedCallback { service: MindfulTrackerService ->
                service.getRestrictionManager.updateBedtimeApps(
                    null
                )
            }
            trackerServiceConn.bindService()

            // Stop DND if needed
            if (bedtimeSettings.shouldStartDnd) NotificationHelper.toggleDnd(context, false)
            pushAlertNotification(context.getString(R.string.bedtime_ended_notification_info))
        }


        private fun pushAlertNotification(alert: String) {
            val notificationManager =
                context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.notify(
                AppConstants.BEDTIME_ROUTINE_NOTIFICATION_ID,
                NotificationCompat.Builder(
                    context,
                    NotificationHelper.NOTIFICATION_BEDTIME_CHANNEL_ID
                )
                    .setSmallIcon(R.drawable.ic_notification)
                    .setOngoing(false)
                    .setOnlyAlertOnce(true)
                    .setContentIntent(Utils.getPendingIntentForMindful(context))
                    .setContentTitle(context.getString(R.string.app_name))
                    .setContentText(alert)
                    .setStyle(NotificationCompat.BigTextStyle().bigText(alert))
                    .build()
            )
        }
    }

    companion object {
        private const val TAG = "Mindful.BedtimeRoutineReceiver"

        const val ACTION_ALERT_BEDTIME: String =
            "com.mindful.android.BedtimeRoutineReceiver.AlertBedtime"

        const val ACTION_START_BEDTIME: String =
            "com.mindful.android.BedtimeRoutineReceiver.StartBedtime"

        const val ACTION_STOP_BEDTIME: String =
            "com.mindful.android.BedtimeRoutineReceiver.StopBedtime"
    }
}