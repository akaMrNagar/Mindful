package com.mindful.android.services;

import static com.mindful.android.utils.AppConstants.DEFAULT_EMERGENCY_PASS_PERIOD_MS;
import static com.mindful.android.utils.AppConstants.EMERGENCY_COUNTDOWN_SERVICE_NOTIFICATION_ID;
import static com.mindful.android.utils.AppConstants.FOCUS_COUNTDOWN_SERVICE_NOTIFICATION_ID;

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
import com.mindful.android.models.FocusSession;
import com.mindful.android.utils.Utils;

public class CountDownService extends Service {
    private static final String TAG = "Mindful.CountDownService";
    public static final String ACTION_START_EMERGENCY_COUNTDOWN = "com.mindful.android.service.START_EMERGENCY_COUNTDOWN";
    public static final String ACTION_START_FOCUS_COUNTDOWN = "com.mindful.android.service.START_FOCUS_COUNTDOWN";
    public static final String ACTION_STOP_FOCUS_COUNTDOWN = "com.mindful.android.service.STOP_FOCUS_COUNTDOWN";
    public static final String INTENT_EXTRA_FOCUS_SESSION_JSON = "focusSessionJson";


    private CountDownTimer mCountDownTimer;
    private NotificationManager mNotificationManager;
    private NotificationCompat.Builder mProgressNotificationBuilder;
    private SafeServiceConnection<MindfulTrackerService> mTrackerServiceConn;
    private long mCountDownDurationMs = 0L;
    private FocusSession mFocusSession = null;
    private PendingIntent appPendingIntent;

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
                .setContentTitle("Mindful");
    }

    @Override
    public int onStartCommand(@NonNull Intent intent, int flags, int startId) {
        if (ACTION_START_EMERGENCY_COUNTDOWN.equals(intent.getAction())) {
            int leftPasses = SharedPrefsHelper.fetchEmergencyPassesCount(this);
            if (leftPasses <= 0) {
                // Stop if no passes left
                stopSelf();
                return START_NOT_STICKY;
            }
            SharedPrefsHelper.storeEmergencyPassesCount(this, leftPasses - 1);
            mCountDownDurationMs = DEFAULT_EMERGENCY_PASS_PERIOD_MS;
            startEmergencyTimer();
            return START_STICKY;
        } else if (ACTION_START_FOCUS_COUNTDOWN.equals(intent.getAction())) {
            mFocusSession = new FocusSession(Utils.notNullStr(intent.getStringExtra(INTENT_EXTRA_FOCUS_SESSION_JSON)));
            mCountDownDurationMs = mFocusSession.durationSecs * 1000L;
            if (!mFocusSession.distractingApps.isEmpty()) {
                startFocusTimer();
                return START_STICKY;
            }
        } else if (ACTION_STOP_FOCUS_COUNTDOWN.equals(intent.getAction())) {
            if (mFocusSession != null && mFocusSession.toggleDnd) {
                NotificationHelper.toggleDnd(this, false);
            }
            SharedPrefsHelper.removeCountDownService(CountDownService.this, ACTION_START_FOCUS_COUNTDOWN);
            stopSelf();
            showNotificationAfterStop("Focus Session", "You gave up! Don't worry, you can do better next time. Every effort counts - just keep going", FOCUS_COUNTDOWN_SERVICE_NOTIFICATION_ID);
            return START_NOT_STICKY;
        }

        stopSelf();
        return START_NOT_STICKY;
    }


    private void startFocusTimer() {
        SharedPrefsHelper.insertCountDownService(this, ACTION_START_FOCUS_COUNTDOWN);
        mTrackerServiceConn.setOnConnectedCallback(service -> service.startStopFocusSession(mFocusSession.distractingApps));
        mTrackerServiceConn.startAndBind();

        // Toggle dnd according to the session configurations
        if (mFocusSession.toggleDnd) NotificationHelper.toggleDnd(this, true);

        /// Handle Notification
        String title = "Focus session";
        String msgPrefix = "Focus session will end in ";
        String successMsg = "Congratulations! You’ve successfully completed your focus session. Great job staying on track! Keep up the amazing work!";
        startForeground(FOCUS_COUNTDOWN_SERVICE_NOTIFICATION_ID, createNotification(mCountDownDurationMs, title, msgPrefix));

        mCountDownTimer = new CountDownTimer(mCountDownDurationMs, 1000) {
            @Override
            public void onTick(long millisUntilFinished) {
                mNotificationManager.notify(FOCUS_COUNTDOWN_SERVICE_NOTIFICATION_ID, createNotification(millisUntilFinished, title, msgPrefix));
            }

            @Override
            public void onFinish() {
                if (mTrackerServiceConn.isConnected()) {
                    mTrackerServiceConn.getService().startStopFocusSession(null);
                }
                SharedPrefsHelper.removeCountDownService(CountDownService.this, ACTION_START_FOCUS_COUNTDOWN);
                if (mFocusSession.toggleDnd) {
                    NotificationHelper.toggleDnd(CountDownService.this, false);
                }
                Log.d(TAG, "startFocusTimer: Focus session completed successfully");
                stopSelf();
                showNotificationAfterStop(title, successMsg, FOCUS_COUNTDOWN_SERVICE_NOTIFICATION_ID);

            }
        }.start();

        Log.d(TAG, "startFocusTimer: Focus session countdown service started successfully");
    }

    private void startEmergencyTimer() {
        SharedPrefsHelper.insertCountDownService(this, ACTION_START_EMERGENCY_COUNTDOWN);
        mTrackerServiceConn.setOnConnectedCallback(service -> service.pauseResumeTracking(true));
        mTrackerServiceConn.startAndBind();

        /// Handle Notification
        String title = "Emergency pause";
        String msgPrefix = "App blocker will resume after ";
        String successMsg = "Emergency pause is over, and app blocker is back in action. Distractions are now blocked again, stay focused!";
        startForeground(EMERGENCY_COUNTDOWN_SERVICE_NOTIFICATION_ID, createNotification(mCountDownDurationMs, title, msgPrefix));

        mCountDownTimer = new CountDownTimer(mCountDownDurationMs, 1000) {
            @Override
            public void onTick(long millisUntilFinished) {
                mNotificationManager.notify(EMERGENCY_COUNTDOWN_SERVICE_NOTIFICATION_ID, createNotification(millisUntilFinished, title, msgPrefix));
            }

            @Override
            public void onFinish() {
                if (mTrackerServiceConn.isConnected()) {
                    mTrackerServiceConn.getService().pauseResumeTracking(false);
                }
                SharedPrefsHelper.removeCountDownService(CountDownService.this, ACTION_START_EMERGENCY_COUNTDOWN);
                Log.d(TAG, "startEmergencyTimer: Emergency pause is over. App blocker is resumed successfully");
                stopSelf();
                showNotificationAfterStop(title, successMsg, EMERGENCY_COUNTDOWN_SERVICE_NOTIFICATION_ID);
            }
        }.start();

        Log.d(TAG, "startEmergencyTimer: Emergency countdown service started successfully");
    }


    /**
     * Creates a notification for the countdown timer with the remaining time.
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

        mProgressNotificationBuilder
                .setContentTitle(title)
                .setContentText(msg)
                .setProgress((int) (mCountDownDurationMs / 1000), totalLeftSeconds, false);

        return mProgressNotificationBuilder.build();
    }

    private void showNotificationAfterStop(String title, String msg, int id) {
        mNotificationManager.notify(id,
                new NotificationCompat.Builder(this, NotificationHelper.NOTIFICATION_FOCUS_CHANNEL_ID)
                        .setSmallIcon(R.drawable.ic_notification)
                        .setOngoing(false)
                        .setContentIntent(appPendingIntent)
                        .setContentTitle(title)
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
        Log.d(TAG, "onDestroy: Countdown service destroyed");
    }


    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }
}