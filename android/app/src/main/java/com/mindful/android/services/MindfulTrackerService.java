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
import static com.mindful.android.services.OverlayDialogService.INTENT_EXTRA_GROUP_NAME;
import static com.mindful.android.services.OverlayDialogService.INTENT_EXTRA_PURGE_TYPE;
import static com.mindful.android.services.OverlayDialogService.INTENT_EXTRA_MAX_PROGRESS;
import static com.mindful.android.services.OverlayDialogService.INTENT_EXTRA_PACKAGE_NAME;
import static com.mindful.android.services.OverlayDialogService.INTENT_EXTRA_PROGRESS;

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
import android.os.Handler;
import android.os.IBinder;
import android.os.Looper;
import android.util.Log;

import androidx.annotation.Nullable;
import androidx.core.app.NotificationCompat;

import com.mindful.android.R;
import com.mindful.android.enums.PurgeType;
import com.mindful.android.generics.ServiceBinder;
import com.mindful.android.helpers.NotificationHelper;
import com.mindful.android.helpers.ScreenUsageHelper;
import com.mindful.android.models.AppRestrictions;
import com.mindful.android.models.PurgedReason;
import com.mindful.android.models.RestrictionGroup;
import com.mindful.android.receivers.DeviceLockUnlockReceiver;
import com.mindful.android.utils.AppConstants;
import com.mindful.android.utils.Utils;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;

/**
 * A service that tracks app usage, manages timers for app usage limits, and handles bedtime lockdowns.
 * This service operates in the background to monitor the user's app usage and provide restrictions or
 * reminders when configured limits are reached. This includes enforcing focus sessions, bedtime
 * routines, and restriction groups for apps based on user settings.
 */
public class MindfulTrackerService extends Service {

    private final String TAG = "Mindful.MindfulTrackerService";

    // Buffer of ± seconds
    private final int ALERT_BUFFER_SECONDS = 30;
    public static final String INTENT_EXTRA_DISTRACTING_APPS = "com.mindful.android.MindfulTrackerService.INTENT_EXTRA_DISTRACTING_APPS";
    public static final String ACTION_START_RESTRICTION_MODE = "com.mindful.android.MindfulTrackerService.START_RESTRICTION_MODE";
    public static final String ACTION_START_BEDTIME_MODE = "com.mindful.android.MindfulTrackerService.START_BEDTIME_MODE";
    public static final String ACTION_STOP_BEDTIME_MODE = "com.mindful.android.MindfulTrackerService.STOP_BEDTIME_MODE";
    private final ServiceBinder<MindfulTrackerService> mBinder = new ServiceBinder<>(MindfulTrackerService.this);

    private CountDownTimer mOngoingAppTimer;
    private UsageStatsManager mUsageStatsManager;
    private DeviceLockUnlockReceiver mLockUnlockReceiver;

    private final HashMap<String, PurgedReason> mPurgedApps = new HashMap<>();
    private final HashMap<String, Integer> mAppsLaunchCount = new HashMap<>();


    private HashMap<String, AppRestrictions> mAppsRestrictions = new HashMap<>();
    private HashMap<Integer, RestrictionGroup> mRestrictionGroups = new HashMap<>();
    private HashSet<String> mBedtimeDistractingApps = new HashSet<>(0);
    private HashSet<String> mFocusSessionDistractingApps = new HashSet<>(0);

    private boolean mIsServiceRunning = false;

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

        Log.d(TAG, "startTrackingService: Foreground service started");
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        if (intent == null) return START_NOT_STICKY;
        String action = Utils.getActionFromIntent(intent);

        switch (action) {
            case ACTION_START_RESTRICTION_MODE: {
                // No need to handle as the caller will also call updateRestrictionData() as soon as the binder is active
                startForegroundService();
                return START_STICKY;
            }
            case ACTION_START_BEDTIME_MODE: {
                startForegroundService();
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
                mAppsLaunchCount.clear();
                Log.d(TAG, "onStartCommand: Midnight reset completed");
                return START_STICKY;
            }
        }

