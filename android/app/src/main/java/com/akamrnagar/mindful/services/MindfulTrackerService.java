package com.akamrnagar.mindful.services;

import static com.akamrnagar.mindful.receivers.AppLaunchReceiver.ACTION_APP_LAUNCHED;

import android.annotation.SuppressLint;
import android.app.Service;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Binder;
import android.os.IBinder;
import android.util.Log;

import com.akamrnagar.mindful.helpers.NotificationHelper;
import com.akamrnagar.mindful.helpers.ServicesHelper;
import com.akamrnagar.mindful.receivers.AppLaunchReceiver;
import com.akamrnagar.mindful.receivers.DeviceLockUnlockReceiver;

public class MindfulTrackerService extends Service {

    public static final int SERVICE_ID = 301;
    private final String TAG = "Mindful.MindfulTrackerService";
    public static final String ACTION_START_SERVICE = "com.akamrnagar.mindful.AppsTrackerService.START";
    public static final String ACTION_STOP_SERVICE = "com.akamrnagar.mindful.AppsTrackerService.STOP";
    private DeviceLockUnlockReceiver mLockUnlockReceiver;
    private AppLaunchReceiver mAppLaunchReceiver;

    private boolean areReceiversRegistered = false;

    @Override
    public void onCreate() {
        super.onCreate();
        mLockUnlockReceiver = new DeviceLockUnlockReceiver(this);
        mAppLaunchReceiver = new AppLaunchReceiver(this);
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        if (intent != null && ACTION_START_SERVICE.equals(intent.getAction())) {
            startService();
            return START_STICKY;
        } else {
            stopForeground(true);
            stopSelf();
            return START_NOT_STICKY;
        }
    }


    @SuppressLint("UnspecifiedRegisterReceiverFlag")
    private void startService() {
        // Register lock/unlock receiver
        IntentFilter lockUnlockFilter = new IntentFilter();
        lockUnlockFilter.addAction(Intent.ACTION_USER_PRESENT);
        lockUnlockFilter.addAction(Intent.ACTION_SCREEN_OFF);
        registerReceiver(mLockUnlockReceiver, lockUnlockFilter);

        // Register app launch receiver
        registerReceiver(mAppLaunchReceiver, new IntentFilter(ACTION_APP_LAUNCHED));

        // Create notification
        startForeground(SERVICE_ID, NotificationHelper.createTrackingNotification(this));

        areReceiversRegistered = true;
        Log.d(TAG, "startTracking: Foreground service started");
    }

    public void refreshService() {
        if (mAppLaunchReceiver == null) return;

        // Stop service if not timer and locked apps
        if (!mAppLaunchReceiver.reloadData()) {
            stopForeground(true);
            stopSelf();
        }
    }


    @Override
    public void onDestroy() {
        super.onDestroy();

        // Dispose and Unregister receiver
        if (areReceiversRegistered) {

            if (mAppLaunchReceiver.reloadData()) {
                ServicesHelper.startTrackingService(this);
                Log.d(TAG, "onDestroy: Service stopped forcefully, trying to restart it");
            }

            mLockUnlockReceiver.dispose();
            mAppLaunchReceiver.dispose();
            unregisterReceiver(mLockUnlockReceiver);
            unregisterReceiver(mAppLaunchReceiver);
        }

        Log.d(TAG, "onDestroy : Foreground service destroyed");
    }

    @Override
    public IBinder onBind(Intent intent) {
        return new TrackerServiceBinder();
    }

    public class TrackerServiceBinder extends Binder {
        public MindfulTrackerService getService() {
            return MindfulTrackerService.this;
        }
    }
}