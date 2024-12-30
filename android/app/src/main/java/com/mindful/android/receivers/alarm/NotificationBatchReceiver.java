package com.mindful.android.receivers.alarm;

import static com.mindful.android.helpers.NotificationHelper.NOTIFICATION_CRITICAL_CHANNEL_ID;
import static com.mindful.android.utils.AppConstants.INTENT_EXTRA_INITIAL_ROUTE;
import static com.mindful.android.utils.AppConstants.NOTIFICATION_BATCH_SCHEDULE_NOTIFICATION_ID;

import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.core.app.NotificationCompat;
import androidx.work.ExistingWorkPolicy;
import androidx.work.OneTimeWorkRequest;
import androidx.work.WorkManager;
import androidx.work.Worker;
import androidx.work.WorkerParameters;

import com.mindful.android.MainActivity;
import com.mindful.android.R;
import com.mindful.android.helpers.AlarmTasksSchedulingHelper;
import com.mindful.android.helpers.SharedPrefsHelper;
import com.mindful.android.utils.AppConstants;
import com.mindful.android.utils.Utils;

import org.json.JSONArray;

import java.util.HashSet;

public class NotificationBatchReceiver extends BroadcastReceiver {
    private static final String TAG = "Mindful.NotificationBatchReceiver";
    public static final String ACTION_PUSH_BATCH = "com.mindful.android.NotificationBatchReceiver.PushBatch";

    @Override
    public void onReceive(Context context, Intent intent) {
        if (ACTION_PUSH_BATCH.equals(Utils.getActionFromIntent(intent))) {
            WorkManager.getInstance(context).enqueueUniqueWork(TAG, ExistingWorkPolicy.KEEP, new OneTimeWorkRequest.Builder(NotificationBatchWorker.class).build());
        }
    }

    public static class NotificationBatchWorker extends Worker {
        private final Context mContext;

        public NotificationBatchWorker(@NonNull Context context, @NonNull WorkerParameters params) {
            super(context, params);
            this.mContext = context;
        }


        @NonNull
        @Override
        public Result doWork() {
            try {
                // Return if no available notifications
                String jsonStr = SharedPrefsHelper.getUpComingNotificationsArrayString(mContext);
                int notificationsCount = new JSONArray(jsonStr).length();
                if (notificationsCount == 0) return Result.success();

                // Create pending intent
                Intent appIntent = new Intent(getApplicationContext(), MainActivity.class)
                        .setFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                        .putExtra(INTENT_EXTRA_INITIAL_ROUTE, "/upcomingNotificationsScreen");
                PendingIntent pendingIntent = PendingIntent.getActivity(getApplicationContext(), 0, appIntent, PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_IMMUTABLE);


                // Build notification
                String msg = mContext.getString(R.string.notification_schedule_notification_info, notificationsCount);
                Notification notification = new NotificationCompat.Builder(mContext, NOTIFICATION_CRITICAL_CHANNEL_ID)
                        .setSmallIcon(R.drawable.ic_notification)
                        .setAutoCancel(true)
                        .setContentTitle(mContext.getString(R.string.app_name))
                        .setContentIntent(pendingIntent)
                        .setContentText(msg)
                        .setStyle(new NotificationCompat.BigTextStyle().bigText(msg))
                        .build();

                // Push notification
                NotificationManager notificationManager = (NotificationManager) mContext.getSystemService(Context.NOTIFICATION_SERVICE);
                notificationManager.notify(NOTIFICATION_BATCH_SCHEDULE_NOTIFICATION_ID, notification);
                Log.d(TAG, "doWork: Notification batch work completed successfully");
                return Result.success();
            } catch (Exception e) {
                Log.e(TAG, "doWork: Error during work execution", e);
                SharedPrefsHelper.insertCrashLogToPrefs(mContext, e);
                return Result.failure();
            } finally {
                // schedule next possible task
                HashSet<Integer> todMinutes = SharedPrefsHelper.getSetNotificationBatchSchedules(mContext, null);
                AlarmTasksSchedulingHelper.scheduleNotificationBatchTask(mContext, todMinutes);
            }
        }
    }
}
