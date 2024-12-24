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
import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.core.app.NotificationCompat;
import androidx.work.Data;
import androidx.work.ExistingWorkPolicy;
import androidx.work.OneTimeWorkRequest;
import androidx.work.WorkManager;
import androidx.work.Worker;
import androidx.work.WorkerParameters;

import com.mindful.android.R;
import com.mindful.android.generics.SafeServiceConnection;
import com.mindful.android.helpers.AlarmTasksSchedulingHelper;
import com.mindful.android.helpers.NotificationHelper;
import com.mindful.android.helpers.SharedPrefsHelper;
import com.mindful.android.models.BedtimeSettings;
import com.mindful.android.services.MindfulTrackerService;
import com.mindful.android.utils.Utils;

import java.util.Calendar;
import java.util.Date;

public class BedtimeRoutineReceiver extends BroadcastReceiver {
    private static final String TAG = "Mindful.BedtimeRoutineReceiver";

    public static final String ACTION_ALERT_BEDTIME = "com.mindful.android.BedtimeRoutineReceiver.AlertBedtime";
    public static final String ACTION_START_BEDTIME = "com.mindful.android.BedtimeRoutineReceiver.StartBedtime";
    public static final String ACTION_STOP_BEDTIME = "com.mindful.android.BedtimeRoutineReceiver.StopBedtime";

    @Override
    public void onReceive(Context context, Intent intent) {
        String action = Utils.getActionFromIntent(intent);

        switch (action) {
            case ACTION_ALERT_BEDTIME:
            case ACTION_START_BEDTIME:
            case ACTION_STOP_BEDTIME: {
                /// Schedule worker
                WorkManager.getInstance(context).enqueueUniqueWork(
                        TAG,
                        ExistingWorkPolicy.KEEP,
                        new OneTimeWorkRequest.Builder(BedtimeRoutineWorker.class)
                                .setInputData(new Data.Builder().putString("action", action).build())
                                .build()
                );
                break;
            }
        }
    }


    public static class BedtimeRoutineWorker extends Worker {
        private final Context mContext;
        private final SafeServiceConnection<MindfulTrackerService> mTrackerServiceConn;
        private final boolean mCanStartRoutineToday;
        private final BedtimeSettings mBedtimeSettings;

        public BedtimeRoutineWorker(@NonNull Context context, @NonNull WorkerParameters params) {
            super(context, params);
            this.mContext = context;
            this.mTrackerServiceConn = new SafeServiceConnection<>(MindfulTrackerService.class, context);
            this.mBedtimeSettings = SharedPrefsHelper.getSetBedtimeSettings(context, null);

            // (dayOfWeek -1) for zero based indexing (0-6) of week days (1-7)
            int dayOfWeek = Calendar.getInstance().get(Calendar.DAY_OF_WEEK) - 1;
            this.mCanStartRoutineToday = mBedtimeSettings.scheduleDays.get(dayOfWeek);
        }


        @NonNull
        @Override
        public Result doWork() {
            try {
                String action = Utils.notNullStr(getInputData().getString("action"));

                switch (action) {
                    case ACTION_ALERT_BEDTIME:
                        pushAlertNotification(mContext.getString(R.string.bedtime_upcoming_notification_info));
                        break;
                    case ACTION_START_BEDTIME:
                        startBedtimeRoutine();
                        break;
                    case ACTION_STOP_BEDTIME:
                        stopBedtimeRoutine();
                        // Reschedule bedtime tasks for next day
                        new Handler(Looper.getMainLooper()).postDelayed(() -> AlarmTasksSchedulingHelper.scheduleBedtimeRoutineTasks(mContext, mBedtimeSettings), 1000L);
                        break;
                }

                return Result.success();
            } catch (Exception e) {
                Log.e(TAG, "doWork: Error during work execution", e);
                SharedPrefsHelper.insertCrashLogToPrefs(mContext, e);
                return Result.failure();
            } finally {
                // Unbind service
                mTrackerServiceConn.unBindService();
            }
        }

        private void startBedtimeRoutine() {
            if (!mCanStartRoutineToday) return;
            mTrackerServiceConn.setOnConnectedCallback(service -> service.startStopBedtimeMode(mBedtimeSettings.distractingApps));
            mTrackerServiceConn.startAndBind();

            // Start DND if needed
            if (mBedtimeSettings.shouldStartDnd) NotificationHelper.toggleDnd(mContext, true);
            pushAlertNotification(mContext.getString(R.string.bedtime_started_notification_info));
        }

        private void stopBedtimeRoutine() {
            mTrackerServiceConn.setOnConnectedCallback(service -> service.startStopBedtimeMode(null));
            mTrackerServiceConn.bindService();

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
                            .setContentIntent(Utils.getPendingIntentForMindful(mContext))
                            .setContentTitle(mContext.getString(R.string.app_name))
                            .setContentText(alert)
                            .setStyle(new NotificationCompat.BigTextStyle().bigText(alert))
                            .build()
            );
        }
    }
}