package com.akamrnagar.mindful.services;

import static com.akamrnagar.mindful.generics.ServiceBinder.ACTION_START_SERVICE;
import static com.akamrnagar.mindful.generics.ServiceBinder.ACTION_STOP_SERVICE;
import static com.akamrnagar.mindful.utils.Extensions.getOrDefault;

import android.annotation.SuppressLint;
import android.app.Service;
import android.app.usage.UsageStatsManager;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.SharedPreferences;
import android.os.IBinder;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.akamrnagar.mindful.generics.ServiceBinder;
import com.akamrnagar.mindful.helpers.NotificationHelper;
import com.akamrnagar.mindful.helpers.ScreenUsageHelper;
import com.akamrnagar.mindful.helpers.ServicesHelper;
import com.akamrnagar.mindful.models.BedtimeSettings;
import com.akamrnagar.mindful.receivers.DeviceLockUnlockReceiver;
import com.akamrnagar.mindful.utils.AppConstants;
import com.akamrnagar.mindful.utils.Utils;

import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Timer;
import java.util.TimerTask;

public class MindfulTrackerService extends Service {

    private static final int SERVICE_ID = 301;
    private final String TAG = "Mindful.MindfulTrackerService";
    public static final String ACTION_APP_LAUNCHED = "com.akamrnagar.mindful.ACTION_APP_LAUNCHED";
    private DeviceLockUnlockReceiver mLockUnlockReceiver;
    private AppLaunchReceiver mAppLaunchReceiver;
    private SharedPreferences mSharedPrefs;
    private UsageStatsManager mUsageStatsManager;
    private boolean areReceiversRegistered = false;
    private HashMap<String, Long> mAppTimers = new HashMap<>();
    private HashSet<String> mPurgedApps = new HashSet<>();
    private HashSet<String> mDistractingApps = new HashSet<>();

    @Override
    public void onCreate() {
        super.onCreate();
        mLockUnlockReceiver = new DeviceLockUnlockReceiver(this);
        mAppLaunchReceiver = new AppLaunchReceiver();
        mSharedPrefs = getSharedPreferences(AppConstants.PREFS_SHARED_BOX, Context.MODE_PRIVATE);
        mUsageStatsManager = (UsageStatsManager) getSystemService(Context.USAGE_STATS_SERVICE);
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        if (intent == null) return START_NOT_STICKY;
        String action = intent.getAction();

        if (ACTION_START_SERVICE.equals(action)) {
            startTrackingService();
            return START_STICKY;
        } else if (ACTION_STOP_SERVICE.equals(action)) {
            stopForeground(true);
            stopSelf();
        }

        return START_NOT_STICKY;
    }


    @SuppressLint("NewApi")
    private void startTrackingService() {
        // Register lock/unlock receiver
        IntentFilter lockUnlockFilter = new IntentFilter();
        lockUnlockFilter.addAction(Intent.ACTION_USER_PRESENT);
        lockUnlockFilter.addAction(Intent.ACTION_SCREEN_OFF);
        registerReceiver(mLockUnlockReceiver, lockUnlockFilter);

        // Register app launch receiver
        registerReceiver(mAppLaunchReceiver, new IntentFilter(ACTION_APP_LAUNCHED), Context.RECEIVER_NOT_EXPORTED);

        // Create notification
        startForeground(SERVICE_ID, NotificationHelper.createTrackingNotification(this));


        areReceiversRegistered = true;
        Log.d(TAG, "startTracking: Foreground service started");

        refreshAppTimers();
    }


    public void refreshAppTimers() {
        mAppTimers = Utils.jsonStrToStringLongHashMap(mSharedPrefs.getString(AppConstants.PREF_KEY_APP_TIMERS, ""));
        mPurgedApps.clear();
        Log.d(TAG, "reloadAppTimers: Reloaded latest app timers");
    }

    public boolean canStopTrackingService() {
        BedtimeSettings bedtimeSettings = new BedtimeSettings(mSharedPrefs.getString(AppConstants.PREF_KEY_BEDTIME_SETTINGS, ""));
        return mAppTimers.isEmpty() && (!bedtimeSettings.isScheduleOn || bedtimeSettings.distractingApps.isEmpty());
    }

