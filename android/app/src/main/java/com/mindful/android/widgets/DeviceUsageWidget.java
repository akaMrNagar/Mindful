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

package com.mindful.android.widgets;

import android.app.PendingIntent;
import android.app.usage.NetworkStats;
import android.app.usage.NetworkStatsManager;
import android.app.usage.UsageStatsManager;
import android.appwidget.AppWidgetManager;
import android.appwidget.AppWidgetProvider;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import android.widget.RemoteViews;

import androidx.annotation.NonNull;

import com.mindful.android.MainActivity;
import com.mindful.android.R;
import com.mindful.android.generics.SuccessCallback;
import com.mindful.android.helpers.NetworkUsageHelper;
import com.mindful.android.helpers.ScreenUsageHelper;
import com.mindful.android.helpers.SharedPrefsHelper;
import com.mindful.android.models.AggregatedUsage;
import com.mindful.android.utils.Utils;

import org.jetbrains.annotations.Contract;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;


/**
 * This class represents a widget that displays device usage information on the home screen.
 * It fetches mobile data usage, wifi usage, and screen usage only from launchable apps for the current day.
 * Users can refresh the widget manually or it updates automatically based on a predefined interval.
 * Clicking the widget opens the Mindful app.
 */
public class DeviceUsageWidget extends AppWidgetProvider {
    private static final long WIDGET_MANUAL_REFRESH_INTERVAL = 60 * 1000; // 1 minute
    private static long lastRefreshedTime = 0L;
    private static final String TAG = "Mindful.DeviceUsageWidget";
    private static final String WIDGET_ACTION_REFRESH = "com.mindful.android.ACTION_REFRESH";
    private static final String WIDGET_ACTION_LAUNCH_APP = "com.mindful.android.ACTION_LAUNCH_APP";

    @Override
    public void onReceive(Context context, Intent intent) {
        super.onReceive(context, intent);
        String action = Utils.getActionFromIntent(intent);
        Log.d(TAG, "onReceive: Received event with action: " + action);

        if (WIDGET_ACTION_REFRESH.equals(action)) {
            // Return if interval between last refreshed time is less than the specified interval
            long currentTime = System.currentTimeMillis();
            if ((currentTime - lastRefreshedTime) <= WIDGET_MANUAL_REFRESH_INTERVAL) {
                return;
            }

            lastRefreshedTime = currentTime;
            AppWidgetManager appWidgetManager = AppWidgetManager.getInstance(context);
            ComponentName widgetComponent = new ComponentName(context, DeviceUsageWidget.class);
            int[] appWidgetIds = appWidgetManager.getAppWidgetIds(widgetComponent);
            updateWidgetAsync(context, appWidgetManager, appWidgetIds, false);
        }
    }


    @Override
    public void onUpdate(Context context, AppWidgetManager appWidgetManager, @NonNull int[] appWidgetIds) {
        updateWidgetAsync(context, appWidgetManager, appWidgetIds, true);
    }

    /**
     * Updates the widget with the latest usage data.
     *
     * @param context          The context of the application.
     * @param appWidgetManager The AppWidgetManager instance to update the widget.
     * @param appWidgetIds     The list of widget IDs to update.
     * @param isAutomatic      Indicates if the update is triggered automatically (by system) or manually.
     */
    private void updateWidgetAsync(@NonNull Context context, @NonNull AppWidgetManager appWidgetManager, @NonNull int[] appWidgetIds, boolean isAutomatic) {
        // Async callback to run when usages are fetched successfully
        SuccessCallback<AggregatedUsage> callback = new SuccessCallback<AggregatedUsage>() {
            @Override
            public void onSuccess(@NonNull AggregatedUsage result) {
                // Ensure UI updates run on the main thread
                new Handler(Looper.getMainLooper()).post(() -> {
                    RemoteViews views = new RemoteViews(context.getPackageName(), R.layout.device_usage_widget_layout);
                    views.setTextViewText(R.id.widgetScreenUsage, Utils.formatScreenTime(result.totalScreenUsageMins));
                    views.setTextViewText(R.id.widgetMobileUsage, Utils.formatDataMBs(result.totalMobileUsageMBs));
                    views.setTextViewText(R.id.widgetWifiUsage, Utils.formatDataMBs(result.totalWifiUsageMBs));

                    // Called by system. It may be first time so we need to attach onClick listeners
                    if (isAutomatic) {
                        setUpClickListener(context, views);
                    }

                    for (int appWidgetId : appWidgetIds) {
                        if (isAutomatic) {
                            appWidgetManager.updateAppWidget(appWidgetId, views);
                        } else {
                            appWidgetManager.partiallyUpdateAppWidget(appWidgetId, views);
                        }
                    }

                    Log.d(TAG, "updateWidgetAsync: Usage widget updated successfully");
                });
            }
        };


        // Fetch usages on background thread and use callback to update widget data
        new Thread(new Runnable() {
            @Override
            public void run() {
                AggregatedUsage usage = fetchAggregatedUsage(context);
                callback.onSuccess(usage);
            }
        }).start();
    }

