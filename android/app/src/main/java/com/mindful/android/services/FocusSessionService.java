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

import static com.mindful.android.utils.AppConstants.FOCUS_SESSION_SERVICE_NOTIFICATION_ID;

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
import com.mindful.android.generics.ServiceBinder;
import com.mindful.android.helpers.NotificationHelper;
import com.mindful.android.models.FocusSession;
import com.mindful.android.utils.Utils;

import java.util.Timer;
import java.util.TimerTask;

public class FocusSessionService extends Service {
    private static final String TAG = "Mindful.FocusSessionService";
    public static final String ACTION_START_FOCUS_SERVICE = "com.mindful.android.FocusSessionService.START_SERVICE_FOCUS";
    private final ServiceBinder<FocusSessionService> mBinder = new ServiceBinder<>(FocusSessionService.this);
    private CountDownTimer mCountDownTimer;
    private Timer mStopWatchTimer;

    private NotificationManager mNotificationManager;
    private NotificationCompat.Builder mProgressNotificationBuilder;
    private SafeServiceConnection<MindfulTrackerService> mTrackerServiceConn;
    private FocusSession mFocusSession = null;
    private int mElapsedSeconds = 0;

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
                .setContentTitle(getString(R.string.focus_session_notification_title));
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        String action = Utils.getActionFromIntent(intent);

        if (ACTION_START_FOCUS_SERVICE.equals(action)) {
            return START_STICKY;
        }

        stopSelf();
        return START_NOT_STICKY;
    }


    /**
     * Starts a countdown timer for a focus session. Configures notifications to show the remaining time
     * and handles DND mode if needed.
     */
    public void startFocusSession(@NonNull FocusSession focusSession) {
        mFocusSession = focusSession;
        if (mFocusSession.distractingApps.isEmpty()) {
            stopSelf();
            return;
        }

        /// Start and bind tracking service
        mTrackerServiceConn.setOnConnectedCallback(service -> service.startStopUpdateFocusSession(mFocusSession.distractingApps));
        mTrackerServiceConn.startAndBind(MindfulTrackerService.ACTION_START_RESTRICTION_MODE);

        long diffMs = System.currentTimeMillis() - mFocusSession.startTimeMsEpoch;
        mElapsedSeconds = diffMs > 0 ? (int) (diffMs / 1000) : 0;

        // Toggle DND according to the session configurations
        if (mFocusSession.toggleDnd) NotificationHelper.toggleDnd(this, true);

        try {
            startForeground(FOCUS_SESSION_SERVICE_NOTIFICATION_ID, createNotification(mFocusSession.durationSecs));
            Log.d(TAG, "startFocusSession: Focus session service started successfully");
        } catch (Exception ignored) {
        }


        // Check and start timer on the basis of duration
        if (mFocusSession.durationSecs > 0) {
            startCountDownTimer();
        } else {
            startStopWatchTimer();
        }
    }


    public void updateFocusSession(FocusSession session) {
        if (mTrackerServiceConn.isConnected()) {
            mTrackerServiceConn.getService().startStopUpdateFocusSession(session.distractingApps);
            Log.d(TAG, "updateDistractingApps: Focus session's distracting app's list updated successfully");
        }
    }

    public void giveUpOrStopFocusSession(boolean isTheSessionSuccessful) {
        if (mFocusSession != null && mFocusSession.toggleDnd) {
            NotificationHelper.toggleDnd(this, false);
        }
        if (mTrackerServiceConn.isConnected()) {
            mTrackerServiceConn.getService().startStopUpdateFocusSession(null);
        }
        stopSelf();
        showSuccessNotification(isTheSessionSuccessful);
    }


    private void startStopWatchTimer() {
        Log.d(TAG, "startStopWatchTimer: Starting");
        mStopWatchTimer = new Timer();
        mStopWatchTimer.schedule(new TimerTask() {
            @Override
            public void run() {
                mElapsedSeconds++;
                mNotificationManager.notify(FOCUS_SESSION_SERVICE_NOTIFICATION_ID, createNotification(mElapsedSeconds));
            }
        }, 0L, 1000L);
    }


    private void startCountDownTimer() {
        Log.d(TAG, "startCountDownTimer: Starting");
        long timerDuration = (mFocusSession.durationSecs - mElapsedSeconds) * 1000L;
        mCountDownTimer = new CountDownTimer(timerDuration, 1000) {
            @Override
            public void onTick(long millisUntilFinished) {
                mNotificationManager.notify(FOCUS_SESSION_SERVICE_NOTIFICATION_ID, createNotification((int) (millisUntilFinished / 1000L)));
            }

            @Override
            public void onFinish() {
                giveUpOrStopFocusSession(true);
            }
        }.start();
    }


    /**
     * Creates a notification to show the countdown progress.
     *
     * @param totalLeftSeconds The remaining time in seconds.
     * @return The notification object.
     */
    @NonNull
    private Notification createNotification(int totalLeftSeconds) {
        String notificationInfo = getString(
                mFocusSession.durationSecs > 0
                        ? R.string.focus_session_notification_info
                        : R.string.focus_session_infinite_notification_info,
                Utils.secondsToTimeStr(totalLeftSeconds)
        );

        mProgressNotificationBuilder
                .setContentText(notificationInfo)
                .setProgress(mFocusSession.durationSecs, totalLeftSeconds, false);

        return mProgressNotificationBuilder.build();
    }


    /**
     * Displays a notification when the focus session is completed successfully.
     *
     * @param isSuccessful Flag denoting if the session is successful or use gave up
     */
    private void showSuccessNotification(boolean isSuccessful) {
        String msg =
                isSuccessful ? getString(R.string.focus_session_success_notification_info) :
                        getString(R.string.focus_session_giveup_notification_info);
        mNotificationManager.notify(FOCUS_SESSION_SERVICE_NOTIFICATION_ID,
                new NotificationCompat.Builder(this, NotificationHelper.NOTIFICATION_FOCUS_CHANNEL_ID)
                        .setSmallIcon(R.drawable.ic_notification)
                        .setOngoing(false)
                        .setAutoCancel(true)
                        .setContentIntent(Utils.getPendingIntentForMindful(this))
                        .setContentTitle(getString(R.string.focus_session_notification_title))
                        .setContentText(msg)
                        .setStyle(new NotificationCompat.BigTextStyle().bigText(msg))
                        .build()
        );
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        mTrackerServiceConn.unBindService();
        if (mCountDownTimer != null) {
            mCountDownTimer.cancel();
            mCountDownTimer = null;
        }

        if (mStopWatchTimer != null) {
            mStopWatchTimer.cancel();
            mStopWatchTimer = null;
        }

        stopForeground(STOP_FOREGROUND_REMOVE);
        Log.d(TAG, "onDestroy: Focus session service destroyed");
    }


    @Override
    public IBinder onBind(Intent intent) {
        return mBinder;
    }
}