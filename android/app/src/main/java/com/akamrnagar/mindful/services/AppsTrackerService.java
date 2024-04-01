package com.akamrnagar.mindful.services;

import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.SharedPreferences;
import android.os.Binder;
import android.os.IBinder;

import androidx.annotation.Nullable;

import com.akamrnagar.mindful.helpers.NotificationHelper;
import com.akamrnagar.mindful.receivers.LockUnlockReceiver;
import com.akamrnagar.mindful.utils.AppConstants;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Iterator;

import io.flutter.Log;

/**
 * This service tracks the launch of apps installed on user device and enforces usage limits.
 */
public class AppsTrackerService extends Service {
    public static final int SERVICE_ID = 301;
    public static final String ACTION_START_SERVICE = "com.akamrnagar.mindful.AppsTrackerService.START";
    public static final String ACTION_STOP_SERVICE = "com.akamrnagar.mindful.AppsTrackerService.STOP";
    private final SharedPreferences.OnSharedPreferenceChangeListener mPrefsListener = new SharedPreferences.OnSharedPreferenceChangeListener() {
        public void onSharedPreferenceChanged(SharedPreferences prefs, String key) {
            mOnSharedPrefsChanged(prefs, key);
        }
    };
    private LockUnlockReceiver mLockUnlockReceiver;


    @Override
    public void onCreate() {
        super.onCreate();
        getSharedPreferences(AppConstants.PREFS_BOX, Context.MODE_PRIVATE).registerOnSharedPreferenceChangeListener(mPrefsListener);
    }

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
        Log.d(AppConstants.DEBUG_TAG, "onDestroy() called");
        getSharedPreferences(AppConstants.PREFS_BOX, Context.MODE_PRIVATE).unregisterOnSharedPreferenceChangeListener(mPrefsListener);

        if (mLockUnlockReceiver != null) {
            mLockUnlockReceiver.dispose();
            unregisterReceiver(mLockUnlockReceiver);
        }
    }

    @Override
    public IBinder onBind(Intent intent) {
        return new TrackerServiceBinder();
    }

    public void refreshAppTimers() {
//        if (mLockUnlockReceiver != null) mLockUnlockReceiver.refreshAppTimers();
    }

    public void updateBedtimeState(boolean state) {
        if (mLockUnlockReceiver != null) mLockUnlockReceiver.updateBedtimeLockdownState(state);
    }

    public void midnightReset() {
        if (mLockUnlockReceiver != null) mLockUnlockReceiver.midnightReset();
    }


    private void mOnSharedPrefsChanged(SharedPreferences sharedPreferences, @Nullable String changedKey) {
        Log.d(AppConstants.DEBUG_TAG, "onSharedPreferenceChanged: Key changed => " + changedKey);
        if (changedKey == null) return;


        switch (changedKey)
        {
            case AppConstants.PREF_KEY_APP_TIMERS: {
                break;
            }

            default: break;
        }

        if (changedKey.equals(AppConstants.PREF_KEY_APP_TIMERS)) {
            Log.d(AppConstants.DEBUG_TAG, "onSharedPreferenceChanged: Timer map changed trying to load and deserialize");
            String jsonString = sharedPreferences.getString(AppConstants.PREF_KEY_APP_TIMERS, "");

            HashMap<String, Long> map = new HashMap<>();

            try {
                JSONObject mapObj = new JSONObject(jsonString);

                for (Iterator<String> it = mapObj.keys(); it.hasNext(); ) {
                    String key = it.next();
                    JSONObject info = new JSONObject(mapObj.getString(key));
                    map.put(key, info.getLong("timer"));
                }
            } catch (JSONException e) {
                Log.d(AppConstants.ERROR_TAG, "Error deserializing JSON to a map: " + e.getMessage());
            }


            Log.d(AppConstants.DEBUG_TAG, "onSharedPreferenceChanged: Timer map deserialization completed");
            Log.d(AppConstants.DEBUG_TAG, "onSharedPreferenceChanged: Timers =>  " + map.entrySet());

            if (mLockUnlockReceiver != null) mLockUnlockReceiver.refreshAppTimers(map);
        }
    }

    public class TrackerServiceBinder extends Binder {
        public AppsTrackerService getService() {
            return AppsTrackerService.this;
        }
    }
}