    private void setUpClickListener(Context context, @NonNull RemoteViews views) {
        Intent refreshIntent = new Intent(context, DeviceUsageWidget.class);
        refreshIntent.setAction(WIDGET_ACTION_REFRESH);
        PendingIntent refreshPendingIntent = PendingIntent.getBroadcast(context, 0, refreshIntent, PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_IMMUTABLE);

        Intent launchIntent = new Intent(context, MainActivity.class);
        launchIntent.setAction(WIDGET_ACTION_LAUNCH_APP);
        PendingIntent launchPendingIntent = PendingIntent.getActivity(context, 0, launchIntent, PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_IMMUTABLE);

        views.setOnClickPendingIntent(R.id.widgetRefreshIcon, refreshPendingIntent);
        views.setOnClickPendingIntent(R.id.widgetRoot, launchPendingIntent);
    }


    /**
     * Fetches device usage data for the current day only from launchable apps, including screen usage, mobile data usage, and wifi data usage.
     * Calculates total usage for each category and stores them in AggregatedUsage model and returns it.
     *
     * @param context The context of the application.
     * @return AggregatedUsage model with latest usage.
     */
    @NonNull
    @Contract("_ -> new")
    private AggregatedUsage fetchAggregatedUsage(@NonNull Context context) {
        Calendar screenUsageCal = Calendar.getInstance();
        screenUsageCal.set(Calendar.HOUR_OF_DAY, 0);
        screenUsageCal.set(Calendar.MINUTE, 0);
        screenUsageCal.set(Calendar.SECOND, 0);
        screenUsageCal.set(Calendar.MILLISECOND, 0);

        // Users may have different timings for their data renewal or reset so keeping it in mind
        Calendar dataUsageCal = SharedPrefsHelper.getSetDataResetTimeMins(context, null);

        long screenUsageStart = screenUsageCal.getTimeInMillis();
        long dataUsageStart = dataUsageCal.getTimeInMillis();
        long ms24Hours = 24 * 60 * 60 * 1000; // 24 hours in milliseconds

        UsageStatsManager usageStatsManager = (UsageStatsManager) context.getApplicationContext().getSystemService(Context.USAGE_STATS_SERVICE);
        NetworkStatsManager networkStatsManager = (NetworkStatsManager) context.getApplicationContext().getSystemService(Context.NETWORK_STATS_SERVICE);

        HashMap<String, Long> screenUsageOneDay = ScreenUsageHelper.fetchUsageForInterval(usageStatsManager, screenUsageStart, screenUsageStart + ms24Hours, null);
        HashMap<Integer, Long> mobileUsageOneDay = NetworkUsageHelper.fetchMobileUsageForInterval(networkStatsManager, dataUsageStart, dataUsageStart + ms24Hours);
        HashMap<Integer, Long> wifiUsageOneDay = NetworkUsageHelper.fetchWifiUsageForInterval(networkStatsManager, dataUsageStart, dataUsageStart + ms24Hours);


        // Fetch package info of installed apps on device
        PackageManager packageManager = context.getPackageManager();
        List<PackageInfo> deviceApps = packageManager.getInstalledPackages(PackageManager.GET_META_DATA);


        Long wifiUsageKbs = 0L;
        Long mobileUsageKbs = 0L;
        Long screenTimeSec = 0L;

        for (PackageInfo app : deviceApps) {
            // Only include apps which are launchable
            if (packageManager.getLaunchIntentForPackage(app.packageName) != null) {
                screenTimeSec += screenUsageOneDay.getOrDefault(app.packageName, 0L);
                int appUid = app.applicationInfo.uid;
                mobileUsageKbs += mobileUsageOneDay.getOrDefault(appUid, 0L);
                wifiUsageKbs += wifiUsageOneDay.getOrDefault(appUid, 0L);
            }
        }

        // Also include tethering hotspot and removed app's data usage
        wifiUsageKbs += wifiUsageOneDay.getOrDefault(NetworkStats.Bucket.UID_TETHERING, 0L);
        mobileUsageKbs += mobileUsageOneDay.getOrDefault(NetworkStats.Bucket.UID_TETHERING, 0L);

        wifiUsageKbs += wifiUsageOneDay.getOrDefault(NetworkStats.Bucket.UID_REMOVED, 0L);
        mobileUsageKbs += mobileUsageOneDay.getOrDefault(NetworkStats.Bucket.UID_REMOVED, 0L);

        return new AggregatedUsage(
                Math.toIntExact(screenTimeSec / 60),
                Math.toIntExact(mobileUsageKbs / 1024),
                Math.toIntExact(wifiUsageKbs / 1024)
        );
    }
}