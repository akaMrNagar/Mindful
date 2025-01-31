package com.mindful.android.receivers.alarm

import android.app.NotificationManager
import android.app.PendingIntent
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
import com.mindful.android.MainActivity
import com.mindful.android.R
import com.mindful.android.helpers.AlarmTasksSchedulingHelper.ALARM_EXTRA_JSON
import com.mindful.android.helpers.AlarmTasksSchedulingHelper.scheduleNotificationBatchTask
import com.mindful.android.helpers.device.NotificationHelper
import com.mindful.android.helpers.storage.SharedPrefsHelper
import com.mindful.android.utils.AppConstants
import com.mindful.android.workers.FlutterBgExecutionWorker.Companion.FLUTTER_TASK_ID
import org.json.JSONArray

class NotificationBatchReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action == ACTION_PUSH_BATCH) {
            WorkManager.getInstance(context).enqueueUniqueWork(
                TAG, ExistingWorkPolicy.KEEP,
                OneTimeWorkRequest.Builder(NotificationBatchWorker::class.java)
                    .setInputData(
                        Data.Builder().putString(
                            ALARM_EXTRA_JSON,
                            intent.extras?.getString(ALARM_EXTRA_JSON) ?: ""
                        ).build()
                    ).build()
            )
        }
    }

    class NotificationBatchWorker(
        private val context: Context,
        private val params: WorkerParameters,
    ) : Worker(context, params) {
        override fun doWork(): Result {
            try {
                // Return if no available notifications
                val jsonStr = SharedPrefsHelper.getSerializedNotificationsJson(context)
                val notificationsCount = JSONArray(jsonStr).length()
                if (notificationsCount == 0) return Result.success()

                // Create pending intent
                val appIntent = Intent(applicationContext, MainActivity::class.java)
                    .setFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    .putExtra(
                        AppConstants.INTENT_EXTRA_INITIAL_ROUTE,
                        "/upcomingNotificationsScreen"
                    )
                val pendingIntent = PendingIntent.getActivity(
                    applicationContext,
                    0,
                    appIntent,
                    PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
                )


                // Build notification
                val msg = context.getString(
                    R.string.notification_schedule_notification_info,
                    notificationsCount
                )
                val notification = NotificationCompat.Builder(
                    context,
                    NotificationHelper.NOTIFICATION_CRITICAL_CHANNEL_ID
                )
                    .setSmallIcon(R.drawable.ic_notification)
                    .setAutoCancel(true)
                    .setContentTitle(context.getString(R.string.app_name))
                    .setContentIntent(pendingIntent)
                    .setContentText(msg)
                    .setStyle(NotificationCompat.BigTextStyle().bigText(msg))
                    .build()

                // Push notification
                val notificationManager =
                    context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
                notificationManager.notify(
                    AppConstants.NOTIFICATION_BATCH_SCHEDULE_NOTIFICATION_ID,
                    notification
                )
                Log.d(TAG, "doWork: Notification batch work completed successfully")
                return Result.success()
            } catch (e: Exception) {
                Log.e(TAG, "doWork: Error during work execution", e)
                SharedPrefsHelper.insertCrashLogToPrefs(context, e)
                return Result.failure()
            } finally {
                // schedule next possible task
                scheduleNotificationBatchTask(
                    context,
                    params.inputData.getString(ALARM_EXTRA_JSON) ?: "",
                )
            }
        }
    }

    companion object {
        private const val TAG = "Mindful.NotificationBatchReceiver"

        const val ACTION_PUSH_BATCH: String =
            "com.mindful.android.NotificationBatchReceiver.PushBatch"
    }
}
