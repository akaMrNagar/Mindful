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

import android.app.NotificationManager;
import android.app.Service;
import android.app.usage.UsageStatsManager;
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
import com.mindful.android.helpers.NotificationHelper;
import com.mindful.android.helpers.ScreenUsageHelper;
import com.mindful.android.models.RestrictionGroup;
import com.mindful.android.receivers.DeviceLockUnlockReceiver;
import com.mindful.android.utils.AppConstants;
import com.mindful.android.utils.Utils;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;

/**
 * A service that tracks app usage, manages timers for app usage limits, and handles bedtime lockdowns.
 */
public class MindfulTrackerService extends Service {

    private final String TAG = "Mindful.MindfulTrackerService";
    public static final String INTENT_EXTRA_DISTRACTING_APPS = "com.mindful.android.MindfulTrackerService.INTENT_EXTRA_DISTRACTING_APPS";
    public static final String ACTION_START_RESTRICTION_MODE = "com.mindful.android.MindfulTrackerService.START_RESTRICTION_MODE";
    public static final String ACTION_START_BEDTIME_MODE = "com.mindful.android.MindfulTrackerService.START_BEDTIME_MODE";
    public static final String ACTION_STOP_BEDTIME_MODE = "com.mindful.android.MindfulTrackerService.STOP_BEDTIME_MODE";

    private CountDownTimer mOngoingAppTimer;
    private UsageStatsManager mUsageStatsManager;
    private DeviceLockUnlockReceiver mLockUnlockReceiver;

    private final HashSet<String> mPurgedApps = new HashSet<>();

    private HashMap<String, Long> mAppTimers = new HashMap<>();
    private HashSet<String> mBedtimeDistractingApps = new HashSet<>(0);
    private HashSet<String> mFocusSessionDistractingApps = new HashSet<>(0);
    private List<RestrictionGroup> mRestrictionGroups = new ArrayList<>(0);

    @Override
    public void onCreate() {
        super.onCreate();
        mUsageStatsManager = (UsageStatsManager) getSystemService(Context.USAGE_STATS_SERVICE);

        // Register lock/unlock receiver
        IntentFilter lockUnlockFilter = new IntentFilter();
        lockUnlockFilter.addAction(Intent.ACTION_USER_PRESENT);
        lockUnlockFilter.addAction(Intent.ACTION_SCREEN_OFF);
        mLockUnlockReceiver = new DeviceLockUnlockReceiver(mUsageStatsManager, this::onDeviceLockUnlock, this::onNewAppLaunched);
        registerReceiver(mLockUnlockReceiver, lockUnlockFilter);

        // Create notification
        startForeground(AppConstants.TRACKER_SERVICE_NOTIFICATION_ID, NotificationHelper.buildFgServiceNotification(this, getString(R.string.app_blocker_running_notification_info)));

        Log.d(TAG, "startTrackingService: Foreground service started");
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        if (intent == null) return START_NOT_STICKY;
        String action = Utils.getActionFromIntent(intent);

        switch (action) {
            case ACTION_START_RESTRICTION_MODE: {
                // No need to handle as the caller will also call updateRestrictionData() as soon as the binder is active
                return START_STICKY;
            }
            case ACTION_START_BEDTIME_MODE: {
                mBedtimeDistractingApps = Utils.getStringHashSetFromIntent(intent, INTENT_EXTRA_DISTRACTING_APPS);
                if (mLockUnlockReceiver != null) mLockUnlockReceiver.broadcastLastAppLaunchEvent();
                Log.d(TAG, "onStartCommand: Bedtime routine STARTED successfully");
                return START_STICKY;
            }
            case ACTION_STOP_BEDTIME_MODE: {
                mBedtimeDistractingApps.clear();
                Log.d(TAG, "onStartCommand: Bedtime routine STOPPED successfully");
                stopIfNoUsage();
                return START_STICKY;
            }
            case ACTION_MIDNIGHT_SERVICE_RESET: {
                mPurgedApps.clear();
                Log.d(TAG, "onStartCommand: Midnight reset completed");
                return START_STICKY;
            }
        }

        stopIfNoUsage();
        return START_NOT_STICKY;
    }

