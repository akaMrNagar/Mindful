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

import java.util.HashSet;

public class FocusSessionService extends Service {
    private static final String TAG = "Mindful.FocusSessionService";
    public static final String INTENT_EXTRA_FOCUS_SESSION_JSON = "focusSessionJson";
    public static final String ACTION_START_SERVICE_FOCUS = "com.mindful.android.FocusSessionService.START_SERVICE_FOCUS";
    private final ServiceBinder<FocusSessionService> mBinder = new ServiceBinder<>(FocusSessionService.this);

    private CountDownTimer mCountDownTimer;
    private NotificationManager mNotificationManager;
    private NotificationCompat.Builder mProgressNotificationBuilder;
    private SafeServiceConnection<MindfulTrackerService> mTrackerServiceConn;
    private FocusSession mFocusSession = null;
    private PendingIntent appPendingIntent;
    private int elapsedSeconds = 0;

    @Override
    public void onCreate() {
        super.onCreate();
        mNotificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
        mTrackerServiceConn = new SafeServiceConnection<>(MindfulTrackerService.class, this);

        Intent appIntent = new Intent(getBaseContext(), MainActivity.class);
        appIntent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        appPendingIntent = PendingIntent.getActivity(this, 0, appIntent, PendingIntent.FLAG_IMMUTABLE | PendingIntent.FLAG_UPDATE_CURRENT);
        mProgressNotificationBuilder = new NotificationCompat.Builder(this, NotificationHelper.NOTIFICATION_FOCUS_CHANNEL_ID)
                .setSmallIcon(R.drawable.ic_notification)
                .setOngoing(true)
                .setOnlyAlertOnce(true)
                .setContentIntent(appPendingIntent)
                .setContentTitle(getString(R.string.focus_session_notification_title));
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        String action = Utils.getActionFromIntent(intent);

        if (ACTION_START_SERVICE_FOCUS.equals(action)) {
            mFocusSession = new FocusSession(Utils.notNullStr(intent.getStringExtra(INTENT_EXTRA_FOCUS_SESSION_JSON)));

            /// Start and bind tracking service
            mTrackerServiceConn.setOnConnectedCallback(service -> service.startStopUpdateFocusSession(mFocusSession.distractingApps));
            mTrackerServiceConn.startAndBind(MindfulTrackerService.ACTION_START_RESTRICTION_MODE);

            if (!mFocusSession.distractingApps.isEmpty()) {
                long diffMs = System.currentTimeMillis() - mFocusSession.startTimeMsEpoch;
                elapsedSeconds = diffMs > 0 ? (int) (diffMs / 1000) : 0;
                startFocusTimer();
                return START_STICKY;
            }
        }

        stopSelf();
        return START_NOT_STICKY;
    }

    /**
     * Stops the running focus session and push give-up notification
     */
    public void giveUpAndStopSession() {
        if (mFocusSession != null && mFocusSession.toggleDnd) {
            NotificationHelper.toggleDnd(this, false);
        }
        if (mTrackerServiceConn.isConnected()) {
            mTrackerServiceConn.getService().startStopUpdateFocusSession(null);
        }
        stopSelf();
        showSuccessNotification(false);
    }

    /**
     * Updates the list of distracting apps for the current running focus session
     *
     * @param distractingApps List of distracting app's packages.
     */
    public void updateDistractingApps(HashSet<String> distractingApps) {
        if (mTrackerServiceConn.isConnected()) {
            mTrackerServiceConn.getService().startStopUpdateFocusSession(distractingApps);
            Log.d(TAG, "updateDistractingApps: Focus session's distracting app's list updated successfully");
        }
    }

    /**
     * Starts a countdown timer for a focus session. Configures notifications to show the remaining time
     * and handles DND mode if needed.
     */
    private void startFocusTimer() {
        // Toggle DND according to the session configurations
        if (mFocusSession.toggleDnd) NotificationHelper.toggleDnd(this, true);
        startForeground(FOCUS_SESSION_SERVICE_NOTIFICATION_ID, createNotification(mFocusSession.durationSecs));


        long timerDuration = (mFocusSession.durationSecs - elapsedSeconds) * 1000L;
        mCountDownTimer = new CountDownTimer(timerDuration, 1000) {
            @Override
            public void onTick(long millisUntilFinished) {
                mNotificationManager.notify(FOCUS_SESSION_SERVICE_NOTIFICATION_ID, createNotification((int) (millisUntilFinished / 1000L)));
            }

            @Override
            public void onFinish() {
                if (mTrackerServiceConn.isConnected()) {
                    mTrackerServiceConn.getService().startStopUpdateFocusSession(null);
                }
                if (mFocusSession.toggleDnd) {
                    NotificationHelper.toggleDnd(FocusSessionService.this, false);
                }
                Log.d(TAG, "startFocusTimer: Focus session completed successfully");
                stopSelf();
                showSuccessNotification(true);
            }
        }.start();

        Log.d(TAG, "startFocusTimer: Focus session service started successfully");
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
                .setContentText(getString(R.string.focus_session_notification_info, remainingTime))
                .setProgress(elapsedSeconds + mFocusSession.durationSecs, totalLeftSeconds, false);

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
                        .setContentIntent(appPendingIntent)
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
        }
        stopForeground(STOP_FOREGROUND_REMOVE);
        Log.d(TAG, "onDestroy: Focus session service destroyed");
    }


    @Override
    public IBinder onBind(Intent intent) {
        return mBinder;
    }
}