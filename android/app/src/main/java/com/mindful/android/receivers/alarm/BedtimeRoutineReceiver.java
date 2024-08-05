package com.mindful.android.receivers.alarm;

import android.app.NotificationManager;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.NonNull;

import com.mindful.android.helpers.NotificationHelper;
import com.mindful.android.helpers.AlarmTasksSchedulingHelper;
import com.mindful.android.helpers.SharedPrefsHelper;
import com.mindful.android.models.BedtimeSettings;
import com.mindful.android.services.MindfulTrackerService;

import java.util.Calendar;

public class BedtimeRoutineReceiver extends BroadcastReceiver {
    private static final String TAG = "Mindful.BedtimeStartReceiver";
    public static final String ACTION_START_BEDTIME = "com.mindful.android.StartBedtime";
    public static final String ACTION_STOP_BEDTIME = "com.mindful.android.StopBedtime";

    private boolean mCanStartRoutineToday = false;
    private Context mContext;
    private BedtimeSettings mBedtimeSettings;

    @Override
    public void onReceive(Context context, @NonNull Intent intent) {
        String action = intent.getAction();

        if (ACTION_START_BEDTIME.equals(action)) {
            init(context);
            startBedtimeRoutine();

            // Schedule bedtime stop task for today
            AlarmTasksSchedulingHelper.scheduleBedtimeStopTask(mContext);
        } else if (ACTION_STOP_BEDTIME.equals(action)) {
            init(context);
            stopBedtimeRoutine();

            // Schedule bedtime start task for next day
            AlarmTasksSchedulingHelper.scheduleBedtimeStartTask(mContext);
        }
    }

    private void init(Context context) {
        mContext = context;
        mBedtimeSettings = SharedPrefsHelper.fetchBedtimeSettings(context);

        // (dayOfWeek -1) for zero based indexing (0-6) of week days (1-7)
        int dayOfWeek = Calendar.getInstance().get(Calendar.DAY_OF_WEEK) - 1;
        mCanStartRoutineToday = mBedtimeSettings.scheduleDays.get(dayOfWeek);
    }

    private void startBedtimeRoutine() {
        if (!mCanStartRoutineToday) return;

        Intent serviceIntent = new Intent(mContext, MindfulTrackerService.class).setAction(MindfulTrackerService.ACTION_START_SERVICE_BEDTIME_MODE);
        mContext.startService(serviceIntent);

        // Start DND if needed
        if (mBedtimeSettings.shouldStartDnd) toggleDnd(true);
        NotificationHelper.pushAlertNotification(mContext, 444, "It's time to bed, bedtime routine is started");
    }

    private void stopBedtimeRoutine() {
        Intent serviceIntent = new Intent(mContext, MindfulTrackerService.class).setAction(MindfulTrackerService.ACTION_STOP_SERVICE_BEDTIME_MODE);
        mContext.startService(serviceIntent);

        // Stop DND if needed
        if (mBedtimeSettings.shouldStartDnd) toggleDnd(false);
        NotificationHelper.pushAlertNotification(mContext, 496, "It's time to wake up, bedtime is over");
    }


    private void toggleDnd(boolean shouldStart) {
        NotificationManager notificationManager = (NotificationManager) mContext.getSystemService(Context.NOTIFICATION_SERVICE);

        // Check if permission for DND mode is granted
        if (notificationManager.isNotificationPolicyAccessGranted()) {
            if (shouldStart) {
                notificationManager.setInterruptionFilter(NotificationManager.INTERRUPTION_FILTER_PRIORITY);
                Log.d(TAG, "toggleDnd: DND mode started");
            } else {
                notificationManager.setInterruptionFilter(NotificationManager.INTERRUPTION_FILTER_ALL);
                Log.d(TAG, "toggleDnd: DND mode stopped");
            }
        } else {
            Log.d(TAG, "toggleDnd: Do not have permission to modify DND mode");
            Toast.makeText(mContext, "Please allow do not disturb access to Mindful", Toast.LENGTH_SHORT).show();
        }
    }
}