    public void startStopBedtimeLockdown(boolean shouldStart, @Nullable HashSet<String> distractingApps) {
        if (shouldStart && distractingApps != null) {
            mDistractingApps = distractingApps;
            mPurgedApps.clear();

            // Broadcast launch event for last active app is may be restricted in bedtime mode
            if (mLockUnlockReceiver != null) mLockUnlockReceiver.BroadcastLastAppLaunchEvent();
            Log.d(TAG, "startStopBedtimeLockdown: Bedtime lockdown started successfully");
        } else {
            mDistractingApps.clear();
            Log.d(TAG, "startStopBedtimeLockdown: Bedtime lockdown stopped successfully");
        }
    }


    @Override
    public void onDestroy() {
        super.onDestroy();

        // Dispose and Unregister receiver
        if (areReceiversRegistered) {
            mLockUnlockReceiver.dispose();
            mAppLaunchReceiver.cancelTimers();
            unregisterReceiver(mLockUnlockReceiver);
            unregisterReceiver(mAppLaunchReceiver);
        }

        if (!canStopTrackingService()) {
            Log.d(TAG, "onDestroy: Service stopped forcefully, trying to restart it");
            startService(new Intent(this, MindfulTrackerService.class).setAction(ACTION_START_SERVICE));
            return;
        }

        Log.d(TAG, "onDestroy : Foreground service destroyed");
    }


    @Override
    public IBinder onBind(Intent intent) {
        return new ServiceBinder<MindfulTrackerService>(MindfulTrackerService.this);
    }


    private class AppLaunchReceiver extends BroadcastReceiver {
        private final String TAG = "Mindful.AppLaunchReceiver";
        public static final String ACTION_APP_LAUNCHED = "com.akamrnagar.mindful.ACTION_APP_LAUNCHED";
        public static final String INTENT_EXTRA_PACKAGE_NAME = "launchedAppPackageName";
        private Timer mAppUsageRecheckTimer;

        @Override
        public void onReceive(Context context, @NonNull Intent intent) {
            String action = intent.getAction();
            if (ACTION_APP_LAUNCHED.equals(action)) {

                // Get the package name of the launched app
                String packageName = intent.getStringExtra(INTENT_EXTRA_PACKAGE_NAME);
                if (packageName == null || packageName.isEmpty()) return;
                Log.d(TAG, "onReceive: App launch event received with package ** " + packageName + " **");


                // Cancel running task
                cancelTimers();

                if (mDistractingApps.contains(packageName)) {
                    // If bedtime mode is ON
                    showOverlayDialog(packageName);
                } else if (mAppTimers.containsKey(packageName)) {
                    // Else if app has timer
                    onTimerAppLaunched(packageName);
                }

            }
        }


        private void onTimerAppLaunched(String packageName) {
            if (mPurgedApps.contains(packageName)) {
                showOverlayDialog(packageName);
                return;
            }

            // fetch usage and check if timer ran out then start overlay dialog service
            long screenTimeSec = ScreenUsageHelper.fetchAppUsageTodayTillNow(mUsageStatsManager, packageName);
            long appTimerSec = getOrDefault(mAppTimers, packageName, 0L);

            if (screenTimeSec >= appTimerSec) {
                mPurgedApps.add(packageName);
                showOverlayDialog(packageName);
                return;
            }

            // schedule timer for rechecking the app if it is still running
            long delayMs = (appTimerSec - screenTimeSec) * 1000;

            mAppUsageRecheckTimer = new Timer();
            mAppUsageRecheckTimer.schedule(new TimerTask() {
                @Override
                public void run() {
                    mPurgedApps.add(packageName);
                    showOverlayDialog(packageName);
                    Log.d(TAG, "handleTimerAppLaunch: Executed timer task for package : " + packageName);
                }
            }, delayMs);

            Log.d(TAG, "handleTimerAppLaunch: Timer task scheduled for " + packageName + " :  " + new Date(delayMs + System.currentTimeMillis()));
        }

        private void showOverlayDialog(String packageName) {
            if (!ServicesHelper.isServiceRunning(MindfulTrackerService.this, OverlayDialogService.class.getName())) {
                Intent intent = new Intent(MindfulTrackerService.this, OverlayDialogService.class);
                intent.putExtra(INTENT_EXTRA_PACKAGE_NAME, packageName);
                startService(intent);
                Log.d(TAG, "showOverlayDialog: Starting overlay dialog service for package : " + packageName);
            }
        }


        protected void cancelTimers() {
            if (mAppUsageRecheckTimer != null) {
                mAppUsageRecheckTimer.purge();
                mAppUsageRecheckTimer.cancel();
                mAppUsageRecheckTimer = null;
                Log.d(TAG, "cancelTimers: Usage recheck timer cancelled");
            }
        }
    }
}