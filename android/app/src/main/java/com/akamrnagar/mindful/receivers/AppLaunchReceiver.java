package com.akamrnagar.mindful.receivers;

import static com.akamrnagar.mindful.utils.Extensions.getOrDefault;

import android.app.usage.UsageStatsManager;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.util.Log;

import androidx.annotation.NonNull;

import com.akamrnagar.mindful.helpers.ScreenUsageHelper;
import com.akamrnagar.mindful.helpers.ServicesHelper;
import com.akamrnagar.mindful.models.BedtimeSettings;
import com.akamrnagar.mindful.services.OverlayDialogService;
import com.akamrnagar.mindful.utils.AppConstants;
import com.akamrnagar.mindful.utils.Utils;

import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Timer;
import java.util.TimerTask;

public class AppLaunchReceiver extends BroadcastReceiver {
    private final String TAG = "Mindful.AppLaunchReceiver";
    public static final String ACTION_APP_LAUNCHED = "com.akamrnagar.mindful.ACTION_APP_LAUNCHED";
    public static final String INTENT_EXTRA_PACKAGE_NAME = "launchedAppPackageName";
    private final Context mContext;
    private final UsageStatsManager mUsageStatsManager;
    private final SharedPreferences mSharedPrefs;
    private Timer mAppUsageRecheckTimer;
    private HashMap<String, Long> mAppTimers = new HashMap<>();
    private HashSet<String> mPurgedApps = new HashSet<>();
    private HashSet<String> mDistractingApps = new HashSet<>();


    public AppLaunchReceiver(Context context) {
        mContext = context;
        mUsageStatsManager = (UsageStatsManager) mContext.getSystemService(Context.USAGE_STATS_SERVICE);
        mSharedPrefs = mContext.getSharedPreferences(AppConstants.PREFS_SHARED_BOX, Context.MODE_PRIVATE);
    }

    @Override
    public void onReceive(Context context, @NonNull Intent intent) {
        if (intent.getAction() != null && ACTION_APP_LAUNCHED.equals(intent.getAction())) {

            // Get the package name of the launched app
            String packageName = intent.getStringExtra(INTENT_EXTRA_PACKAGE_NAME);
            if (packageName == null || packageName.isEmpty()) return;
            Log.d(TAG, "onReceive: App launch event received with package ** " + packageName + " **");


            // Cancel running task
            cancelTimers();

            if (mDistractingApps.contains(packageName)) {
                // If bedtime mode is ON
                openOverlayDialog(packageName);
            } else if (mAppTimers.containsKey(packageName)) {
                // Else if app has timerF
                handleTimerAppLaunch(packageName);
            }


        }
    }


    private void handleTimerAppLaunch(String packageName) {
        if (mPurgedApps.contains(packageName)) {
            openOverlayDialog(packageName);
            return;
        }


        // fetch usage and check if timer ran out then start overlay dialog service
        long screenTimeSec = ScreenUsageHelper.fetchAppUsageTodayTillNow(mUsageStatsManager, packageName);
        long appTimerSec = getOrDefault(mAppTimers, packageName, 0L);

        if (screenTimeSec >= appTimerSec) {
            mPurgedApps.add(packageName);
            openOverlayDialog(packageName);
            return;
        }

        // schedule timer for rechecking the app if it is still running
        long delayMs = (appTimerSec - screenTimeSec) * 1000;

        mAppUsageRecheckTimer = new Timer();
        mAppUsageRecheckTimer.schedule(new TimerTask() {
            @Override
            public void run() {
                mPurgedApps.add(packageName);
                openOverlayDialog(packageName);
                Log.d(TAG, "handleTimerAppLaunch: Executed timer task for package : " + packageName);
            }
        }, delayMs);

        Log.d(TAG, "handleTimerAppLaunch: Timer task scheduled for " + packageName + " :  " + new Date(delayMs + System.currentTimeMillis()));
    }

    // TODO : Implement app locking feature using biometrics
    private void handleLockedAppLaunch(String packageName) {
        Log.d(TAG, "handleLockedAppLaunch: called with package : " + packageName);
    }

    private void openOverlayDialog(String packageName) {
        if (!ServicesHelper.isServiceRunning(mContext, OverlayDialogService.class.getName())) {
            Intent intent = new Intent(mContext, OverlayDialogService.class);
            intent.putExtra(INTENT_EXTRA_PACKAGE_NAME, packageName);
            mContext.startService(intent);

            Log.d(TAG, "openOverlayDialog: Starting overlay dialog service for package : " + packageName);
        }
    }


    private void cancelTimers() {
        if (mAppUsageRecheckTimer != null) {
            mAppUsageRecheckTimer.purge();
            mAppUsageRecheckTimer.cancel();
            mAppUsageRecheckTimer = null;
            Log.d(TAG, "cancelTimers: Usage recheck timer cancelled");
        }
    }


    /**
     * This method loads map of app timer and bedtime settings from shared preferences.
     * The returned boolean can be used to detect if the service should keep running or stop itself.
     *
     * @return TRUE if service can be stopped else FALSE if service can't be stopped
     */
    public boolean reloadDataAndCheckToStopService() {
        mAppTimers = Utils.jsonStrToStringLongHashMap(mSharedPrefs.getString(AppConstants.PREF_KEY_APP_TIMERS, ""));
        mPurgedApps.clear();
        BedtimeSettings bedtimeSettings = new BedtimeSettings(mSharedPrefs.getString(AppConstants.PREF_KEY_BEDTIME_SETTINGS, ""));

//        return mAppTimers.isEmpty() && !bedtimeSettings.shouldPauseApps && bedtimeSettings.distractingApps.isEmpty();
        return mAppTimers.isEmpty() && bedtimeSettings.distractingApps.isEmpty();
    }

    public void startStopBedtimeMode(HashSet<String> distractingApps, boolean shouldStart) {
        if (shouldStart) {
            mDistractingApps = distractingApps;
        } else {
            mDistractingApps.clear();
        }
    }

    public void dispose() {
        cancelTimers();
    }
}
