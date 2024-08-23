package com.mindful.android.services;

import static com.mindful.android.generics.ServiceBinder.ACTION_START_SERVICE;
import static com.mindful.android.utils.AppConstants.DEFAULT_EMERGENCY_PASS_PERIOD_MS;
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

public class EmergencyPauseService extends Service {
    private static final String TAG = "Mindful.EmergencyPauseService";

    private CountDownTimer mCountDownTimer;
    private NotificationManager mNotificationManager;
    private NotificationCompat.Builder mProgressNotificationBuilder;
    private SafeServiceConnection<MindfulTrackerService> mTrackerServiceConn;
    private long mCountDownDurationMs = 0L;
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
                .setContentTitle("Emergency Pause");
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        String action = intent.getAction();
        if (action == null) return START_NOT_STICKY;

        if (ACTION_START_SERVICE.equals(action)) {
            int leftPasses = SharedPrefsHelper.fetchEmergencyPassesCount(this);
            // Stop if no passes left
            if (leftPasses <= 0) {
                stopSelf();
                return START_NOT_STICKY;
            }
            SharedPrefsHelper.storeEmergencyPassesCount(this, leftPasses - 1);
            mCountDownDurationMs = DEFAULT_EMERGENCY_PASS_PERIOD_MS;
            startEmergencyTimer();
            return START_STICKY;
        } else {
            stopSelf();
            return START_NOT_STICKY;
        }
    }

    private void startEmergencyTimer() {
        mTrackerServiceConn.setOnConnectedCallback(service -> service.pauseResumeTracking(true));
        mTrackerServiceConn.startAndBind();
        startForeground(EMERGENCY_PAUSE_SERVICE_NOTIFICATION_ID, createNotification(mCountDownDurationMs));

        mCountDownTimer = new CountDownTimer(mCountDownDurationMs, 1000) {
            @Override
            public void onTick(long millisUntilFinished) {
                mNotificationManager.notify(EMERGENCY_PAUSE_SERVICE_NOTIFICATION_ID, createNotification(millisUntilFinished));
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
        }.start();

        Log.d(TAG, "startEmergencyTimer: Emergency pause service started successfully");
    }

    /**
     * Creates a notification to show the countdown progress.
     *
     * @param millisUntilFinished The remaining time in milliseconds.
     * @return The notification object.
     */
    @NonNull
    private Notification createNotification(long millisUntilFinished) {
        int totalLeftSeconds = (int) (millisUntilFinished / 1000);
        int leftHours = totalLeftSeconds / 60 / 60;
        int leftMinutes = (totalLeftSeconds / 60) % 60;
        int leftSeconds = totalLeftSeconds % 60;

        String prefixMsg = "App blocker will resume after ";

        String msg =
                leftHours > 0 ?
                        prefixMsg + leftHours + ":" + leftMinutes + ":" + leftSeconds + (leftHours > 1 ? " hours" : " hour") :
                        prefixMsg + leftMinutes + ":" + leftSeconds + " minutes";

        mProgressNotificationBuilder
                .setContentText(msg)
                .setProgress((int) (mCountDownDurationMs / 1000), totalLeftSeconds, false);

        return mProgressNotificationBuilder.build();
    }


    /**
     * Displays a notification when the Emergency Pause timer is completed successfully.
     */
    private void showSuccessNotification() {
        String msg = "Emergency pause is over, and app blocker is back in action. Distractions are now blocked again, stay focused!";
        mNotificationManager.notify(EMERGENCY_PAUSE_SERVICE_NOTIFICATION_ID,
                new NotificationCompat.Builder(this, NotificationHelper.NOTIFICATION_CRITICAL_CHANNEL_ID)
                        .setSmallIcon(R.drawable.ic_notification)
                        .setOngoing(false)
                        .setContentIntent(appPendingIntent)
                        .setContentTitle("Emergency Pause")
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
        Log.d(TAG, "onDestroy: Emergency pause service destroyed");
    }

    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }
}