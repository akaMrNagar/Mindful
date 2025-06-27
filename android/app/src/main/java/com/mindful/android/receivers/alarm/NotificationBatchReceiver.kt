package com.mindful.android.receivers.alarm

import android.app.NotificationManager
import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log
import androidx.core.app.NotificationCompat
import androidx.core.app.Person
import androidx.core.graphics.drawable.toBitmap
import androidx.work.Data
import androidx.work.ExistingWorkPolicy
import androidx.work.OneTimeWorkRequest
import androidx.work.WorkManager
import androidx.work.Worker
import androidx.work.WorkerParameters
import com.mindful.android.AppConstants
import com.mindful.android.R
import com.mindful.android.generics.SafeServiceConnection
import com.mindful.android.helpers.AlarmTasksSchedulingHelper.scheduleNotificationBatchTask
import com.mindful.android.helpers.device.NotificationHelper
import com.mindful.android.helpers.storage.DriftDbHelper
import com.mindful.android.helpers.storage.SharedPrefsHelper
import com.mindful.android.models.Notification
import com.mindful.android.models.NotificationSettings
import com.mindful.android.services.notification.MindfulNotificationListenerService
import com.mindful.android.utils.AppUtils

class NotificationBatchReceiver : BroadcastReceiver() {
    companion object {
        private const val TAG = "Mindful.NotificationBatchReceiver"
        const val ACTION_PUSH_BATCH: String = "com.mindful.android.action.PushBatch"
        const val EXTRA_NOTIFICATION_SETTINGS_JSON =
            "com.mindful.android.extra.notificationSettingsJson"
    }

    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action == ACTION_PUSH_BATCH) {
            WorkManager.getInstance(context).enqueueUniqueWork(
                TAG, ExistingWorkPolicy.KEEP,
                OneTimeWorkRequest.Builder(NotificationBatchWorker::class.java)
                    .setInputData(
                        Data.Builder().putString(
                            EXTRA_NOTIFICATION_SETTINGS_JSON,
                            intent.extras?.getString(EXTRA_NOTIFICATION_SETTINGS_JSON) ?: ""
                        ).build()
                    ).build()
            )
        }
    }

    class NotificationBatchWorker(
        private val context: Context,
        private val params: WorkerParameters,
    ) : Worker(context, params) {
        private val notificationServiceConn = SafeServiceConnection(
            context = context,
            serviceClass = MindfulNotificationListenerService::class.java,
        )

        override fun doWork(): Result {
            try {
                val settings = NotificationSettings.fromJson(
                    params.inputData.getString(EXTRA_NOTIFICATION_SETTINGS_JSON) ?: ""
                )

                // Fetch unread notifications
                val notifications = DriftDbHelper(context).fetchLast24HourUnreadNotifications()
                if (notifications.isNotEmpty()) {
                    if (settings.recapSummeryOnly) pushSummeryNotification(notifications.size)
                    else pushAllUnreadNotifications(notifications)
                }

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
                    params.inputData.getString(EXTRA_NOTIFICATION_SETTINGS_JSON) ?: "",
                )
            }
        }


        private fun pushSummeryNotification(unreadNotificationsCount: Int) {
            // Create pending intent
            val mindfulPendingIntent = AppUtils.getPendingIntentForMindfulUri(
                context,
                "com.mindful.android://open/notifications"
            )

            // Build notification
            val msg = context.getString(
                R.string.notification_schedule_batch_summery,
                unreadNotificationsCount
            )
            val notification = NotificationCompat.Builder(
                context,
                NotificationHelper.NOTIFICATION_BATCHING_CHANNEL_ID
            )
                .setSmallIcon(R.drawable.ic_mindful_notification)
                .setAutoCancel(true)
                .setContentTitle(context.getString(R.string.notification_schedule_batch_title))
                .setContentIntent(mindfulPendingIntent)
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
        }


        private fun pushAllUnreadNotifications(notifications: List<Notification>) {
            try {
                notificationServiceConn.bindService()
                val mindfulIntent = AppUtils.getPendingIntentForMindfulUri(
                    context,
                    "com.mindful.android://open/notifications"
                )
                val notificationManager =
                    context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

                // Group notifications by app package
                val appGroupedNotifications = notifications.groupBy { it.packageName }
                for ((packageName, appNotifications) in appGroupedNotifications) {
                    val appInfo = context.packageManager.getApplicationInfo(packageName, 0)
                    val appName = context.packageManager.getApplicationLabel(appInfo).toString()
                    val appIcon = context.packageManager.getApplicationIcon(appInfo).toBitmap()
                    val appIntent = runCatching {
                        PendingIntent.getActivity(
                            context,
                            0,
                            context.packageManager.getLaunchIntentForPackage(packageName),
                            PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
                        )
                    }.getOrNull()

                    // 1. Push messaging-style notifications for each thread
                    // Group by conversation thread key
                    val threadGrouped = appNotifications.groupBy { it.key }
                    for ((threadKey, threadNotifications) in threadGrouped) {
                        val person = Person.Builder()
                            .setName(threadNotifications.firstOrNull()?.title ?: "Unknown")
                            .build()

                        val messagingStyle = NotificationCompat.MessagingStyle(person)
                            .setConversationTitle(threadNotifications.firstOrNull()?.title)
                            .also { message ->
                                threadNotifications.sortedBy { it.timeStamp }.forEach {
                                    message.addMessage(it.content, it.timeStamp, person)
                                }
                            }

                        val pendingIntent =
                            notificationServiceConn.service?.getPendingIntentForKey(threadKey)
                                ?: appIntent
                                ?: mindfulIntent

                        val notification = NotificationCompat.Builder(
                            context,
                            NotificationHelper.CRITICAL_CHANNEL_ID
                        )
                            .setSmallIcon(R.drawable.ic_mindful_notification)
                            .setLargeIcon(appIcon)
                            .setContentTitle(appName)
                            .setGroup(packageName)
                            .setGroupAlertBehavior(NotificationCompat.GROUP_ALERT_SUMMARY)
                            .setStyle(messagingStyle)
                            .setAutoCancel(true)
                            .setContentIntent(pendingIntent)
                            .setWhen(
                                threadNotifications.lastOrNull()?.timeStamp
                                    ?: System.currentTimeMillis()
                            )
                            .build()

                        notificationManager.notify(
                            (packageName + threadKey).hashCode(),
                            notification
                        )
                    }

                    // 2. App-level group summary notification
                    val summaryStyle = NotificationCompat.InboxStyle().also { inbox ->
                        threadGrouped.forEach { (_, threadNotifs) ->
                            threadNotifs.maxByOrNull { it.timeStamp }?.let {
                                inbox.addLine("${it.title}: ${it.content}")
                            }
                        }

                        inbox.setSummaryText(appName)
                    }

                    val summaryNotification = NotificationCompat.Builder(
                        context,
                        NotificationHelper.NOTIFICATION_BATCHING_CHANNEL_ID
                    )
                        .setSmallIcon(R.drawable.ic_mindful_notification)
                        .setStyle(summaryStyle)
                        .setGroup(packageName)
                        .setGroupSummary(true)
                        .setGroupAlertBehavior(NotificationCompat.GROUP_ALERT_SUMMARY)
                        .setAutoCancel(true)
                        .build()

                    notificationManager.notify(packageName.hashCode(), summaryNotification)
                }

                // Mark all notifications as read
                DriftDbHelper(context).markNotificationsAsRead(notifications.mapNotNull { it.id })

            } catch (e: Exception) {
                Log.e(
                    TAG,
                    "pushAllUnreadNotifications: Failed to push batched unread notifications",
                    e
                )
                SharedPrefsHelper.insertCrashLogToPrefs(context, e)
            }
        }
    }
}
