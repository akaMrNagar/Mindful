package com.akamrnagar.mindful.helpers;

import android.app.usage.NetworkStats;
import android.app.usage.UsageStatsManager;
import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Handler;
import android.os.Looper;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;

import com.akamrnagar.mindful.interfaces.AsyncSuccessCallback;
import com.akamrnagar.mindful.models.AndroidApp;
import com.akamrnagar.mindful.utils.AppConstants;
import com.akamrnagar.mindful.utils.Utils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class DeviceAppsHelper {


    @RequiresApi(api = Build.VERSION_CODES.M)
    public static void getDeviceApps(Context context, MethodChannel.Result channelResult) {
        AsyncSuccessCallback<List<Map<String, Object>>> callback = new AsyncSuccessCallback<List<Map<String, Object>>>() {
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
//                        Log.e(AppConstants.LOG_TAG, "number of apps: " + apps.size());

                        for (AndroidApp app : apps) {
                            resultMap.add(app.toMap());
//                            Log.e(AppConstants.LOG_TAG, app.toString());
                        }

                        callback.onSuccess(resultMap);
                    }
                }
        );
    }

    @NonNull
    @RequiresApi(api = Build.VERSION_CODES.M)
    private static List<AndroidApp> fetchAppsAndUsage(@NonNull Context context) {
        PackageManager packageManager = context.getPackageManager();
        ImpSystemAppsHelper.init(context, packageManager);

        List<PackageInfo> fetchedApps = packageManager.getInstalledPackages(PackageManager.GET_META_DATA);
        List<AndroidApp> deviceApps = new ArrayList<>();

        /// Create list of android apps
        for (PackageInfo app : fetchedApps) {
            if (packageManager.getLaunchIntentForPackage(app.packageName) != null) {
                int category = -1;

                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                    category = app.applicationInfo.category;
                }

                boolean isSysDefault = ImpSystemAppsHelper.impSystemApps.contains(app.packageName);

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
        deviceApps.add(new AndroidApp("Tethering & Hotspot", AppConstants.TETHERING_PACKAGE, Utils.getEncodedAppIcon(packageManager.getApplicationIcon(new ApplicationInfo())), true, -1, NetworkStats.Bucket.UID_TETHERING));
        deviceApps.add(new AndroidApp("Removed Apps", AppConstants.REMOVED_PACKAGE, Utils.getEncodedAppIcon(packageManager.getApplicationIcon(new ApplicationInfo())), true, -1, NetworkStats.Bucket.UID_REMOVED));

        UsageStatsManager usageStatsManager = (UsageStatsManager) context.getSystemService(Context.USAGE_STATS_SERVICE);
        /// fetch screen usage
        deviceApps = ScreenUsageHelper.generateScreenUsageForThisWeek(deviceApps, usageStatsManager);

        /// fetch network usage = mobile+wifi
        deviceApps = NetworkUsageHelper.generateNetworkUsage(deviceApps, packageManager, context);

        return deviceApps;
    }


}
