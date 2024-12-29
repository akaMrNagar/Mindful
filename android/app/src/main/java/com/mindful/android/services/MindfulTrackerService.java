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

import static com.mindful.android.generics.ServiceBinder.ACTION_BIND_TO_MINDFUL;
import static com.mindful.android.generics.ServiceBinder.ACTION_START_MINDFUL_SERVICE;
import static com.mindful.android.helpers.NotificationHelper.NOTIFICATION_CRITICAL_CHANNEL_ID;
import static com.mindful.android.utils.AppConstants.INTENT_EXTRA_DIALOG_INFO;
import static com.mindful.android.utils.AppConstants.INTENT_EXTRA_MAX_PROGRESS;
import static com.mindful.android.utils.AppConstants.INTENT_EXTRA_PACKAGE_NAME;
import static com.mindful.android.utils.AppConstants.INTENT_EXTRA_PROGRESS;

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

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.app.NotificationCompat;

import com.mindful.android.R;
import com.mindful.android.generics.ServiceBinder;
import com.mindful.android.helpers.NotificationHelper;
import com.mindful.android.helpers.ScreenUsageHelper;
import com.mindful.android.helpers.SharedPrefsHelper;
import com.mindful.android.models.AppRestrictions;
import com.mindful.android.models.PurgedReason;
import com.mindful.android.models.RestrictionGroup;
import com.mindful.android.receivers.DeviceLockUnlockReceiver;
import com.mindful.android.utils.AppConstants;
import com.mindful.android.utils.Utils;

import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.Set;
import java.util.concurrent.atomic.AtomicReference;

/**
 * A service that tracks app usage, manages timers for app usage limits, and handles bedtime lockdowns.
 * This service operates in the background to monitor the user's app usage and provide restrictions or
 * reminders when configured limits are reached. This includes enforcing focus sessions, bedtime
 * routines, and restriction groups for apps based on user settings.
 */
public class MindfulTrackerService extends Service {

    private final String TAG = "Mindful.MindfulTrackerService";
    private final ServiceBinder<MindfulTrackerService> mBinder = new ServiceBinder<>(MindfulTrackerService.this);

    private final AtomicReference<CountDownTimer> mAtomicOngoingAppTimer = new AtomicReference<>(null);
    private UsageStatsManager mUsageStatsManager;
    private DeviceLockUnlockReceiver mLockUnlockReceiver;

    private final HashMap<String, PurgedReason> mPurgedApps = new HashMap<>();
    private final HashMap<String, Integer> mAppsLaunchCount = new HashMap<>();

    private HashMap<String, AppRestrictions> mAppsRestrictions = new HashMap<>(0);
    private HashMap<Integer, RestrictionGroup> mRestrictionGroups = new HashMap<>(0);
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
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        String action = Utils.getActionFromIntent(intent);

        if (action.equals(ACTION_START_MINDFUL_SERVICE)) {
            startFgService();
            return START_STICKY;
        }

