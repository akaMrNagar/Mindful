package com.mindful.android.helpers;

import static com.mindful.android.utils.Extensions.getOrDefault;

import android.app.usage.NetworkStats;
import android.app.usage.NetworkStatsManager;
import android.app.usage.UsageStatsManager;
import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Handler;
import android.os.Looper;

import androidx.annotation.NonNull;

import com.mindful.android.generics.SuccessCallback;
import com.mindful.android.models.AndroidApp;
import com.mindful.android.utils.AsyncThread;
import com.mindful.android.utils.Utils;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

/**
 * DeviceAppsHelper is a utility class that assists in retrieving information about installed
 * applications and their usage on an Android device.
 * It provides functionality for fetching a list of Android apps, including their names, package
 * names, icons, and various usage statistics.
 */
public class DeviceAppsHelper {
    private static final String REMOVED_APP_NAME = "Removed Apps";
    private static final String REMOVED_PACKAGE = "com.android.removed";
    private static final String TETHERING_APP_NAME = "Tethering & Hotspot";
    private static final String TETHERING_PACKAGE = "com.android.tethering";


    /**
     * Retrieves a list of installed Android apps including their usage statistics.
     *
     * @param context       The Android application context.
     * @param channelResult The MethodChannel result to return the list of apps to Flutter.
     */
    public static void getDeviceApps(Context context, MethodChannel.Result channelResult) {
        SuccessCallback<List<Map<String, Object>>> callback = new SuccessCallback<List<Map<String, Object>>>() {
            @Override
            public void onSuccess(List<Map<String, Object>> result) {
                new Handler(Looper.getMainLooper()).post(new Runnable() {
                    @Override
                    public void run() {
                        channelResult.success(result);
                    }
                });
            }
        };

        new AsyncThread().run(
                new Runnable() {
                    @Override
                    public void run() {
                        List<AndroidApp> apps = fetchAppsAndUsage(context);
                        List<Map<String, Object>> resultMap = new ArrayList<>(apps.size());

                        for (AndroidApp app : apps) {
                            resultMap.add(app.toMap());
                        }

                        callback.onSuccess(resultMap);
                    }
                }
        );
    }

    /**
     * Fetches a list of installed Android apps and their usage statistics.
     *
     * @param context The Android application context.
     * @return A list of AndroidApp objects representing installed applications.
     */
    @NonNull
    private static List<AndroidApp> fetchAppsAndUsage(@NonNull Context context) {
        PackageManager packageManager = context.getPackageManager();

        // Fetch set of important apps like Dialer, Launcher etc
        HashSet<String> impSystemApps = ImpSystemAppsHelper.fetchImpApps(context, packageManager);

        // Fetch package info of installed apps on device
        List<PackageInfo> fetchedApps = packageManager.getInstalledPackages(PackageManager.GET_META_DATA);
        List<AndroidApp> deviceApps = new ArrayList<>();


        for (PackageInfo app : fetchedApps) {

            // Only include app which are launchable
            if (packageManager.getLaunchIntentForPackage(app.packageName) != null) {
                int category = -1;

                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                    category = app.applicationInfo.category;
                }

                // Check if the app is important or default to system like dialer and launcher
                boolean isSysDefault = impSystemApps.contains(app.packageName);
                deviceApps.add(
                        new AndroidApp(app.applicationInfo.loadLabel(packageManager).toString(), // name
                                app.packageName, // package name
                                Utils.getEncodedAppIcon(packageManager.getApplicationIcon(app.applicationInfo)), // icon
                                isSysDefault, // is default app used by system like dialer or launcher
                                category, // category
                                app.applicationInfo.uid // app uid
                        )
                );
            }
        }

        /// Add additional apps for network usage
        deviceApps.add(new AndroidApp(TETHERING_APP_NAME, TETHERING_PACKAGE, Utils.getEncodedAppIcon(packageManager.getApplicationIcon(new ApplicationInfo())), true, -1, NetworkStats.Bucket.UID_TETHERING));
        deviceApps.add(new AndroidApp(REMOVED_APP_NAME, REMOVED_PACKAGE, Utils.getEncodedAppIcon(packageManager.getApplicationIcon(new ApplicationInfo())), true, -1, NetworkStats.Bucket.UID_REMOVED));

        UsageStatsManager usageStatsManager = (UsageStatsManager) context.getSystemService(Context.USAGE_STATS_SERVICE);
        NetworkStatsManager networkStatsManager = (NetworkStatsManager) context.getSystemService(Context.NETWORK_STATS_SERVICE);

        Calendar screenUsageCal = Calendar.getInstance();
        screenUsageCal.set(Calendar.HOUR_OF_DAY, 0);
        screenUsageCal.set(Calendar.MINUTE, 0);
        screenUsageCal.set(Calendar.SECOND, 0);
        screenUsageCal.set(Calendar.MILLISECOND, 0);

        // Users may have different timings for their data renewal or reset so keeping it in mind
        int dataResetTimeMins = SharedPrefsHelper.fetchDataResetTimeMins(context);
        Calendar dataUsageCal = Calendar.getInstance();
        dataUsageCal.set(Calendar.HOUR_OF_DAY, dataResetTimeMins / 60);
        dataUsageCal.set(Calendar.MINUTE, dataResetTimeMins % 60);
        dataUsageCal.set(Calendar.SECOND, 0);
        dataUsageCal.set(Calendar.MILLISECOND, 0);

        int todayOfWeek = screenUsageCal.get(Calendar.DAY_OF_WEEK);
        long ms24Hours = 24 * 60 * 60 * 1000; // 24 hours in milliseconds

        /// Loop from first day of week till today of current week
        for (int i = 1; i <= todayOfWeek; i++) {
            screenUsageCal.set(Calendar.DAY_OF_WEEK, i);
            dataUsageCal.set(Calendar.DAY_OF_WEEK, i);

            long screenUsageStart = screenUsageCal.getTimeInMillis();
            long dataUsageStart = dataUsageCal.getTimeInMillis();

            HashMap<String, Long> screenUsageOneDay = ScreenUsageHelper.generateUsageForInterval(usageStatsManager, screenUsageStart, screenUsageStart + ms24Hours);
            HashMap<Integer, Long> mobileUsageOneDay = NetworkUsageHelper.fetchMobileUsageForInterval(networkStatsManager, dataUsageStart, dataUsageStart + ms24Hours);
            HashMap<Integer, Long> wifiUsageOneDay = NetworkUsageHelper.fetchWifiUsageForInterval(networkStatsManager, dataUsageStart, dataUsageStart + ms24Hours);


            for (AndroidApp app : deviceApps) {
                app.screenTimeThisWeek.set((i - 1), getOrDefault(screenUsageOneDay, app.packageName, 0L));

                if (mobileUsageOneDay.containsKey(app.appUid)) {
                    app.mobileUsageThisWeek.set((i - 1), getOrDefault(mobileUsageOneDay, app.appUid, 0L));
                }
                if (wifiUsageOneDay.containsKey(app.appUid)) {
                    app.wifiUsageThisWeek.set((i - 1), getOrDefault(wifiUsageOneDay, app.appUid, 0L));
                }
            }
        }

        return deviceApps;
    }


}
