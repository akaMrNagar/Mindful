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

package com.mindful.android.services;

import static com.mindful.android.generics.ServiceBinder.ACTION_START_MINDFUL_SERVICE;
import static com.mindful.android.utils.AppConstants.EMERGENCY_PAUSE_SERVICE_NOTIFICATION_ID;

import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.os.CountDownTimer;
import android.os.IBinder;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.core.app.NotificationCompat;

import com.mindful.android.MainActivity;
import com.mindful.android.R;
import com.mindful.android.generics.SafeServiceConnection;
import com.mindful.android.helpers.NotificationHelper;
import com.mindful.android.helpers.SharedPrefsHelper;
import com.mindful.android.utils.Utils;

public class EmergencyPauseService extends Service {
    private static final int DEFAULT_EMERGENCY_PASS_PERIOD_MS = 5 * 60 * 1000;
    private static final String TAG = "Mindful.EmergencyPauseService";

    private CountDownTimer mCountDownTimer;
    private NotificationManager mNotificationManager;
    private NotificationCompat.Builder mProgressNotificationBuilder;
    private SafeServiceConnection<MindfulTrackerService> mTrackerServiceConn;


    @Override
    public void onCreate() {
        super.onCreate();
        mNotificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
        mTrackerServiceConn = new SafeServiceConnection<>(MindfulTrackerService.class, this);
        mProgressNotificationBuilder = new NotificationCompat.Builder(this, NotificationHelper.NOTIFICATION_FOCUS_CHANNEL_ID)
                .setSmallIcon(R.drawable.ic_notification)
                .setOngoing(true)
                .setOnlyAlertOnce(true)
                .setContentIntent(Utils.getPendingIntentForMindful(this))
                .setContentTitle(getString(R.string.emergency_pause_notification_title));
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        String action = Utils.getActionFromIntent(intent);

        if (ACTION_START_MINDFUL_SERVICE.equals(action)) {
            startEmergencyTimer();
            return START_STICKY;
        }

        stopSelf();
        return START_NOT_STICKY;
    }

    private void startEmergencyTimer() {
        try {
            startForeground(EMERGENCY_PAUSE_SERVICE_NOTIFICATION_ID, createNotification(DEFAULT_EMERGENCY_PASS_PERIOD_MS / 1000));
            mTrackerServiceConn.setOnConnectedCallback(service -> service.pauseResumeTracking(true));
            mTrackerServiceConn.bindService();

            mCountDownTimer = new CountDownTimer(DEFAULT_EMERGENCY_PASS_PERIOD_MS, 1000) {
                @Override
                public void onTick(long millisUntilFinished) {
                    mNotificationManager.notify(EMERGENCY_PAUSE_SERVICE_NOTIFICATION_ID, createNotification((int) (millisUntilFinished / 1000)));
                }

                @Override
                public void onFinish() {
                    if (mTrackerServiceConn.isConnected()) {
                        mTrackerServiceConn.getService().pauseResumeTracking(false);
                    }
                    Log.d(TAG, "startEmergencyTimer: Emergency pause is over. App blocker is resumed successfully");
                    stopSelf();
                    showSuccessNotification();
                }
            };

            mCountDownTimer.start();
            Log.d(TAG, "startEmergencyTimer: EMERGENCY service started successfully");
        } catch (Exception e) {
            Log.d(TAG, "startEmergencyTimer: Failed to start EMERGENCY service: ", e);
            SharedPrefsHelper.insertCrashLogToPrefs(this, e);
            stopSelf();
        }
    }

    /**
     * Creates a notification to show the countdown progress.
     *
     * @param totalLeftSeconds The remaining time in seconds.
     * @return The notification object.
     */
    @NonNull
    private Notification createNotification(int totalLeftSeconds) {
        String remainingTime = Utils.secondsToTimeStr(totalLeftSeconds);

        mProgressNotificationBuilder
                .setContentText(getString(R.string.emergency_pause_notification_info, remainingTime))
                .setProgress(DEFAULT_EMERGENCY_PASS_PERIOD_MS / 1000, totalLeftSeconds, false);

        return mProgressNotificationBuilder.build();
    }


    /**
     * Displays a notification when the Emergency Pause timer is completed successfully.
     */
    private void showSuccessNotification() {
        String msg = getString(R.string.emergency_pause_ended_notification_info);
        mNotificationManager.notify(EMERGENCY_PAUSE_SERVICE_NOTIFICATION_ID,
                new NotificationCompat.Builder(this, NotificationHelper.NOTIFICATION_CRITICAL_CHANNEL_ID)
                        .setSmallIcon(R.drawable.ic_notification)
                        .setAutoCancel(true)
                        .setOngoing(false)
                        .setContentIntent(Utils.getPendingIntentForMindful(this))
                        .setContentTitle(getString(R.string.emergency_pause_notification_title))
                        .setContentText(msg)
                        .setStyle(new NotificationCompat.BigTextStyle().bigText(msg))
                        .build()
        );
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        if (mTrackerServiceConn.isConnected()) {
            mTrackerServiceConn.getService().pauseResumeTracking(false);
        }
        mTrackerServiceConn.unBindService();
        if (mCountDownTimer != null) {
            mCountDownTimer.cancel();
        }
        stopForeground(STOP_FOREGROUND_REMOVE);
        Log.d(TAG, "onDestroy: EMERGENCY service destroyed successfully");
    }

    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }
}