        stopIfNoUsage();
        return START_NOT_STICKY;
    }

    private void startFgService() {
        if (mIsServiceRunning) return;
        try {
            startForeground(
                    AppConstants.TRACKER_SERVICE_NOTIFICATION_ID,
                    NotificationHelper.buildFgServiceNotification(
                            this,
                            getString(R.string.app_blocker_running_notification_info)
                    )
            );
            mIsServiceRunning = true;
            Log.d(TAG, "startFgService: TRACKER service started successfully");
        } catch (Exception e) {
            Log.e(TAG, "startFgService: Failed to start TRACKER service", e);
            SharedPrefsHelper.insertCrashLogToPrefs(this, e);
            stopIfNoUsage();
        }
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
        mPurgedApps.clear();
        Log.d(TAG, "updateRestrictionData: Restriction data updated");
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
            Log.d(TAG, "startStopUpdateFocusSession: Focus Session STARTED or UPDATED successfully");
        } else {
            mFocusSessionDistractingApps.clear();
            Log.d(TAG, "startStopUpdateFocusSession: Focus Session STOPPED successfully");
            stopIfNoUsage();
        }
    }

    /**
     * Starts or stops or updates Bedtime Mode on the basis of passed distractingApps.
     * If the passed hash set is null then STOP routine otherwise START routine.
     *
     * @param distractingApps Hashset of strings of distracting app's packages.
     */
    public void startStopBedtimeMode(@Nullable HashSet<String> distractingApps) {
        if (distractingApps != null) {
            mBedtimeDistractingApps = distractingApps;
            if (mLockUnlockReceiver != null) mLockUnlockReceiver.broadcastLastAppLaunchEvent();
            Log.d(TAG, "startStopBedtimeMode: Bedtime routine STARTED successfully");
        } else {
            mBedtimeDistractingApps.clear();
            Log.d(TAG, "startStopBedtimeMode: Bedtime routine STOPPED successfully");
            stopIfNoUsage();
        }
    }

    /**
     * Reset service data at midnight for the next day
     */
    public void midnightServiceReset() {
        mPurgedApps.clear();
        mAppsLaunchCount.clear();
        Log.d(TAG, "midnightServiceReset: Midnight reset completed");
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
        Log.d(TAG, "onNewAppLaunched: App launch event received with package: " + packageName);

        // Cancel running task
        cancelTimers();

        /// Update app launch count
        int launchCount = mAppsLaunchCount.getOrDefault(packageName, 0);
        launchCount++;
        mAppsLaunchCount.put(packageName, launchCount);

        /// Return if app is already purged
        if (isAppAlreadyPurged(packageName)) return;

        /// Return if no restriction applied
        AppRestrictions appRestrictions = mAppsRestrictions.get(packageName);
        if (appRestrictions == null) return;

        PurgedReason timerReason = null;
        long timerDelayMS = Long.MAX_VALUE;

        /// Check for app launch limit
        if (appRestrictions.launchLimit > 0 && launchCount > appRestrictions.launchLimit) {
            Log.d(TAG, "onNewAppLaunched: App's launch limit ran out");
            PurgedReason reason = new PurgedReason(getString(R.string.app_paused_dialog_info_for_launch_count_out));
            mPurgedApps.put(packageName, reason);
            showOverlayDialog(packageName, reason);
            return;
        }

        /// Check for app's active period
        if (appRestrictions.periodDurationInMins > 0) {
            int periodEndTimeMinutes = appRestrictions.activePeriodStart + appRestrictions.periodDurationInMins;

            /// Outside active period
            if (Utils.isTimeOutsideTODs(appRestrictions.activePeriodStart, periodEndTimeMinutes)) {
                Log.d(TAG, "onNewAppLaunched: App's active period is over");
                PurgedReason reason = new PurgedReason(getString(R.string.app_paused_dialog_info_for_active_period_over));
                showOverlayDialog(packageName, reason);
                return;
            }

            /// Launched between active period so set timer for period ending
            long willOverInMs = Utils.todDifferenceFromNow(periodEndTimeMinutes);
            if (willOverInMs < timerDelayMS) {
                timerReason = null;
                timerDelayMS = willOverInMs;
            }
        }

        /// Fetch usage for all apps
        HashMap<String, Long> allAppsScreenUsage = ScreenUsageHelper.fetchAppUsageTodayTillNow(mUsageStatsManager);

        /// Check for app timer
        if (appRestrictions.timerSec > 0) {
            long appScreenTimeSec = allAppsScreenUsage.getOrDefault(packageName, 0L);

            /// App timer ran out
            if (appScreenTimeSec >= appRestrictions.timerSec) {
                Log.d(TAG, "onNewAppLaunched: App's timer is over");
                PurgedReason reason = new PurgedReason(getString(R.string.app_paused_dialog_info_for_app_timer_out), appRestrictions.timerSec, appScreenTimeSec);
                mPurgedApps.put(packageName, reason);
                showOverlayDialog(packageName, reason);
                return;
            }

            /// App timer left so update recall delay
            long leftAppLimitMs = (appRestrictions.timerSec - appScreenTimeSec) * 1000;
            if (leftAppLimitMs < timerDelayMS) {
                timerReason = new PurgedReason(getString(R.string.app_paused_dialog_info_for_app_timer_left), appRestrictions.timerSec, appScreenTimeSec);
                timerDelayMS = leftAppLimitMs;
            }
        }


        /// Check for associated group
        RestrictionGroup associatedGroup = mRestrictionGroups.get(appRestrictions.associatedGroupId);
        if (associatedGroup != null) {

            /// Check for group's active period
            if (associatedGroup.periodDurationInMins > 0) {
                int periodEndTimeMinutes = associatedGroup.activePeriodStart + associatedGroup.periodDurationInMins;

                /// Outside active period
                if (Utils.isTimeOutsideTODs(associatedGroup.activePeriodStart, periodEndTimeMinutes)) {
                    Log.d(TAG, "onNewAppLaunched: App's associated group's active period is over");
                    PurgedReason reason = new PurgedReason(getString(R.string.group_paused_dialog_info_for_active_period_over, associatedGroup.groupName));
                    showOverlayDialog(packageName, reason);
                    return;
                }

                /// Launched between active period so set timer for period ending
                long willOverInMs = Utils.todDifferenceFromNow(periodEndTimeMinutes);
                if (willOverInMs < timerDelayMS) {
                    timerReason = null;
                    timerDelayMS = willOverInMs;
                }
            }


            /// Check for associated group's timer
            if (associatedGroup.timerSec > 0) {
                long groupScreenTimeSec = associatedGroup.distractingApps.stream().mapToLong(app -> allAppsScreenUsage.getOrDefault(app, 0L)).sum();

                /// Group timer ran out
                if (groupScreenTimeSec >= associatedGroup.timerSec) {
                    Log.d(TAG, "onNewAppLaunched: App's associated group's timer is over");
                    PurgedReason reason = new PurgedReason(getString(R.string.app_paused_dialog_info_for_group_timer_out, associatedGroup.groupName), associatedGroup.timerSec, groupScreenTimeSec);
                    mPurgedApps.put(packageName, reason);
                    showOverlayDialog(packageName, reason);
                    return;
                }

                /// Group timer left so update recall delay
                long leftGroupLimitMs = (associatedGroup.timerSec - groupScreenTimeSec) * 1000;
                if (leftGroupLimitMs < timerDelayMS) {
                    timerReason = new PurgedReason(getString(R.string.app_paused_dialog_info_for_group_timer_left, associatedGroup.groupName), associatedGroup.timerSec, groupScreenTimeSec);
                    timerDelayMS = leftGroupLimitMs;
                }
            }
        }


        // Return if delay doesn't changed
        if (timerDelayMS == Long.MAX_VALUE) return;

        // schedule timer for lowest time to recall for usage recheck
        scheduleUsageAlertCountDownTimer(
                packageName,
                timerReason,
                appRestrictions.alertInterval,
                appRestrictions.alertByDialog,
                timerDelayMS
        );
    }

    /**
     * Checks if the app is already purged or restricted and shows the appropriate overlay dialog.
     *
     * @param packageName The package name of the app to check.
     * @return True if the app is purged or restricted, false otherwise.
     */
    private boolean isAppAlreadyPurged(String packageName) {
        PurgedReason reason = mPurgedApps.get(packageName);
        if (reason != null) {
            showOverlayDialog(packageName, reason);
            return true;
        }
        if (mFocusSessionDistractingApps.contains(packageName)) {
            showOverlayDialog(packageName, new PurgedReason(getString(R.string.app_paused_dialog_info_for_focus_session)));
            return true;
        }
        if (mBedtimeDistractingApps.contains(packageName)) {
            showOverlayDialog(packageName, new PurgedReason(getString(R.string.app_paused_dialog_info_for_bedtime)));
            return true;
        }
        return false;
    }

    /**
     * Schedules a countdown timer to alert the user of remaining time for a specific app.
     * Provides notifications or overlay dialogs based on specified alert intervals and thresholds.
     *
     * @param packageName      The package name of the app.
     * @param unfinishedReason The unfinishedReason for which to schedule timer.
     * @param alertIntervalSec The interval at which alerts should occur in SECONDS.
     * @param alertByDialog    True if alerts should be shown as overlay dialogs, otherwise as notifications.
     * @param millisInFuture   The time in Ms in future till the countdown timer will run.
     */
    private void scheduleUsageAlertCountDownTimer(
            String packageName,
            @Nullable PurgedReason unfinishedReason,
            int alertIntervalSec,
            boolean alertByDialog,
            long millisInFuture
    ) {
        cancelTimers();
        final Set<Integer> alertMinuteTicks = getAlertTickFromDuration(millisInFuture, alertIntervalSec);

        // This method is called on a background thread so we have to schedule the timer from the main thread.
        // We can't schedule timer(background task) from another background thread. It will throw exception
        new Handler(Looper.getMainLooper()).post(new Runnable() {
            @Override
            public void run() {
                // Ticks every minute
                CountDownTimer newTimer = new CountDownTimer(millisInFuture, 60 * 1000) {
                    @Override
                    public void onTick(long millisUntilFinished) {
                        int minutesRemaining = (int) (millisUntilFinished / 60000);

                        // Trigger alert if remaining time in minutes matches any alert time
                        if (alertMinuteTicks.contains(minutesRemaining)) {
                            if (unfinishedReason != null && alertByDialog) {
                                showOverlayDialog(packageName, unfinishedReason);
                            } else {
                                pushUsageAlertNotification(packageName, minutesRemaining);
                            }
                            // Remove the triggered alert to avoid re-triggering in subsequent ticks
                            alertMinuteTicks.remove(minutesRemaining);
                        }
                    }

                    @Override
                    public void onFinish() {
                        Log.d(TAG, "scheduleUsageAlertCountDownTimer: Countdown finished for package: " + packageName);
                        onNewAppLaunched(packageName);
                    }
                };
                Log.d(TAG, "scheduleUsageAlertCountDownTimer: Timer scheduled for " + packageName + " ending at: " +
                        new Date(millisInFuture + System.currentTimeMillis()));
                newTimer.start();
                mAtomicOngoingAppTimer.set(newTimer);
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
                            .setContentTitle(getString(R.string.app_pause_notification_title, Utils.minutesToTimeStr(minutesLeft)))
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
     */
    private void showOverlayDialog(String packageName, PurgedReason reason) {
        if (!Utils.isServiceRunning(this, OverlayDialogService.class.getName())) {
            Intent intent = new Intent(getApplicationContext(), OverlayDialogService.class);
            intent.setAction(ACTION_START_MINDFUL_SERVICE);
            intent.putExtra(INTENT_EXTRA_PACKAGE_NAME, packageName);
            intent.putExtra(INTENT_EXTRA_DIALOG_INFO, reason.reasonMsg);
            intent.putExtra(INTENT_EXTRA_MAX_PROGRESS, (int) reason.totalLimit);
            intent.putExtra(INTENT_EXTRA_PROGRESS, (int) reason.usedLimit);
            startService(intent);

            Log.d(TAG, "showOverlayDialog: Starting overlay dialog service for package : " + packageName);
        }
    }

    /**
     * Creates a set of minute ticks based on interval until duration
     *
     * @param timerDurationMS The total duration of the timer in MS
     * @param intervalSec     The interval between each tick in SECONDS
     * @return Set of alert ticks for minutes
     */
    @NonNull
    private Set<Integer> getAlertTickFromDuration(long timerDurationMS, int intervalSec) {
        int timerSeconds = (int) (timerDurationMS / 1000);
        final Set<Integer> alertTicks = new LinkedHashSet<>();
        if (timerSeconds > 300) alertTicks.add(5); // 5-minute alert
        if (timerSeconds > 60) alertTicks.add(1);    // 1-minute alert

        // Add additional alerts based on the interval, in minutes, ensuring no duplicates
        for (int i = intervalSec; i < timerSeconds; i += intervalSec) {
            alertTicks.add(i / 60);
        }

        Log.d(TAG, "getAlertTickFromDuration: Alert tick in minutes: " + alertTicks);
        return alertTicks;
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
        if (mAtomicOngoingAppTimer.get() != null) {
            mAtomicOngoingAppTimer.get().cancel();
            mAtomicOngoingAppTimer.set(null);
            Log.d(TAG, "cancelTimers: Ongoing app timer is cancelled");
        }
    }

    @Override
    public IBinder onBind(Intent intent) {
        String action = Utils.getActionFromIntent(intent);
        return action.equals(ACTION_BIND_TO_MINDFUL) ? mBinder : null;
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        // Dispose and Unregister receiver
        if (mLockUnlockReceiver != null) {
            mLockUnlockReceiver.dispose();
            unregisterReceiver(mLockUnlockReceiver);
        }

        Log.d(TAG, "onDestroy: TRACKER service destroyed successfully");
    }
}
