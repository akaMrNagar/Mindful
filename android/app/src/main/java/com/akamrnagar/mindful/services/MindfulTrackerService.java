package com.akamrnagar.mindful.services;

import static com.akamrnagar.mindful.generics.ServiceBinder.ACTION_START_SERVICE;
import static com.akamrnagar.mindful.generics.ServiceBinder.ACTION_STOP_SERVICE;
import static com.akamrnagar.mindful.utils.AppConstants.INTENT_EXTRA_IS_THIS_BEDTIME;
import static com.akamrnagar.mindful.utils.AppConstants.INTENT_EXTRA_PACKAGE_NAME;
import static com.akamrnagar.mindful.utils.Extensions.getOrDefault;

import android.annotation.SuppressLint;
import android.app.Service;
import android.app.usage.UsageStatsManager;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.IBinder;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.app.NotificationCompat;

import com.akamrnagar.mindful.R;
import com.akamrnagar.mindful.generics.ServiceBinder;
import com.akamrnagar.mindful.helpers.NotificationHelper;
import com.akamrnagar.mindful.helpers.ScreenUsageHelper;
import com.akamrnagar.mindful.helpers.ServicesHelper;
import com.akamrnagar.mindful.helpers.SharedPrefsHelper;
import com.akamrnagar.mindful.receivers.DeviceLockUnlockReceiver;

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
    private UsageStatsManager mUsageStatsManager;
    private HashMap<String, Long> mAppTimers = new HashMap<>();
    private HashSet<String> mPurgedApps = new HashSet<>();
    private HashSet<String> mDistractingApps = new HashSet<>();

    @Override
    public void onCreate() {
        super.onCreate();
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
        mLockUnlockReceiver = new DeviceLockUnlockReceiver(this);
        registerReceiver(mLockUnlockReceiver, lockUnlockFilter);

        // Register app launch receiver
        mAppLaunchReceiver = new AppLaunchReceiver();
        registerReceiver(mAppLaunchReceiver, new IntentFilter(ACTION_APP_LAUNCHED), Context.RECEIVER_NOT_EXPORTED);

        // Create notification
        startForeground(
                SERVICE_ID,
                new NotificationCompat.Builder(this, NotificationHelper.NOTIFICATION_OTHER_CHANNEL_ID)
                        .setSmallIcon(R.mipmap.ic_launcher)
                        .setContentTitle("Mindful service")
                        .setContentText("Mindful is now tracking app usage to help you stay focused and manage your digital habits.")
                        .setAutoCancel(true)
                        .build()
        );

        Log.d(TAG, "startTracking: Foreground service started");
        updateAppTimers();
    }

    public void updateAppTimers() {
        mAppTimers = SharedPrefsHelper.fetchAppTimers(this);
        mPurgedApps.clear();
        Log.d(TAG, "updateAppTimers: App timers updated successfully");
        stopIfNoUsage();
    }

    public void stopIfNoUsage() {
        if (!SharedPrefsHelper.fetchBedtimeSettings(this).isScheduleOn && mAppTimers.isEmpty()) {
            Log.d(TAG, "stopIfNoUsage: The service is not required any more therefore, stopping it");
            stopForeground(true);
            stopSelf();
        }
    }

    public void startStopBedtimeLockdown(boolean shouldStart, @Nullable HashSet<String> distractingApps) {
        if (shouldStart && distractingApps != null) {
            mDistractingApps = distractingApps;
            mPurgedApps.clear();

            // Broadcast launch event for last active app is may be restricted in bedtime mode
            if (mLockUnlockReceiver != null) mLockUnlockReceiver.broadcastLastAppLaunchEvent();
            Log.d(TAG, "startStopBedtimeLockdown: Bedtime lockdown started successfully");
        } else {
            mDistractingApps.clear();
            Log.d(TAG, "startStopBedtimeLockdown: Bedtime lockdown stopped successfully");
        }
    }

    public void onMidnightReset() {
        mPurgedApps.clear();
    }

    public void pauseResumeTracking(boolean shouldPause) {
        if (mLockUnlockReceiver != null) mLockUnlockReceiver.pauseResumeTracking(shouldPause);
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        // Dispose and Unregister receiver
        if (mLockUnlockReceiver != null) {
            mLockUnlockReceiver.dispose();
            unregisterReceiver(mLockUnlockReceiver);
        }

        if (mAppLaunchReceiver != null) {
            mAppLaunchReceiver.cancelTimers();
            unregisterReceiver(mAppLaunchReceiver);
        }
        Log.d(TAG, "onDestroy : Foreground service destroyed");
    }


    @Override
    public IBinder onBind(Intent intent) {
        return new ServiceBinder<>(MindfulTrackerService.this);
    }


    private class AppLaunchReceiver extends BroadcastReceiver {
        private final String TAG = "Mindful.AppLaunchReceiver";
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

            if (screenTimeSec > 0 && screenTimeSec >= appTimerSec) {
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
                intent.putExtra(INTENT_EXTRA_IS_THIS_BEDTIME, mDistractingApps.contains(packageName));
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