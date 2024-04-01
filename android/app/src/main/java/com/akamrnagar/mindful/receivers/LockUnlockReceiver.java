package com.akamrnagar.mindful.receivers;

import static com.akamrnagar.mindful.utils.Extensions.getOrDefault;

import android.app.usage.UsageStatsManager;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import androidx.annotation.NonNull;

import com.akamrnagar.mindful.helpers.NotificationHelper;
import com.akamrnagar.mindful.helpers.ScreenUsageHelper;
import com.akamrnagar.mindful.helpers.ServicesHelper;
import com.akamrnagar.mindful.utils.AppConstants;

import java.util.Calendar;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Objects;
import java.util.Timer;
import java.util.TimerTask;

public class LockUnlockReceiver extends BroadcastReceiver {

    private final Context mContext;
    private final UsageStatsManager usageStatsManager;
    private Timer launchTrackerTimer = new Timer();
    private Timer usageTrackerTimer = new Timer();
    private long todayMidnightTimeMs;

    /**
     * Map of app package and their timer in seconds set by the user
     */
    private HashMap<String, Long> appsTimerMap = new HashMap<>(1);


    /**
     * List of app packages whose timer ran out or whose screen time exceeded the daily limit
     */
    private HashSet<String> purgedApps = new HashSet<>(1);

    private boolean mIsTrackingOn = false;
    private boolean mIsLockdown = false;
    int counter = 0;


    public LockUnlockReceiver(@NonNull Context context) {
        this.mContext = context;
        usageStatsManager = (UsageStatsManager) context.getSystemService(Context.USAGE_STATS_SERVICE);
//        refreshAppTimers();
    }


    @Override
    public void onReceive(Context context, @NonNull Intent intent) {
        if (Objects.equals(intent.getAction(), Intent.ACTION_USER_PRESENT)) {
            Log.d(AppConstants.DEBUG_TAG, "User unlocked the device");
            onDeviceUnlocked();
        } else if (Objects.equals(intent.getAction(), Intent.ACTION_SCREEN_OFF)) {
            Log.d(AppConstants.DEBUG_TAG, "User locked the device and screen is off");
            onDeviceLocked();
        }
    }

    public void refreshAppTimers(HashMap<String, Long> map) {
//        appsTimerMap = new LocalStorageHelper(mContext).loadAppTimers();
        appsTimerMap = map;
        if (appsTimerMap.isEmpty()) ServicesHelper.stopTrackingService(mContext);


        // Clear purged list only if not in lockdown mode
        if (!mIsLockdown) purgedApps.clear();

        if (!mIsTrackingOn) onDeviceUnlocked();
        else usageTrackerTimerTask();

        Log.d(AppConstants.DEBUG_TAG, "refreshAppTimers: " + appsTimerMap.toString());
    }

    public void updateBedtimeLockdownState(boolean isOn) {
        mIsLockdown = isOn;
        if (isOn) {
            purgedApps.addAll(appsTimerMap.keySet());
        } else {
            // Refresh purged apps list by fetching fresh app usage stats
            purgedApps.clear();
            usageTrackerTimerTask();
        }
        Log.d(AppConstants.DEBUG_TAG, "LockUnlockReceiver.onBedtimeStateChange(): called in service with state : " + isOn);
    }

    public void midnightReset() {
        // If not in lockdown mode, refresh purged apps list by fetching fresh app usage stats
        if (!mIsLockdown) {
            purgedApps.clear();
            usageTrackerTimerTask();
        }
    }


    /**
     * This method is called everytime the device is unlocked
     */
    private void onDeviceUnlocked() {
//        if (appsTimerMap.isEmpty()) return;

        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        todayMidnightTimeMs = cal.getTimeInMillis();

        launchTrackerTimer = new Timer();
        usageTrackerTimer = new Timer();

        launchTrackerTimer.scheduleAtFixedRate(new TimerTask() {
            @Override
            public void run() {
                launchTrackerTimerTask();
            }
        }, 0, 1000);

        usageTrackerTimer.scheduleAtFixedRate(new TimerTask() {
            ///TODO: Change the period of timer to 1 minute instead of 5 seconds before release build
            @Override
            public void run() {
                usageTrackerTimerTask();
            }
        }, 0, 5 * 1000);

        mIsTrackingOn = true;
    }


