package com.mindful.android.services;

import static com.mindful.android.helpers.NotificationHelper.NOTIFICATION_IMPORTANT_CHANNEL_ID;
import static com.mindful.android.utils.AppConstants.DEFAULT_EMERGENCY_PASS_PERIOD_MS;
import static com.mindful.android.utils.AppConstants.EMERGENCY_COUNTDOWN_SERVICE_NOTIFICATION_ID;
import static com.mindful.android.utils.AppConstants.FOCUS_COUNTDOWN_SERVICE_NOTIFICATION_ID;

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
import com.mindful.android.helpers.SharedPrefsHelper;
import com.mindful.android.models.FocusSession;
import com.mindful.android.utils.Utils;

import java.util.HashSet;

public class CountDownService extends Service {
    private static final String TAG = "Mindful.CountDownService";
    public static final String ACTION_START_EMERGENCY_COUNTDOWN = "com.mindful.android.service.START_EMERGENCY_COUNTDOWN";
    public static final String ACTION_START_FOCUS_COUNTDOWN = "com.mindful.android.service.START_FOCUS_COUNTDOWN";
    public static final String INTENT_EXTRA_FOCUS_SESSION_JSON = "focusSessionJson";


    private CountDownTimer mCountDownTimer;
    private NotificationManager mNotificationManager;
    private NotificationCompat.Builder mNotificationBuilder;
    private SafeServiceConnection<MindfulTrackerService> mTrackerServiceConn;
    private long mCountDownDurationMs = 0L;

    @Override
    public void onCreate() {
        super.onCreate();
        mNotificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
        mTrackerServiceConn = new SafeServiceConnection<>(MindfulTrackerService.class, this);
        mNotificationBuilder = new NotificationCompat.Builder(this, NOTIFICATION_IMPORTANT_CHANNEL_ID)
                .setSmallIcon(R.drawable.ic_notification)
                .setOngoing(true)
                .setOnlyAlertOnce(true)
                .setContentTitle("Mindful");
    }

    @Override
    public int onStartCommand(@NonNull Intent intent, int flags, int startId) {
        if (ACTION_START_EMERGENCY_COUNTDOWN.equals(intent.getAction())) {
            // Stop if no passes left
            int leftPasses = SharedPrefsHelper.fetchEmergencyPassesCount(this);
            if (leftPasses <= 0) {
                stopSelf();
                return START_NOT_STICKY;
            }
            SharedPrefsHelper.storeEmergencyPassesCount(this, leftPasses - 1);
            mCountDownDurationMs = DEFAULT_EMERGENCY_PASS_PERIOD_MS;
            startEmergencyTimer();
            return START_STICKY;
        } else if (ACTION_START_FOCUS_COUNTDOWN.equals(intent.getAction())) {
            FocusSession session = new FocusSession(Utils.notNullStr(intent.getStringExtra(INTENT_EXTRA_FOCUS_SESSION_JSON)));
            mCountDownDurationMs = session.durationSecs * 1000L;
            if (!session.distractingApps.isEmpty()) {
                startFocusTimer(session.distractingApps);
                return START_STICKY;
            }
        }

        stopSelf();
        return START_NOT_STICKY;
    }


    private void startFocusTimer(HashSet<String> distractingApps) {
        SharedPrefsHelper.insertCountDownService(this, ACTION_START_FOCUS_COUNTDOWN);
        mTrackerServiceConn.setOnConnectedCallback(service -> service.startStopFocusSession(distractingApps));
        mTrackerServiceConn.bindService();

        /// TODO: Add pending intent with route to active session screen

        /// TODO: Add logic to start stop dnd


        /// Handle Notification
        String notificationTitle = "Focus session";
        String notificationMsgPrefix = "Focus session will end in ";
        startForeground(FOCUS_COUNTDOWN_SERVICE_NOTIFICATION_ID, createNotification(mCountDownDurationMs, notificationTitle, notificationMsgPrefix));

        mCountDownTimer = new CountDownTimer(mCountDownDurationMs, 1000) {
            @Override
            public void onTick(long millisUntilFinished) {
                mNotificationManager.notify(FOCUS_COUNTDOWN_SERVICE_NOTIFICATION_ID, createNotification(millisUntilFinished, notificationTitle, notificationMsgPrefix));
            }

            @Override
            public void onFinish() {
                if (mTrackerServiceConn.isConnected()) {
                    mTrackerServiceConn.getService().startStopFocusSession(null);
                }
                SharedPrefsHelper.removeCountDownService(CountDownService.this, ACTION_START_FOCUS_COUNTDOWN);
                stopSelf();
            }
        }.start();

        Log.d(TAG, "onDestroy: Focus session countdown service started successfully");
    }

    private void startEmergencyTimer() {
        SharedPrefsHelper.insertCountDownService(this, ACTION_START_EMERGENCY_COUNTDOWN);
        mTrackerServiceConn.setOnConnectedCallback(service -> service.pauseResumeTracking(true));
        mTrackerServiceConn.bindService();

        /// Handle Notification
        String notificationTitle = "Emergency pause";
        String notificationMsgPrefix = "App blocker will resume after ";
        startForeground(EMERGENCY_COUNTDOWN_SERVICE_NOTIFICATION_ID, createNotification(mCountDownDurationMs, notificationTitle, notificationMsgPrefix));

        mCountDownTimer = new CountDownTimer(mCountDownDurationMs, 1000) {
            @Override
            public void onTick(long millisUntilFinished) {
                mNotificationManager.notify(EMERGENCY_COUNTDOWN_SERVICE_NOTIFICATION_ID, createNotification(millisUntilFinished, notificationTitle, notificationMsgPrefix));
            }

            @Override
            public void onFinish() {
                if (mTrackerServiceConn.isConnected()) {
                    mTrackerServiceConn.getService().pauseResumeTracking(false);
                }
                SharedPrefsHelper.removeCountDownService(CountDownService.this, ACTION_START_EMERGENCY_COUNTDOWN);
                stopSelf();
            }
        }.start();

        Log.d(TAG, "onDestroy: Emergency countdown service started successfully");
    }


    /**
     * Creates a notification for the emergency timer with the remaining time.
     *
     * @param millisUntilFinished The remaining time in milliseconds.
     * @return The notification object.
     */
    @NonNull
    private Notification createNotification(long millisUntilFinished, String title, String prefixMsg) {
        int totalLeftSeconds = (int) (millisUntilFinished / 1000);
        int leftHours = totalLeftSeconds / 60 / 60;
        int leftMinutes = totalLeftSeconds / 60;
        int leftSeconds = totalLeftSeconds % 60;

        String msg =
                leftHours > 0 ?
                        prefixMsg + leftHours + ":" + leftMinutes + ":" + leftSeconds + (leftHours > 1 ? " hours" : " hour") :
                        prefixMsg + leftMinutes + ":" + leftSeconds + " minutes";

        return mNotificationBuilder
                .setContentTitle(title)
                .setContentText(msg)
                .setProgress((int) (mCountDownDurationMs / 1000), totalLeftSeconds, false)
                .build();
    }


    @Override
    public void onDestroy() {
        super.onDestroy();
        mTrackerServiceConn.unBindService();
        if (mCountDownTimer != null) {
            mCountDownTimer.cancel();
        }
        stopForeground(STOP_FOREGROUND_DETACH);
        Log.d(TAG, "onDestroy: Countdown service destroyed");
    }


    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }
}