    private void onDeviceLockUnlock(boolean isDeviceActive) {
        if (!isDeviceActive) {
            cancelTimers();
        }
    }

    public void updateRestrictionData(
            @Nullable HashMap<String, Long> appTimers,
            @Nullable List<RestrictionGroup> restrictionGroups
    ) {
        if (appTimers != null) mAppTimers = appTimers;
        if (restrictionGroups != null) mRestrictionGroups = restrictionGroups;
        stopIfNoUsage();
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


    /**
     * Stops the service if no timers are active and no distracting apps.
     */
    private void stopIfNoUsage() {
        if (mBedtimeDistractingApps.isEmpty()
                && mAppTimers.isEmpty()
                && mFocusSessionDistractingApps.isEmpty()
                && mRestrictionGroups.isEmpty()
        ) {
            Log.d(TAG, "stopIfNoUsage: The service is not required any more therefore, stopping it");
            stopForeground(STOP_FOREGROUND_REMOVE);
            stopSelf();
        }
    }

    private void onNewAppLaunched(String packageName) {
        // Cancel running task
        cancelTimers();

        if (mPurgedApps.contains(packageName)) {
            showOverlayDialog(packageName, DialogType.TimerOut);
        } else if (mFocusSessionDistractingApps.contains(packageName)) {
            showOverlayDialog(packageName, DialogType.FocusSession);
        } else if (mBedtimeDistractingApps.contains(packageName)) {
            showOverlayDialog(packageName, DialogType.BedtimeRoutine);
        } else if (mAppTimers.containsKey(packageName)) {
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
        } else {
            // Check if app belongs to any restriction group
            for (RestrictionGroup group : mRestrictionGroups) {
                if (group.appsPackage.contains(packageName)) {
                    handleAppLaunchedFromRestrictionGroup(group, packageName);
                    return;
                }
            }
        }
    }


    /**
     * Handles the case where an app from a restriction group is launched.
     *
     * @param group       The Restriction Group which the app is part of.
     * @param packageName The package name of the launched app.
     */
    private void handleAppLaunchedFromRestrictionGroup(@NonNull RestrictionGroup group, String packageName) {
        HashMap<String, Long> screenUsage = ScreenUsageHelper.fetchAppUsageTodayTillNow(mUsageStatsManager);

        Long totalScreenTime = 0L;
        for (String app : group.appsPackage) {
            totalScreenTime += screenUsage.getOrDefault(app, 0L);
        }

        if (group.timerSec > 0 && totalScreenTime >= group.timerSec) {
            mPurgedApps.addAll(group.appsPackage);
            showOverlayDialog(packageName, DialogType.TimerOut);
            return;
        }

        // Schedule Ongoing timer for alerts and rechecking if app is running but timer is not over
        long leftTimeSeconds = (group.timerSec - totalScreenTime);
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


            String msg = getString(R.string.app_pause_alert_notification_info, appName);
            NotificationManager notificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
            notificationManager.notify(
                    minutesLeft,
                    new NotificationCompat.Builder(this, NOTIFICATION_CRITICAL_CHANNEL_ID)
                            .setOngoing(false)
                            .setSmallIcon(R.drawable.ic_notification)
                            .setLargeIcon(Utils.drawableToBitmap(appIcon))
                            .setContentTitle(getString(R.string.app_pause_notification_title, minutesLeft))
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
        if (!Utils.isServiceRunning(this, OverlayDialogService.class.getName())) {
            Intent intent = new Intent(this, OverlayDialogService.class);
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

    @Override
    public IBinder onBind(Intent intent) {
        return new ServiceBinder<>(MindfulTrackerService.this);
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        // Dispose and Unregister receiver
        if (mLockUnlockReceiver != null) {
            mLockUnlockReceiver.dispose();
            unregisterReceiver(mLockUnlockReceiver);
        }

        Log.d(TAG, "onDestroy: Tracking service destroyed");
    }
}
