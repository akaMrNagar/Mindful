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
package com.mindful.android.widgets

import android.app.PendingIntent
import android.app.usage.NetworkStats
import android.app.usage.NetworkStatsManager
import android.app.usage.UsageStatsManager
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Handler
import android.os.Looper
import android.util.Log
import android.widget.RemoteViews
import com.mindful.android.MainActivity
import com.mindful.android.R
import com.mindful.android.helpers.NetworkUsageHelper
import com.mindful.android.helpers.ScreenUsageHelper
import com.mindful.android.helpers.SharedPrefsHelper
import com.mindful.android.models.AggregatedUsage
import com.mindful.android.utils.AppConstants
import com.mindful.android.utils.ThreadUtils
import com.mindful.android.utils.Utils
import org.jetbrains.annotations.Contract
import java.util.Calendar

/**
 * This class represents a widget that displays device usage information on the home screen.
 * It fetches mobile data usage, wifi usage, and screen usage only from launchable apps for the current day.
 * Users can refresh the widget manually or it updates automatically based on a predefined interval.
 * Clicking the widget opens the Mindful app.
 */
class DeviceUsageWidget : AppWidgetProvider() {
    override fun onReceive(context: Context, intent: Intent) {
        super.onReceive(context, intent)
        val action = Utils.getActionFromIntent(intent)
        Log.d(TAG, "onReceive: Received event with action: $action")

        if (WIDGET_ACTION_REFRESH == action) {
            // Return if interval between last refreshed time is less than the specified interval
            val currentTime = System.currentTimeMillis()
            if ((currentTime - lastRefreshedTime) <= WIDGET_MANUAL_REFRESH_INTERVAL) {
                return
            }

            lastRefreshedTime = currentTime
            val appWidgetManager = AppWidgetManager.getInstance(context)
            val widgetComponent = ComponentName(context, DeviceUsageWidget::class.java)
            val appWidgetIds = appWidgetManager.getAppWidgetIds(widgetComponent)
            updateWidgetAsync(
                context = context,
                appWidgetManager = appWidgetManager,
                appWidgetIds = appWidgetIds,
                isAutomatic = false
            )
        }
    }


    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
    ) {
        updateWidgetAsync(
            context = context,
            appWidgetManager = appWidgetManager,
            appWidgetIds = appWidgetIds,
            isAutomatic = true
        )
    }

    /**
     * Updates the widget with the latest usage data.
     *
     * @param context          The context of the application.
     * @param appWidgetManager The AppWidgetManager instance to update the widget.
     * @param appWidgetIds     The list of widget IDs to update.
     * @param isAutomatic      Indicates if the update is triggered automatically (by system) or manually.
     */
    private fun updateWidgetAsync(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        isAutomatic: Boolean,
    ) {
        // Async callback to run when usages are fetched successfully
        val callback = { result: AggregatedUsage ->
            // Ensure UI updates run on the main thread
            ThreadUtils.runOnMainThread {
                val views = RemoteViews(context.packageName, R.layout.device_usage_widget_layout)
                views.setTextViewText(
                    R.id.widgetScreenUsage,
                    Utils.minutesToTimeStr(result.totalScreenUsageMins)
                )
                views.setTextViewText(
                    R.id.widgetMobileUsage,
                    Utils.formatDataMBs(result.totalMobileUsageMBs)
                )
                views.setTextViewText(
                    R.id.widgetWifiUsage,
                    Utils.formatDataMBs(result.totalWifiUsageMBs)
                )

                // Called by system. It may be first time so we need to attach onClick listeners
                if (isAutomatic) {
                    setUpClickListener(context, views)
                }

                for (appWidgetId in appWidgetIds) {
                    if (isAutomatic) {
                        appWidgetManager.updateAppWidget(appWidgetId, views)
                    } else {
                        appWidgetManager.partiallyUpdateAppWidget(appWidgetId, views)
                    }
                }
                Log.d(TAG, "updateWidgetAsync: Usage widget updated successfully")
            }
        }


        // Fetch usages on background thread and use callback to update widget data
        Thread {
            val usage = fetchAggregatedUsage(context)
            callback.invoke(usage)
        }.start()
    }

    private fun setUpClickListener(context: Context, views: RemoteViews) {
        val refreshIntent = Intent(context.applicationContext, DeviceUsageWidget::class.java)
        refreshIntent.setAction(WIDGET_ACTION_REFRESH)
        val refreshPendingIntent = PendingIntent.getBroadcast(
            context,
            0,
            refreshIntent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        val launchIntent = Intent(context.applicationContext, MainActivity::class.java)
        launchIntent.setAction(WIDGET_ACTION_LAUNCH_APP)
        val launchPendingIntent = PendingIntent.getActivity(
            context.applicationContext,
            0,
            launchIntent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        views.setOnClickPendingIntent(R.id.widgetRefreshButton, refreshPendingIntent)
        views.setOnClickPendingIntent(R.id.widgetRoot, launchPendingIntent)
    }


    /**
     * Fetches device usage data for the current day only from launchable apps, including screen usage, mobile data usage, and wifi data usage.
     * Calculates total usage for each category and stores them in AggregatedUsage model and returns it.
     *
     * @param context The context of the application.
     * @return AggregatedUsage model with latest usage.
     */
    @Contract("_ -> new")
    private fun fetchAggregatedUsage(context: Context): AggregatedUsage {
        val screenUsageCal = Calendar.getInstance()
        screenUsageCal[Calendar.HOUR_OF_DAY] = 0
        screenUsageCal[Calendar.MINUTE] = 0
        screenUsageCal[Calendar.SECOND] = 0
        screenUsageCal[Calendar.MILLISECOND] = 0

        // Users may have different timings for their data renewal or reset so keeping it in mind
        val dataUsageCal = SharedPrefsHelper.getSetDataResetTimeMins(context, null)

        val screenUsageStart = screenUsageCal.timeInMillis
        val dataUsageStart = dataUsageCal.timeInMillis

        val usageStatsManager =
            context.applicationContext.getSystemService(Context.USAGE_STATS_SERVICE) as UsageStatsManager
        val networkStatsManager =
            context.applicationContext.getSystemService(Context.NETWORK_STATS_SERVICE) as NetworkStatsManager

        val screenUsageOneDay = ScreenUsageHelper.fetchUsageForInterval(
            usageStatsManager,
            screenUsageStart,
            System.currentTimeMillis()
        )
        val mobileUsageOneDay = NetworkUsageHelper.fetchMobileUsageForInterval(
            networkStatsManager,
            dataUsageStart,
            dataUsageStart + AppConstants.ONE_DAY_IN_MS
        )
        val wifiUsageOneDay = NetworkUsageHelper.fetchWifiUsageForInterval(
            networkStatsManager,
            dataUsageStart,
            dataUsageStart + AppConstants.ONE_DAY_IN_MS
        )


        // Fetch package info of installed apps on device
        val packageManager = context.packageManager
        val deviceApps = packageManager.getInstalledPackages(PackageManager.GET_META_DATA)


        // Fetch excluded apps
        val excludedApps = SharedPrefsHelper.getSetExcludedApps(context, null)

        var wifiUsageKbs = 0L
        var mobileUsageKbs = 0L
        var screenTimeSec = 0L

        for (app in deviceApps) {
            // Only include apps which are launchable
            if (packageManager.getLaunchIntentForPackage(app.packageName) != null) {
                val appUid = app.applicationInfo.uid
                mobileUsageKbs = mobileUsageKbs + mobileUsageOneDay.getOrDefault(appUid, 0L)
                wifiUsageKbs = wifiUsageKbs + wifiUsageOneDay.getOrDefault(appUid, 0L)


                // skip excluded apps
                if (excludedApps.contains(app.packageName)) continue
                screenTimeSec = screenTimeSec + screenUsageOneDay.getOrDefault(app.packageName, 0L)
            }
        }

        // Also include tethering hotspot and removed app's data usage
        wifiUsageKbs =
            wifiUsageKbs + wifiUsageOneDay.getOrDefault(NetworkStats.Bucket.UID_TETHERING, 0L)
        mobileUsageKbs =
            mobileUsageKbs + mobileUsageOneDay.getOrDefault(NetworkStats.Bucket.UID_TETHERING, 0L)

        wifiUsageKbs =
            wifiUsageKbs + wifiUsageOneDay.getOrDefault(NetworkStats.Bucket.UID_REMOVED, 0L)
        mobileUsageKbs =
            mobileUsageKbs + mobileUsageOneDay.getOrDefault(NetworkStats.Bucket.UID_REMOVED, 0L)

        return AggregatedUsage(
            Math.toIntExact(screenTimeSec / 60),
            Math.toIntExact(mobileUsageKbs / 1024),
            Math.toIntExact(wifiUsageKbs / 1024)
        )
    }

    companion object {
        private const val WIDGET_MANUAL_REFRESH_INTERVAL = (5 * 1000 // 5 seconds
                ).toLong()
        private var lastRefreshedTime = 0L
        private const val TAG = "Mindful.DeviceUsageWidget"
        private const val WIDGET_ACTION_REFRESH = "com.mindful.android.ACTION_REFRESH"
        private const val WIDGET_ACTION_LAUNCH_APP = "com.mindful.android.ACTION_LAUNCH_APP"
    }
}