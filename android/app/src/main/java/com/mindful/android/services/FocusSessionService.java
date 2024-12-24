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

import static com.mindful.android.generics.ServiceBinder.ACTION_BIND_TO_MINDFUL;
import static com.mindful.android.generics.ServiceBinder.ACTION_START_MINDFUL_SERVICE;
import static com.mindful.android.utils.AppConstants.FOCUS_SESSION_SERVICE_NOTIFICATION_ID;

import android.app.Notification;
import android.app.NotificationManager;
import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.os.CountDownTimer;
import android.os.IBinder;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.core.app.NotificationCompat;

import com.mindful.android.R;
import com.mindful.android.generics.SafeServiceConnection;
import com.mindful.android.generics.ServiceBinder;
import com.mindful.android.helpers.NotificationHelper;
import com.mindful.android.helpers.SharedPrefsHelper;
import com.mindful.android.models.FocusSession;
import com.mindful.android.utils.Utils;

import java.util.Timer;
import java.util.TimerTask;

public class FocusSessionService extends Service {
    private static final String TAG = "Mindful.FocusSessionService";
    private final ServiceBinder<FocusSessionService> mBinder = new ServiceBinder<>(FocusSessionService.this);

    private NotificationManager mNotificationManager;
    private NotificationCompat.Builder mProgressNotificationBuilder;
    private SafeServiceConnection<MindfulTrackerService> mTrackerServiceConn;
    private FocusSession mFocusSession = null;
    private CountDownTimer mCountDownTimer = null;
    private boolean mIsFiniteSession = true;
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

        if (ACTION_START_MINDFUL_SERVICE.equals(action)) {
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
        try {
            mFocusSession = focusSession;
            mIsFiniteSession = focusSession.durationSecs > 0;
            if (mFocusSession.distractingApps.isEmpty()) {
                stopSelf();
                return;
            }

            startForeground(FOCUS_SESSION_SERVICE_NOTIFICATION_ID, createNotification(mFocusSession.durationSecs));

            /// Start and bind tracking service
            mTrackerServiceConn.setOnConnectedCallback(service -> service.startStopUpdateFocusSession(mFocusSession.distractingApps));
            mTrackerServiceConn.startAndBind();

            long diffMs = System.currentTimeMillis() - mFocusSession.startTimeMsEpoch;
            mElapsedSeconds = diffMs > 0 ? (int) (diffMs / 1000) : 0;

            // Toggle DND according to the session configurations
            if (mFocusSession.toggleDnd) NotificationHelper.toggleDnd(this, true);

            startTimer();
            Log.d(TAG, "startFocusSession: FOCUS service started successfully");
        } catch (Exception e) {
            Log.d(TAG, "startFocusSession: Failed to start FOCUS service", e);
            SharedPrefsHelper.insertCrashLogToPrefs(this, e);
            stopSelf();
        }
    }


    public void updateFocusSession(FocusSession session) {
        if (mTrackerServiceConn.isConnected()) {
            mTrackerServiceConn.getService().startStopUpdateFocusSession(session.distractingApps);
            Log.d(TAG, "updateDistractingApps: Focus session's distracting app's list updated successfully");
        }
    }

    private void startTimer() {
        final long timerDurationMs =
                mIsFiniteSession
                        ? (mFocusSession.durationSecs - mElapsedSeconds) * 1000L
                        : (7 * 24 * 60 * 60 * 1000);

        mCountDownTimer = new CountDownTimer(timerDurationMs, 1000L) {
            @Override
            public void onTick(long millisUntilFinished) {
                mElapsedSeconds++;
                int notificationTimeSeconds = mIsFiniteSession ? mFocusSession.durationSecs - mElapsedSeconds : mElapsedSeconds;
                mNotificationManager.notify(FOCUS_SESSION_SERVICE_NOTIFICATION_ID, createNotification(notificationTimeSeconds));
            }

            @Override
            public void onFinish() {
                giveUpOrStopFocusSession(true);
            }
        };
        mCountDownTimer.start();
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


    /**
     * Creates a notification to show the countdown progress.
     *
     * @param elapsedOrLeftSeconds The remaining time in seconds.
     * @return The notification object.
     */
    @NonNull
    private Notification createNotification(int elapsedOrLeftSeconds) {
        String notificationInfo = getString(
                mIsFiniteSession
                        ? R.string.focus_session_notification_info
                        : R.string.focus_session_infinite_notification_info,
                Utils.secondsToTimeStr(elapsedOrLeftSeconds)
        );

        mProgressNotificationBuilder.setContentText(notificationInfo);
        if (mIsFiniteSession) {
            mProgressNotificationBuilder
                    .setProgress(mFocusSession.durationSecs, elapsedOrLeftSeconds, false);
        }

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
        stopForeground(STOP_FOREGROUND_REMOVE);
        Log.d(TAG, "onDestroy: FOCUS service destroyed successfully");
    }


    @Override
    public IBinder onBind(Intent intent) {
        String action = Utils.getActionFromIntent(intent);
        return action.equals(ACTION_BIND_TO_MINDFUL) ? mBinder : null;
    }
}