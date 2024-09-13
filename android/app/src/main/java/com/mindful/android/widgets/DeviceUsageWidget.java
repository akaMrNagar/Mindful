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
import android.util.Log;
import android.widget.RemoteViews;

import androidx.annotation.NonNull;

import com.mindful.android.MainActivity;
import com.mindful.android.R;
import com.mindful.android.helpers.NetworkUsageHelper;
import com.mindful.android.helpers.ScreenUsageHelper;
import com.mindful.android.helpers.SharedPrefsHelper;
import com.mindful.android.utils.AppConstants;
import com.mindful.android.utils.Utils;

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
    private static long lastRefreshedTime = 0L;
    private static final String TAG = "Mindful.DeviceUsageWidget";
    private static final String WIDGET_ACTION_REFRESH = "com.mindful.android.ACTION_REFRESH";
    private static final String WIDGET_ACTION_LAUNCH_APP = "com.mindful.android.ACTION_LAUNCH_APP";

    private int totalScreenUsageMins = 0;
    private int totalMobileUsageMBs = 0;
    private int totalWifiUsageMBs = 0;

    @Override

    public void onReceive(Context context, Intent intent) {
        super.onReceive(context, intent);
        Log.d(TAG, "onReceive: Received event with action: " + intent.getAction());
        if (WIDGET_ACTION_REFRESH.equals(intent.getAction())) {
            // Return if interval between last refreshed time is less than the specified interval
            long currentTime = System.currentTimeMillis();
            if ((currentTime - lastRefreshedTime) <= AppConstants.WIDGET_MANUAL_REFRESH_INTERVAL) {
                return;
            }

            lastRefreshedTime = currentTime;
            AppWidgetManager appWidgetManager = AppWidgetManager.getInstance(context);
            ComponentName widgetComponent = new ComponentName(context, DeviceUsageWidget.class);
            int[] appWidgetIds = appWidgetManager.getAppWidgetIds(widgetComponent);
            updateWidget(context, appWidgetManager, appWidgetIds, false);
        }
    }


    @Override
    public void onUpdate(Context context, AppWidgetManager appWidgetManager, @NonNull int[] appWidgetIds) {
        updateWidget(context, appWidgetManager, appWidgetIds, true);
    }

    /**
     * Updates the widget with the latest usage data.
     *
     * @param context          The context of the application.
     * @param appWidgetManager The AppWidgetManager instance to update the widget.
     * @param appWidgetIds     The list of widget IDs to update.
     * @param isAutomatic      Indicates if the update is triggered automatically (by system) or manually.
     */
    private void updateWidget(@NonNull Context context, @NonNull AppWidgetManager appWidgetManager, @NonNull int[] appWidgetIds, boolean isAutomatic) {
        updateUsageData(context);

        RemoteViews views = new RemoteViews(context.getPackageName(), R.layout.device_usage_widget_layout);
        views.setTextViewText(R.id.widgetScreenUsage, Utils.formatScreenTime(totalScreenUsageMins));
        views.setTextViewText(R.id.widgetMobileUsage, Utils.formatDataMBs(totalMobileUsageMBs));
        views.setTextViewText(R.id.widgetWifiUsage, Utils.formatDataMBs(totalWifiUsageMBs));

        // Called by system. It may be first time so we need to attach onClick listeners
        if (isAutomatic) {
            Intent refreshIntent = new Intent(context, DeviceUsageWidget.class);
            refreshIntent.setAction(WIDGET_ACTION_REFRESH);
            PendingIntent refreshPendingIntent = PendingIntent.getBroadcast(context, 0, refreshIntent, PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_IMMUTABLE);

            Intent launchIntent = new Intent(context, MainActivity.class);
            launchIntent.setAction(WIDGET_ACTION_LAUNCH_APP);
            PendingIntent launchPendingIntent = PendingIntent.getActivity(context, 0, launchIntent, PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_IMMUTABLE);

            views.setOnClickPendingIntent(R.id.widgetRefreshIcon, refreshPendingIntent);
            views.setOnClickPendingIntent(R.id.widgetRoot, launchPendingIntent);
        }

        for (int appWidgetId : appWidgetIds) {
            if (isAutomatic) {
                appWidgetManager.updateAppWidget(appWidgetId, views);
            } else {
                appWidgetManager.partiallyUpdateAppWidget(appWidgetId, views);
            }
        }

        Log.d(TAG, "updateManually: Usage widget updated successfully");
    }


    /**
     * Fetches device usage data for the current day only from launchable apps, including screen usage, mobile data usage, and wifi data usage.
     * Calculates total usage for each category and stores them in class variables.
     *
     * @param context The context of the application.
     */
    private void updateUsageData(@NonNull Context context) {
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

        long screenUsageStart = screenUsageCal.getTimeInMillis();
        long dataUsageStart = dataUsageCal.getTimeInMillis();
        long ms24Hours = 24 * 60 * 60 * 1000; // 24 hours in milliseconds

        UsageStatsManager usageStatsManager = (UsageStatsManager) context.getApplicationContext().getSystemService(Context.USAGE_STATS_SERVICE);
        NetworkStatsManager networkStatsManager = (NetworkStatsManager) context.getApplicationContext().getSystemService(Context.NETWORK_STATS_SERVICE);

        HashMap<String, Long> screenUsageOneDay = ScreenUsageHelper.fetchUsageForInterval(usageStatsManager, screenUsageStart, screenUsageStart + ms24Hours);
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

        totalMobileUsageMBs = Math.toIntExact(mobileUsageKbs / 1024);
        totalWifiUsageMBs = Math.toIntExact(wifiUsageKbs / 1024);
        totalScreenUsageMins = Math.toIntExact(screenTimeSec / 60);
    }
}