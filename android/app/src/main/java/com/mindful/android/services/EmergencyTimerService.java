package com.mindful.android.services;

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
import com.mindful.android.helpers.NotificationHelper;
import com.mindful.android.helpers.SharedPrefsHelper;
import com.mindful.android.utils.AppConstants;

/**
 * A Service that provides an emergency timer for pausing app tracking.
 */
public class EmergencyTimerService extends Service {
    private static final String TAG = "Mindful.EmergencyTimerService";
    private static final int SERVICE_ID = 304;

    private CountDownTimer mCountDownTimer;
    private NotificationManager mNotificationManager;
    private SafeServiceConnection<MindfulTrackerService> mTrackerServiceConn;

    @Override
    public void onCreate() {
        super.onCreate();
        mNotificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);

        // Bind to tracking service
        mTrackerServiceConn = new SafeServiceConnection<>(MindfulTrackerService.class, this);
        mTrackerServiceConn.setOnConnectedCallback(service -> service.pauseResumeTracking(true));
        mTrackerServiceConn.bindService();
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        int leftPasses = SharedPrefsHelper.fetchEmergencyPassesCount(this);

        // Stop if no passes left
        if (leftPasses <= 0) {
            stopSelf();
            return START_NOT_STICKY;
        }

        SharedPrefsHelper.storeEmergencyPassesCount(this, leftPasses - 1);
        startTimer();

        Log.d(TAG, "onStartCommand: Emergency timer service started successfully");
        return START_STICKY;
    }

    /**
     * Starts the countdown timer and updates the notification with the remaining time.
     */
    private void startTimer() {
        startForeground(SERVICE_ID, createNotification(AppConstants.DEFAULT_EMERGENCY_PASS_PERIOD_MS));
        mCountDownTimer = new CountDownTimer(AppConstants.DEFAULT_EMERGENCY_PASS_PERIOD_MS, 1000) {
            @Override
            public void onTick(long millisUntilFinished) {
                mNotificationManager.notify(SERVICE_ID, createNotification(millisUntilFinished));
            }

            @Override
            public void onFinish() {
                if (mTrackerServiceConn.isConnected()) {
                    mTrackerServiceConn.getService().pauseResumeTracking(false);
                }
                stopSelf();
            }
        }.start();
    }

    /**
     * Creates a notification for the emergency timer with the remaining time.
     *
     * @param millisUntilFinished The remaining time in milliseconds.
     * @return The notification object.
     */
    @NonNull
    private Notification createNotification(long millisUntilFinished) {
        int totalSeconds = (int) (millisUntilFinished / 1000);
        int leftMinutes = totalSeconds / 60;
        int leftSeconds = totalSeconds % 60;

        String msg = "The app blocker will resume after " + leftMinutes + ":" + leftSeconds + " minutes";

        return new NotificationCompat.Builder(this, NotificationHelper.NOTIFICATION_IMPORTANT_CHANNEL_ID)
                .setSmallIcon(R.drawable.ic_notification)
                .setOngoing(true)
                .setOnlyAlertOnce(true)
                .setContentTitle("Emergency pause")
                .setContentText(msg)
                .setProgress(AppConstants.DEFAULT_EMERGENCY_PASS_PERIOD_MS, (int) millisUntilFinished, false)
                .build();
    }

    /**
     * Called when the service is destroyed. Unbinds from the tracking service,
     * cancels the countdown timer, and stops the foreground notification.
     */
    @Override
    public void onDestroy() {
        super.onDestroy();
        mTrackerServiceConn.unBindService();
        if (mCountDownTimer != null) {
            mCountDownTimer.cancel();
        }
        stopForeground(true);
        Log.d(TAG, "onDestroy: Emergency timer service destroyed");
    }

    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }
}