    /**
     * This method is called everytime the device is locked or screen is turned off
     */
    private void onDeviceLocked() {
        // release resources held by service
        if (usageTrackerTimer != null) {
            usageTrackerTimer.purge();
            usageTrackerTimer.cancel();
            usageTrackerTimer = null;
        }

        if (launchTrackerTimer != null) {
            launchTrackerTimer.purge();
            launchTrackerTimer.cancel();
            launchTrackerTimer = null;
        }

        mIsTrackingOn = false;
    }

    /**
     * Manually created dispose() method to release resources because no override found in BroadcastReceiver class
     */
    public void dispose() {
        onDeviceLocked();
    }

    /**
     * This method will be called every minute and it is responsible for adding apps to purged list,
     * when their screen time exceeds the daily timer. It also takes care if the app is running now.
     */
    private void usageTrackerTimerTask() {
        if (appsTimerMap.isEmpty() || mIsLockdown) return;
        Log.d(AppConstants.DEBUG_TAG, "...................................................... refreshing purged apps list");

        /// Map of package and their screen time in seconds
        Map<String, Long> usageTodayTillNow = ScreenUsageHelper.generateUsageTodayTillNow(usageStatsManager, todayMidnightTimeMs, appsTimerMap.keySet());


        for (Map.Entry<String, Long> entry : usageTodayTillNow.entrySet()) {
            long limit = getOrDefault(appsTimerMap, entry.getKey(), 0L);
            long usedTime = entry.getValue();

            if (usedTime > limit) {
                /// screen time exceeded the limit so it needs to be purged
                if (!purgedApps.contains(entry.getKey())) {
                    Log.d(AppConstants.DEBUG_TAG, "App exceeded the time limit: " + entry.getKey());
                    purgedApps.add(entry.getKey());
                    if (Objects.equals(ScreenUsageHelper.getLastActiveApp(usageStatsManager, 3 * 60 * 60), entry.getKey())) {
                        openTLEDialog(entry.getKey());
                    }
                }
            }

        }
    }


    /**
     * This method is called every second to track if the user launched a app.
     * If the purged list contains that app then the user is forwarded to home screen and TLE dialog is displayed.
     */
    private void launchTrackerTimerTask() {
        if (purgedApps.isEmpty()) return;
        Log.d(AppConstants.DEBUG_TAG, "iteration: " + (counter++));

        String currentlyActiveApp = ScreenUsageHelper.getLastActiveApp(usageStatsManager, 1);
        if (purgedApps.contains(currentlyActiveApp)) {
            Log.d(AppConstants.DEBUG_TAG, "...........................Purged app " + currentlyActiveApp + " is opened ............................................");
            openTLEDialog(currentlyActiveApp);
        }
    }

    /**
     * Responsible for starting overlay dialog service which display a dialog for motivation and information, if it is already not running.
     *
     * @param appPackage The package of the app whose timer ran out or Time Limit Exceeded
     */
    private void openTLEDialog(String appPackage) {

        Log.d(AppConstants.DEBUG_TAG, "Overlay Dialog Service called  for app:  " + appPackage);

        new Handler(Looper.getMainLooper()).post(new Runnable() {
            @Override
            public void run() {
                Intent intent = new Intent(Intent.ACTION_MAIN);
                intent.addCategory(Intent.CATEGORY_HOME);
                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                mContext.startActivity(intent);
            }
        });

//        PackageManager packageManager = mContext.getPackageManager();
//        ApplicationInfo info = packageManager.getApplicationInfo(appPackage, PackageManager.GET_META_DATA);
//
//        String appName = info.loadLabel(packageManager).toString();
//        Drawable icon = packageManager.getApplicationIcon(info);

        NotificationHelper.sendPushNotification(mContext, "Timer ran out!!", "Embrace this pause to supercharge your productivity. Stay focused, stay motivated.");
    }

}
