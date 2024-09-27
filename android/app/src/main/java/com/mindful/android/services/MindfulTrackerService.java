/*
 *
 *  *
 *  *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *  *
 *  *  * This source code is licensed under the GPL-2.0 license license found in the
 *  *  * LICENSE file in the root directory of this source tree.
 *  *
 *
 */

package com.mindful.android.services;

import static com.mindful.android.helpers.NotificationHelper.NOTIFICATION_CRITICAL_CHANNEL_ID;
import static com.mindful.android.receivers.alarm.MidnightResetReceiver.ACTION_MIDNIGHT_SERVICE_RESET;
import static com.mindful.android.services.OverlayDialogService.INTENT_EXTRA_DIALOG_TYPE;
import static com.mindful.android.services.OverlayDialogService.INTENT_EXTRA_PACKAGE_NAME;

import android.annotation.SuppressLint;
import android.app.NotificationManager;
import android.app.Service;
import android.app.usage.UsageStatsManager;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.graphics.drawable.Drawable;
import android.os.CountDownTimer;
import android.os.IBinder;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.app.NotificationCompat;

import com.mindful.android.R;
import com.mindful.android.enums.DialogType;
import com.mindful.android.generics.ServiceBinder;
import com.mindful.android.generics.SuccessCallback;
import com.mindful.android.helpers.NotificationHelper;
import com.mindful.android.helpers.ScreenUsageHelper;
import com.mindful.android.helpers.SharedPrefsHelper;
import com.mindful.android.receivers.DeviceLockUnlockReceiver;
import com.mindful.android.utils.AppConstants;
import com.mindful.android.utils.Utils;

import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;

/**
 * A service that tracks app usage, manages timers for app usage limits, and handles bedtime lockdowns.
 */
public class MindfulTrackerService extends Service {

    private final String TAG = "Mindful.MindfulTrackerService";
    public static final String ACTION_NEW_APP_LAUNCHED = "com.mindful.android.ACTION_NEW_APP_LAUNCHED";
    public static final String ACTION_START_SERVICE_TIMER_MODE = "com.mindful.android.MindfulTrackerService.START_SERVICE_TIMER";
    public static final String ACTION_START_SERVICE_BEDTIME_MODE = "com.mindful.android.MindfulTrackerService.START_SERVICE_BEDTIME";
    public static final String ACTION_STOP_SERVICE_BEDTIME_MODE = "com.mindful.android.MindfulTrackerService.STOP_SERVICE_BEDTIME";
    private final SuccessCallback<Boolean> mDeviceLockUnlockCallback = new SuccessCallback<Boolean>() {
        @Override
        public void onSuccess(Boolean isDeviceActive) {
            if (!isDeviceActive && mAppLaunchReceiver != null) {
                mAppLaunchReceiver.cancelTimers();
            }
        }
    };

    private boolean mIsServiceRunning = false;

    private UsageStatsManager mUsageStatsManager;
    private DeviceLockUnlockReceiver mLockUnlockReceiver;
    private AppLaunchReceiver mAppLaunchReceiver;

    private HashMap<String, Long> mAppTimers = new HashMap<>();
    private final HashSet<String> mPurgedApps = new HashSet<>();
    private HashSet<String> mBedtimeDistractingApps = new HashSet<>(0);
    private HashSet<String> mFocusSessionDistractingApps = new HashSet<>(0);


    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        String action = Utils.getActionFromIntent(intent);

        switch (action) {
            // Only start service
            case ACTION_START_SERVICE_TIMER_MODE: {
                startTrackingService();
                return START_STICKY;
            }
            // Start service if already not running along with bedtime routine
            case ACTION_START_SERVICE_BEDTIME_MODE: {
                startTrackingService();
                startStopBedtimeRoutine(true);
                return START_STICKY;
            }
            // Stop bedtime routine
            case ACTION_STOP_SERVICE_BEDTIME_MODE:
                startStopBedtimeRoutine(false);
                break;

            // Time to reset purged app's list
            case ACTION_MIDNIGHT_SERVICE_RESET:
                mPurgedApps.clear();
                Log.d(TAG, "onStartCommand: Midnight reset completed");
                break;
        }

