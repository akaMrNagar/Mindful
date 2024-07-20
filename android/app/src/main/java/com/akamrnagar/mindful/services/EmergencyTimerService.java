package com.akamrnagar.mindful.services;

import android.app.Notification;
import android.app.NotificationManager;
import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.os.CountDownTimer;
import android.os.IBinder;

import androidx.annotation.NonNull;
import androidx.core.app.NotificationCompat;

import com.akamrnagar.mindful.R;
import com.akamrnagar.mindful.helpers.NotificationHelper;
import com.akamrnagar.mindful.utils.AppConstants;

public class EmergencyTimerService extends Service {
    private static final String TAG = "Mindful.EmergencyTimerService";
    private static final int SERVICE_ID = 304;

    private CountDownTimer mCountDownTimer;
    private NotificationManager mNotificationManager;


    @Override
    public void onCreate() {
        super.onCreate();
        mNotificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        startTimer();
        return START_STICKY;
    }

    private void startTimer() {
        startForeground(SERVICE_ID, createNotification(AppConstants.DEFAULT_EMERGENCY_PASS_PERIOD_MS));
        mCountDownTimer = new CountDownTimer(AppConstants.DEFAULT_EMERGENCY_PASS_PERIOD_MS, 1000) {
            @Override
            public void onTick(long millisUntilFinished) {
                mNotificationManager.notify(SERVICE_ID, createNotification(millisUntilFinished));
            }

            @Override
            public void onFinish() {
                stopSelf();
            }
        }.start();
    }


    @NonNull
    private Notification createNotification(long millisUntilFinished) {
        int totalSeconds = (int) (millisUntilFinished / 1000);
        int leftMinutes = totalSeconds / 60;
        int leftSeconds = totalSeconds % 60;

        String msg = "The app blocker will resume after " + leftMinutes + ":" + leftSeconds + " minutes";

        return new NotificationCompat.Builder(this, NotificationHelper.NOTIFICATION_IMPORTANT_CHANNEL_ID)
                .setSmallIcon(R.mipmap.ic_launcher)
                .setOngoing(true)
                .setOnlyAlertOnce(true)
                .setContentTitle("Emergency pause")
                .setContentText(msg)
                .setProgress(AppConstants.DEFAULT_EMERGENCY_PASS_PERIOD_MS, (int) millisUntilFinished, false)
                .build();
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        if (mCountDownTimer != null) {
            mCountDownTimer.cancel();
        }
        stopForeground(true);
    }


    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }
}


