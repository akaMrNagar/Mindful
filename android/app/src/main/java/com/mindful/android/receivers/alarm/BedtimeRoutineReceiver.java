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

package com.mindful.android.receivers.alarm;

import static com.mindful.android.utils.AppConstants.BEDTIME_ROUTINE_NOTIFICATION_ID;

import android.app.NotificationManager;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

import androidx.annotation.NonNull;
import androidx.core.app.NotificationCompat;

import com.mindful.android.R;
import com.mindful.android.helpers.AlarmTasksSchedulingHelper;
import com.mindful.android.helpers.NotificationHelper;
import com.mindful.android.helpers.SharedPrefsHelper;
import com.mindful.android.models.BedtimeSettings;
import com.mindful.android.services.MindfulTrackerService;
import com.mindful.android.utils.Utils;

import java.util.Calendar;

public class BedtimeRoutineReceiver extends BroadcastReceiver {
    public static final String ACTION_START_BEDTIME = "com.mindful.android.StartBedtime";
    public static final String ACTION_STOP_BEDTIME = "com.mindful.android.StopBedtime";

    private boolean mCanStartRoutineToday = false;
    private Context mContext;
    private BedtimeSettings mBedtimeSettings;

    @Override
    public void onReceive(Context context, @NonNull Intent intent) {
        String action = Utils.getActionFromIntent(intent);

        if (ACTION_START_BEDTIME.equals(action)) {
            init(context);
            startBedtimeRoutine();

            // Schedule bedtime stop task for today
            AlarmTasksSchedulingHelper.scheduleBedtimeStopTask(mContext, mBedtimeSettings);
        } else if (ACTION_STOP_BEDTIME.equals(action)) {
            init(context);
            stopBedtimeRoutine();

            // Schedule bedtime start task for next day
            AlarmTasksSchedulingHelper.scheduleBedtimeStartTask(mContext, mBedtimeSettings);
        }
    }

    private void init(Context context) {
        mContext = context;
        mBedtimeSettings = SharedPrefsHelper.getSetBedtimeSettings(context, null);

        // (dayOfWeek -1) for zero based indexing (0-6) of week days (1-7)
        int dayOfWeek = Calendar.getInstance().get(Calendar.DAY_OF_WEEK) - 1;
        mCanStartRoutineToday = mBedtimeSettings.scheduleDays.get(dayOfWeek);
    }

    private void startBedtimeRoutine() {
        if (!mCanStartRoutineToday) return;

        Intent serviceIntent = new Intent(mContext, MindfulTrackerService.class).setAction(MindfulTrackerService.ACTION_START_BEDTIME_MODE);
        mContext.startService(serviceIntent);

        // Start DND if needed
        if (mBedtimeSettings.shouldStartDnd) NotificationHelper.toggleDnd(mContext, true);
        pushAlertNotification(mContext.getString(R.string.bedtime_started_notification_info));
    }

    private void stopBedtimeRoutine() {
        Intent serviceIntent = new Intent(mContext, MindfulTrackerService.class).setAction(MindfulTrackerService.ACTION_STOP_BEDTIME_MODE);
        mContext.startService(serviceIntent);

        // Stop DND if needed
        if (mBedtimeSettings.shouldStartDnd) NotificationHelper.toggleDnd(mContext, false);
        pushAlertNotification(mContext.getString(R.string.bedtime_ended_notification_info));
    }


    private void pushAlertNotification(String alert) {
        NotificationManager notificationManager = (NotificationManager) mContext.getSystemService(Context.NOTIFICATION_SERVICE);
        notificationManager.notify(
                BEDTIME_ROUTINE_NOTIFICATION_ID, new NotificationCompat.Builder(mContext, NotificationHelper.NOTIFICATION_BEDTIME_CHANNEL_ID)
                        .setSmallIcon(R.drawable.ic_notification)
                        .setOngoing(false)
                        .setOnlyAlertOnce(true)
                        .setContentTitle(mContext.getString(R.string.app_name))
                        .setContentText(alert)
                        .setStyle(new NotificationCompat.BigTextStyle().bigText(alert))
                        .build()
        );
    }
}