        stopIfNoUsage();
        return START_NOT_STICKY;
    }

    // REVIEW: Suppressing api warnings
    @SuppressLint("NewApi")
    private void startTrackingService() {
        mAppTimers = SharedPrefsHelper.fetchAppTimers(this);
        if (mIsServiceRunning) return;

        mUsageStatsManager = (UsageStatsManager) getSystemService(Context.USAGE_STATS_SERVICE);

        // Register lock/unlock receiver
        IntentFilter lockUnlockFilter = new IntentFilter();
        lockUnlockFilter.addAction(Intent.ACTION_USER_PRESENT);
        lockUnlockFilter.addAction(Intent.ACTION_SCREEN_OFF);
        mLockUnlockReceiver = new DeviceLockUnlockReceiver(this, mUsageStatsManager, mDeviceLockUnlockCallback);
        registerReceiver(mLockUnlockReceiver, lockUnlockFilter);

        // Register app launch receiver
        mAppLaunchReceiver = new AppLaunchReceiver();
        registerReceiver(mAppLaunchReceiver, new IntentFilter(ACTION_NEW_APP_LAUNCHED), Context.RECEIVER_NOT_EXPORTED);

        // Create notification
        startForeground(
                AppConstants.TRACKER_SERVICE_NOTIFICATION_ID,
                NotificationHelper.buildFgServiceNotification(
                        this,
                        "Mindful is now tracking app usage to help you stay focused and manage your digital habits."
                )
        );
        Log.d(TAG, "startTrackingService: Foreground service started");
        mIsServiceRunning = true;
    }

    /**
     * Updates app timers from shared preferences and stops the service if no timers are active.
     */
    public void updateAppTimers() {
        mAppTimers = SharedPrefsHelper.fetchAppTimers(this);
        mPurgedApps.clear();
        Log.d(TAG, "updateAppTimers: App timers updated successfully");
        stopIfNoUsage();
    }

    /**
     * Stops the service if no timers are active and no distracting apps.
     */
    private void stopIfNoUsage() {
        if (mBedtimeDistractingApps.isEmpty() && mAppTimers.isEmpty() && mFocusSessionDistractingApps.isEmpty()) {
            Log.d(TAG, "stopIfNoUsage: The service is not required any more therefore, stopping it");
            stopForeground(true);
            stopSelf();
        }
    }

    /**
     * Starts or stops bedtime lockdown based on the passed flag.
     *
     * @param shouldStart True to start, false to stop.
     */
    private void startStopBedtimeRoutine(boolean shouldStart) {
        if (shouldStart) {
            mBedtimeDistractingApps = SharedPrefsHelper.fetchBedtimeSettings(this).distractingApps;
            mPurgedApps.clear();

            Log.d(TAG, "startStopBedtimeRoutine: Bedtime routine STARTED successfully");
            // Broadcast launch event for last active app it may be restricted in bedtime mode
            if (mLockUnlockReceiver != null) mLockUnlockReceiver.broadcastLastAppLaunchEvent();

        } else {
            mBedtimeDistractingApps.clear();
            Log.d(TAG, "startStopBedtimeRoutine: Bedtime routine STOPPED successfully");
            stopIfNoUsage();
        }
    }

    /**
     * Starts or stops or updates Focus Session on the basis of passed distractingApps.
     * If the passed hash set is null then STOP session otherwise START or UPDATE session if already active.
     *
     * @param distractingApps Hashset of strings of distracting app's packages.
     */
    public void startStopUpdateFocusSession(@Nullable HashSet<String> distractingApps) {
        if (distractingApps != null) {
            mFocusSessionDistractingApps = distractingApps;
            mPurgedApps.clear();
            Log.d(TAG, "startStopUpdateFocusSession: Focus Session STARTED or UPDATED successfully");
        } else {
            mFocusSessionDistractingApps.clear();
            Log.d(TAG, "startStopUpdateFocusSession: Focus Session STOPPED successfully");
            stopIfNoUsage();
        }
    }

    /**
     * Pauses or resumes tracking based on the given flag.
     *
     * @param shouldPause True to pause, false to resume.
     */
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

        Log.d(TAG, "onDestroy: Tracking service destroyed");
    }

    @Override
    public IBinder onBind(Intent intent) {
        return new ServiceBinder<>(MindfulTrackerService.this);
    }

    /**
     * BroadcastReceiver that listens for app launch events and manages app timers.
     */
    private class AppLaunchReceiver extends BroadcastReceiver {
        private final String TAG = "Mindful.AppLaunchReceiver";
        private CountDownTimer mOngoingAppTimer;

        @Override
        public void onReceive(Context context, @NonNull Intent intent) {
            String action = intent.getAction();
            if (ACTION_NEW_APP_LAUNCHED.equals(action)) {

                // Get the package name of the launched app
                String packageName = intent.getStringExtra(INTENT_EXTRA_PACKAGE_NAME);
                if (packageName == null || packageName.isEmpty()) return;
                Log.d(TAG, "onReceive: App launch event received with package ** " + packageName + " **");

                // Cancel running task
                cancelTimers();

                if (mFocusSessionDistractingApps.contains(packageName)) {
                    // If focus session is ON
                    showOverlayDialog(packageName, DialogType.FocusSession);
                } else if (mBedtimeDistractingApps.contains(packageName)) {
                    // If bedtime mode is ON
                    showOverlayDialog(packageName, DialogType.BedtimeRoutine);
                } else if (mAppTimers.containsKey(packageName)) {
                    // Else if app has timer
                    onTimerAppLaunched(packageName);
                }
            }
        }

        /**
         * Handles the case where an app with a timer is launched.
         *
         * @param packageName The package name of the launched app.
         */
        private void onTimerAppLaunched(String packageName) {
            if (mPurgedApps.contains(packageName)) {
                showOverlayDialog(packageName, DialogType.TimerOut);
                return;
            }

            // Fetch usage and check if timer ran out then start overlay dialog service
            long screenTimeSec = ScreenUsageHelper.fetchAppUsageTodayTillNow(mUsageStatsManager, packageName);
            long appTimerSec = mAppTimers.getOrDefault(packageName, 0L);

            if (screenTimeSec > 0 && screenTimeSec >= appTimerSec) {
                mPurgedApps.add(packageName);
                showOverlayDialog(packageName, DialogType.TimerOut);
                return;
            }

            // Schedule Ongoing timer for alerts and rechecking if app is running but timer is not over
            long leftTimeSeconds = (appTimerSec - screenTimeSec);
            scheduleUsageAlertCountDownTimer(packageName, (int) leftTimeSeconds);
        }


        /**
         * Schedule a countdown timer for the app if it is still running and
         * alert user about the remaining time with notification
         *
         * @param packageName     The package name of the launched app.
         * @param leftTimeSeconds Time in seconds left from the app's timer w.r.t screen time
         */
        private void scheduleUsageAlertCountDownTimer(String packageName, int leftTimeSeconds) {
            // Times when alert notification will be pushed
            final int[] alertTimeSeconds = {60, 5 * 60, 10 * 60, 20 * 60};

            // Buffer of ± seconds
            final int bufferSeconds = 30;

            mOngoingAppTimer = new CountDownTimer(leftTimeSeconds * 1000L, 60 * 1000) {
                @Override
                public void onTick(long millisUntilFinished) {
                    int secondsRemaining = (int) (millisUntilFinished / 1000);

                    // Check if the remaining time is close to any of the notifyTimes with the buffer
                    for (int alertTime : alertTimeSeconds) {
                        if (Math.abs(secondsRemaining - alertTime) < bufferSeconds) {
                            pushUsageAlertNotification(packageName, alertTime / 60);
                            break;
                        }
                    }

                }

                @Override
                public void onFinish() {
                    mPurgedApps.add(packageName);
                    showOverlayDialog(packageName, DialogType.TimerOut);
                    Log.d(TAG, "scheduleUsageAlertCountDownTimer: Ongoing countdown timer finished for package : " + packageName);
                }
            };

            mOngoingAppTimer.start();
            Log.d(TAG, "scheduleUsageAlertCountDownTimer: Ongoing Countdown timer task scheduled for " + packageName + " :  " + new Date((leftTimeSeconds * 1000L) + System.currentTimeMillis()));
        }

        /**
         * Push an alert notification with the launched app's icon and name
         * and let user know about the remaining time
         *
         * @param packageName The package name of the launched app.
         * @param minutesLeft Time in minutes left from the app's timer w.r.t screen time
         */
        private void pushUsageAlertNotification(String packageName, int minutesLeft) {
            try {
                PackageManager packageManager = getPackageManager();
                ApplicationInfo info = packageManager.getApplicationInfo(packageName, PackageManager.GET_META_DATA);
                String appName = info.loadLabel(packageManager).toString();
                Drawable appIcon = packageManager.getApplicationIcon(info);


                String msg = appName + " will be paused for the rest of the day";
                NotificationManager notificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
                notificationManager.notify(
                        minutesLeft,
                        new NotificationCompat.Builder(MindfulTrackerService.this, NOTIFICATION_CRITICAL_CHANNEL_ID)
                                .setOngoing(false)
                                .setSmallIcon(R.drawable.ic_notification)
                                .setLargeIcon(Utils.drawableToBitmap(appIcon))
                                .setContentTitle(minutesLeft + " minutes left")
                                .setContentText(msg)
                                .setStyle(new NotificationCompat.BigTextStyle().bigText(msg))
                                .build()
                );

            } catch (Exception e) {
                Log.d(TAG, "pushAlertNotification: Failed to push usage alert notification for " + packageName, e);
            }
        }

        /**
         * Shows an overlay dialog for the given app package.
         *
         * @param packageName The package name of the app.
         */
        private void showOverlayDialog(String packageName, DialogType dialogType) {
            if (!Utils.isServiceRunning(MindfulTrackerService.this, OverlayDialogService.class.getName())) {
                Intent intent = new Intent(MindfulTrackerService.this, OverlayDialogService.class);
                intent.putExtra(INTENT_EXTRA_PACKAGE_NAME, packageName);
                intent.putExtra(INTENT_EXTRA_DIALOG_TYPE, dialogType.toInteger());
                startService(intent);
                Log.d(TAG, "showOverlayDialog: Starting overlay dialog service for package : " + packageName);
            }
        }

        /**
         * Cancels any scheduled timers for app usage rechecking.
         */
        protected void cancelTimers() {
            if (mOngoingAppTimer != null) {
                mOngoingAppTimer.cancel();
                mOngoingAppTimer = null;
                Log.d(TAG, "cancelTimers: Ongoing app timer is cancelled");
            }
        }
    }
}
