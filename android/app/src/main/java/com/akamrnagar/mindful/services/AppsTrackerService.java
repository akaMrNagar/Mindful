package com.akamrnagar.mindful.services;

import android.app.Service;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Binder;
import android.os.IBinder;
import android.util.Log;

import com.akamrnagar.mindful.helpers.NotificationHelper;
import com.akamrnagar.mindful.receivers.LockUnlockReceiver;
import com.akamrnagar.mindful.utils.AppConstants;

/**
 * This service tracks the launch of apps installed on user device and enforces usage limits.
 */
public class AppsTrackerService extends Service {
    public static final int SERVICE_ID = 301;
    public static final String ACTION_START_SERVICE = "com.akamrnagar.mindful.AppsTrackerService.START";
    public static final String ACTION_STOP_SERVICE = "com.akamrnagar.mindful.AppsTrackerService.STOP";
    private LockUnlockReceiver mLockUnlockReceiver;

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        if (intent != null && ACTION_START_SERVICE.equals(intent.getAction())) {
            startTracking();
            return START_STICKY;
        } else {
            stopForeground(true);
            stopSelf();
            return START_NOT_STICKY;
        }
    }

    private void startTracking() {
        Log.d(AppConstants.DEBUG_TAG, "startTracking() called");

        mLockUnlockReceiver = new LockUnlockReceiver(this);
        IntentFilter lockUnlockFilter = new IntentFilter();
        lockUnlockFilter.addAction(Intent.ACTION_USER_PRESENT);
        lockUnlockFilter.addAction(Intent.ACTION_SCREEN_OFF);
        registerReceiver(mLockUnlockReceiver, lockUnlockFilter);

        startForeground(SERVICE_ID, NotificationHelper.createTrackingNotification(this));
    }


    @Override
    public void onDestroy() {
        super.onDestroy();
        if (mLockUnlockReceiver != null) {
            Log.d(AppConstants.DEBUG_TAG, "onDestroy() called");

            mLockUnlockReceiver.dispose();
            unregisterReceiver(mLockUnlockReceiver);
            mLockUnlockReceiver = null;
        }
    }

    @Override
    public IBinder onBind(Intent intent) {
        return new TrackerServiceBinder();
    }

    public void refreshAppTimers() {
        if (mLockUnlockReceiver != null) mLockUnlockReceiver.refreshAppTimers();
    }

//    public void checkToStopService() {
//        if (mLockUnlockReceiver != null) mLockUnlockReceiver.checkToStopService();
//    }

    public void onBedtimeWorkerExecute(boolean state) {
        if (mLockUnlockReceiver != null) mLockUnlockReceiver.changeBedtimeState(state);
    }

    public class TrackerServiceBinder extends Binder {
        public AppsTrackerService getService() {
            return AppsTrackerService.this;
        }
    }
}