        stopIfNoUsage();
        return START_NOT_STICKY;
    }


    /**
     * Starts the service in the foreground, displaying a persistent notification if it's not already running.
     */
    private void startForegroundService() {
        if (mIsServiceRunning) return;

        // Create notification
        startForeground(
                AppConstants.TRACKER_SERVICE_NOTIFICATION_ID,
                NotificationHelper.buildFgServiceNotification(
                        this,
                        getString(R.string.app_blocker_running_notification_info)
                )
        );
        Log.d(TAG, "startTrackingService: Foreground service started");
        mIsServiceRunning = true;
    }

    /**
     * Updates the restriction data with new app restrictions and restriction groups.
     * The method will stop the service if no restrictions are active.
     *
     * @param appsRestrictionsMap A map of app restrictions by package name.
     * @param restrictionGroups   A map of restriction groups by group ID.
     */
    public void updateRestrictionData(
            @Nullable HashMap<String, AppRestrictions> appsRestrictionsMap,
            @Nullable HashMap<Integer, RestrictionGroup> restrictionGroups
    ) {
        if (appsRestrictionsMap != null) mAppsRestrictions = appsRestrictionsMap;
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
     * Retrieves a map of app package names and their respective launch counts for the current day.
     *
     * @return A {@link HashMap} where each key is a package name (as a {@link String}),
     * and each value is the number of times the app has been launched today (as an {@link Integer}).
     */
    public HashMap<String, Integer> getAppsLaunchCount() {
        return mAppsLaunchCount;
    }

    /**
     * Stops the service if no timers or app restrictions are active, indicating the service is no longer needed.
     */
    private void stopIfNoUsage() {
        if (mFocusSessionDistractingApps.isEmpty()
                && mBedtimeDistractingApps.isEmpty()
                && mAppsRestrictions.isEmpty()
                && mRestrictionGroups.isEmpty()
        ) {
            Log.d(TAG, "stopIfNoUsage: The service is not required any more therefore, stopping it");
            stopForeground(STOP_FOREGROUND_REMOVE);
            stopSelf();
        }
    }

    /**
     * Handles a new app launch event, updating usage stats, launch counts, and any necessary dialog or restriction checks.
     *
     * @param packageName The package name of the app that was launched.
     */
    private void onNewAppLaunched(String packageName) {
        // Cancel running task
        cancelTimers();

        /// Update app launch count
        int launchCount = mAppsLaunchCount.getOrDefault(packageName, 0);
        launchCount++;
        mAppsLaunchCount.put(packageName, launchCount);


        /// Return if app is already purged
        if (isAppAlreadyPurged(packageName)) return;


        AppRestrictions appRestrictions = mAppsRestrictions.get(packageName);
        if (appRestrictions == null) return;

        /// Check for app launch limit
        if (appRestrictions.launchLimit > 0 && launchCount > appRestrictions.launchLimit) {
            PurgedReason reason = new PurgedReason(PurgeType.AppLaunchLimitOut);
            mPurgedApps.put(packageName, reason);
            showOverlayDialog(packageName, reason, appRestrictions.launchLimit, launchCount);
            return;
        }

        /// Fetch usage for all apps
        HashMap<String, Long> allAppsScreenUsage = ScreenUsageHelper.fetchAppUsageTodayTillNow(mUsageStatsManager);
        long leftAppLimit = Integer.MAX_VALUE;
        long leftGroupLimit = Integer.MAX_VALUE;

        /// Check for app timer
        if (appRestrictions.timerSec > 0) {
            long appScreenTime = allAppsScreenUsage.getOrDefault(packageName, 0L);
            if (appScreenTime >= appRestrictions.timerSec) {
                PurgedReason reason = new PurgedReason(PurgeType.AppTimerOut);
                mPurgedApps.put(packageName, reason);
                showOverlayDialog(packageName, reason, appRestrictions.timerSec, (int) appScreenTime);
                return;
            }

            leftAppLimit = appRestrictions.timerSec - appScreenTime;
        }

        /// Check for associated group timer
        RestrictionGroup associatedGroup = mRestrictionGroups.get(appRestrictions.associatedGroupId);
        if (associatedGroup != null && associatedGroup.timerSec > 0) {
            long groupScreenTime = associatedGroup.appsPackage.stream()
                    .mapToLong(app -> ScreenUsageHelper.fetchAppUsageTodayTillNow(mUsageStatsManager).getOrDefault(app, 0L))
                    .sum();

            if (groupScreenTime >= associatedGroup.timerSec) {
                PurgedReason reason = new PurgedReason(PurgeType.GroupTimerOut, associatedGroup.groupName);
                associatedGroup.appsPackage.forEach(app -> mPurgedApps.put(app, reason));
                showOverlayDialog(packageName, reason, associatedGroup.timerSec, Math.toIntExact(groupScreenTime));
                return;
            }

            leftGroupLimit = associatedGroup.timerSec - groupScreenTime;
        }


        // Return if do not have any left limits
        if (leftAppLimit == Integer.MAX_VALUE && leftGroupLimit == Integer.MAX_VALUE) return;

        // schedule timer for the lowest left limit from app and group
        if (associatedGroup != null && leftGroupLimit < leftAppLimit) {
            scheduleUsageAlertCountDownTimer(
                    packageName,
                    new PurgedReason(PurgeType.GroupTimerOut, associatedGroup.groupName),
                    associatedGroup.timerSec,
                    (int) leftGroupLimit,
                    appRestrictions.alertByDialog,
                    appRestrictions.alertInterval
            );
        } else {
            scheduleUsageAlertCountDownTimer(
                    packageName,
                    new PurgedReason(PurgeType.AppTimerOut),
                    appRestrictions.timerSec,
                    (int) leftAppLimit,
                    appRestrictions.alertByDialog,
                    appRestrictions.alertInterval
            );
        }
    }

    /**
     * Checks if the app is already purged or restricted and shows the appropriate overlay dialog.
     *
     * @param packageName The package name of the app to check.
     * @return True if the app is purged or restricted, false otherwise.
     */
    private boolean isAppAlreadyPurged(String packageName) {
        if (mPurgedApps.containsKey(packageName)) {
            showOverlayDialog(packageName, mPurgedApps.get(packageName), 0, 0);
            return true;
        }
        if (mFocusSessionDistractingApps.contains(packageName)) {
            showOverlayDialog(packageName, new PurgedReason(PurgeType.FocusSession), 0, 0);
            return true;
        }
        if (mBedtimeDistractingApps.contains(packageName)) {
            showOverlayDialog(packageName, new PurgedReason(PurgeType.BedtimeRoutine), 0, 0);
            return true;
        }
        return false;
    }

    /**
     * Schedules a countdown timer to alert the user of remaining time for a specific app.
     * Provides notifications or overlay dialogs based on specified alert intervals and thresholds.
     *
     * @param packageName   The package name of the app.
     * @param reason        The reason for which to schedule timer.
     * @param totalLimit    The total allowed usage time in seconds.
     * @param leftLimit     The remaining usage time in seconds.
     * @param alertByDialog True if alerts should be shown as overlay dialogs, otherwise as notifications.
     * @param alertInterval The interval at which alerts should occur.
     */
    private void scheduleUsageAlertCountDownTimer(
            String packageName,
            PurgedReason reason,
            int totalLimit,
            int leftLimit,
            boolean alertByDialog,
            int alertInterval
    ) {
        cancelTimers();

        // Remaining Times when alert will be pushed
        final ArrayList<Integer> alertTimeSeconds = new ArrayList<>(Arrays.asList(60, 5 * 60));
        for (int i = alertInterval; i <= leftLimit; i += alertInterval) {
            alertTimeSeconds.add(i);
        }

        Log.d(TAG, "scheduleUsageAlertCountDownTimer: " + alertTimeSeconds);

        new Handler(Looper.getMainLooper()).post(new Runnable() {
            @Override
            public void run() {
                mOngoingAppTimer = new CountDownTimer(leftLimit * 1000L, 60 * 1000) {
                    @Override
                    public void onTick(long millisUntilFinished) {
                        int secondsRemaining = (int) (millisUntilFinished / 1000);

                        // Check if the remaining time is close to any of the notifyTimes with the buffer
                        for (int alertTime : alertTimeSeconds) {
                            if (Math.abs(secondsRemaining - alertTime) < ALERT_BUFFER_SECONDS) {
                                if (alertByDialog) {
                                    int elapsedTime = totalLimit - secondsRemaining;
                                    showOverlayDialog(packageName, reason, totalLimit, elapsedTime);
                                } else {
                                    pushUsageAlertNotification(packageName, alertTime / 60);
                                }
                                break;
                            }
                        }
                    }

                    @Override
                    public void onFinish() {
                        mPurgedApps.put(packageName, reason);
                        showOverlayDialog(packageName, reason, totalLimit, totalLimit);
                        Log.d(TAG, "scheduleUsageAlertCountDownTimer: Ongoing countdown timer finished for package : " + packageName);
                    }
                };
                mOngoingAppTimer.start();
                Log.d(TAG, "scheduleUsageAlertCountDownTimer: Ongoing Countdown timer task scheduled for " + packageName + " :  " + new Date((leftLimit * 1000L) + System.currentTimeMillis()));
            }
        });
    }

    /**
     * Displays a notification to alert the user about the remaining usage time for an app.
     *
     * @param packageName The package name of the app.
     * @param minutesLeft The remaining time in minutes for app usage.
     */
    private void pushUsageAlertNotification(String packageName, int minutesLeft) {
        try {

            PackageManager packageManager = getPackageManager();
            ApplicationInfo info = packageManager.getApplicationInfo(packageName, PackageManager.GET_META_DATA);
            String appName = info.loadLabel(packageManager).toString();
            Drawable appIcon = packageManager.getApplicationIcon(info);

            String notificationInfo = getString(R.string.app_pause_alert_notification_info, appName);

            NotificationManager notificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
            notificationManager.notify(
                    minutesLeft,
                    new NotificationCompat.Builder(this, NOTIFICATION_CRITICAL_CHANNEL_ID)
                            .setOngoing(false)
                            .setSmallIcon(R.drawable.ic_notification)
                            .setLargeIcon(Utils.drawableToBitmap(appIcon))
                            .setContentTitle(getString(R.string.app_pause_notification_title, minutesLeft))
                            .setContentText(notificationInfo)
                            .setStyle(new NotificationCompat.BigTextStyle().bigText(notificationInfo))
                            .build()
            );

        } catch (Exception e) {
            Log.d(TAG, "pushAlertNotification: Failed to push usage alert notification for " + packageName, e);
        }
    }


    /**
     * Shows an overlay dialog to inform the user about a specific restriction event.
     *
     * @param packageName The package name of the app.
     * @param reason      The reason for which to show dialog.
     * @param maxProgress The maximum time allowed for usage.
     * @param progress    The current progress of usage time.
     */
    private void showOverlayDialog(
            String packageName,
            PurgedReason reason,
            int maxProgress,
            int progress
    ) {
        if (!Utils.isServiceRunning(this, OverlayDialogService.class.getName())) {
            Intent intent = new Intent(this, OverlayDialogService.class);
            intent.putExtra(INTENT_EXTRA_PACKAGE_NAME, packageName);
            intent.putExtra(INTENT_EXTRA_PURGE_TYPE, reason.type.toInteger());
            intent.putExtra(INTENT_EXTRA_GROUP_NAME, reason.groupName);
            intent.putExtra(INTENT_EXTRA_MAX_PROGRESS, maxProgress);
            intent.putExtra(INTENT_EXTRA_PROGRESS, progress);
            startService(intent);

            Log.d(TAG, "showOverlayDialog: Starting overlay dialog service for package : " + packageName);
        }
    }

    /**
     * Called when the device is locked or unlocked to manage the app timers accordingly.
     *
     * @param isDeviceActive Boolean indicating if the device is currently active (unlocked).
     */
    private void onDeviceLockUnlock(boolean isDeviceActive) {
        if (!isDeviceActive) {
            cancelTimers();
        }
    }

    /**
     * Cancels any currently running timers for app usage, stopping ongoing countdowns.
     */
    private void cancelTimers() {
        if (mOngoingAppTimer != null) {
            mOngoingAppTimer.cancel();
            mOngoingAppTimer = null;
            Log.d(TAG, "cancelTimers: Ongoing app timer is cancelled");
        }
    }

    @Override
    public IBinder onBind(Intent intent) {
        return mBinder;
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
