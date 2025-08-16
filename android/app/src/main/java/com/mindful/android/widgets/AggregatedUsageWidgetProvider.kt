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
import android.net.ConnectivityManager
import android.util.Log
import android.widget.RemoteViews
import androidx.annotation.MainThread
import com.mindful.android.R
import com.mindful.android.helpers.storage.SharedPrefsHelper
import com.mindful.android.helpers.usages.NetworkUsageHelper
import com.mindful.android.helpers.usages.ScreenUsageHelper
import com.mindful.android.utils.AppUtils
import com.mindful.android.utils.DateTimeUtils
import com.mindful.android.utils.ThreadUtils
import com.mindful.android.utils.Utils

class AggregatedUsageWidgetProvider : AppWidgetProvider() {
    companion object {
        private const val TAG = "Mindful.AggregatedUsageWidgetProvider"
        private const val ACTION_REFRESH_WIDGET =
            "com.mindful.android.action.refreshAggregatedUsageWidgetProvider"
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
            triggeredBySystem = true
        )
    }

    override fun onReceive(context: Context, intent: Intent?) {
        intent?.action?.let { action ->

            when (action) {
                "android.appwidget.action.APPWIDGET_UPDATE_OPTIONS",
                ACTION_REFRESH_WIDGET,
                    -> {
                    val appWidgetManager = AppWidgetManager.getInstance(context)
                    val widgetComponent =
                        ComponentName(context, AggregatedUsageWidgetProvider::class.java)
                    val appWidgetIds = appWidgetManager.getAppWidgetIds(widgetComponent)
                    updateWidgetAsync(
                        context = context,
                        appWidgetManager = appWidgetManager,
                        appWidgetIds = appWidgetIds,
                        triggeredBySystem = false
                    )
                }

                else -> Log.d(TAG, "Received unhandled action: $action")
            }
        }

        super.onReceive(context, intent)
    }


    /**
     * Updates the widget with the latest usage data.
     *
     * @param context          The context of the application.
     * @param appWidgetManager The AppWidgetManager instance to update the widget.
     * @param appWidgetIds     The list of widget IDs to update.
     * @param triggeredBySystem      Indicates if the update is triggered automatically (by system) or manually.
     */
    private fun updateWidgetAsync(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        triggeredBySystem: Boolean,
    ) {
        runCatching {
            Thread {
                val usageStatsManager =
                    context.applicationContext.getSystemService(Context.USAGE_STATS_SERVICE) as UsageStatsManager
                val networkStatsManager =
                    context.applicationContext.getSystemService(Context.NETWORK_STATS_SERVICE) as NetworkStatsManager

                // Fetch usages
                val screenUsageOneDay =
                    ScreenUsageHelper.fetchAppUsageTodayTillNow(usageStatsManager)
                val mobileUsageOneDay =
                    NetworkUsageHelper.fetchNetworkUsageForTodayTillNow(
                        networkStatsManager,
                        ConnectivityManager.TYPE_MOBILE
                    )
                val wifiUsageOneDay = NetworkUsageHelper.fetchNetworkUsageForTodayTillNow(
                    networkStatsManager,
                    ConnectivityManager.TYPE_WIFI
                )


                // Fetch package info of installed apps on device
                val packageManager = context.packageManager
                val excludedApps = SharedPrefsHelper.getSetExcludedApps(context, null)


                var wifiUsageKbs = 0L
                var mobileUsageKbs = 0L
                var screenTimeSec = 0L

                // Fetch set of all launchable apps
                val launchableApps = packageManager.queryIntentActivities(
                    Intent(Intent.ACTION_MAIN).addCategory(Intent.CATEGORY_LAUNCHER),
                    0
                ).forEach { appInfo ->
                    val appUid = appInfo.activityInfo.applicationInfo?.uid
                    mobileUsageKbs += mobileUsageOneDay.getOrDefault(appUid, 0L)
                    wifiUsageKbs += wifiUsageOneDay.getOrDefault(appUid, 0L)

                    // skip excluded apps
                    val packageName = appInfo.activityInfo.packageName
                    if (!excludedApps.contains(packageName)) {
                        screenTimeSec += screenUsageOneDay.getOrDefault(packageName, 0L)
                    }
                }


                // Also include tethering hotspot and removed app's data usage
                wifiUsageKbs += wifiUsageOneDay.getOrDefault(
                    NetworkStats.Bucket.UID_TETHERING,
                    0L
                )
                mobileUsageKbs += mobileUsageOneDay.getOrDefault(
                    NetworkStats.Bucket.UID_TETHERING,
                    0L
                )

                wifiUsageKbs += wifiUsageOneDay.getOrDefault(NetworkStats.Bucket.UID_REMOVED, 0L)
                mobileUsageKbs += mobileUsageOneDay.getOrDefault(
                    NetworkStats.Bucket.UID_REMOVED,
                    0L
                )


                // Update on main Thread
                ThreadUtils.runOnMainThread {
                    runCatching {
                        updateViews(
                            context = context,
                            appWidgetManager = appWidgetManager,
                            appWidgetIds = appWidgetIds,
                            triggeredBySystem = triggeredBySystem,
                            totalScreenTimeMinute = screenTimeSec / 60,
                            totalMobileDataMb = mobileUsageKbs / 1024,
                            totalWifiDataMb = wifiUsageKbs / 1024
                        )
                    }.getOrElse { SharedPrefsHelper.insertCrashLogToPrefs(context, it) }
                }
            }.start()
        }
    }

    @MainThread
    private fun updateViews(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        triggeredBySystem: Boolean,
        totalScreenTimeMinute: Long,
        totalMobileDataMb: Long,
        totalWifiDataMb: Long,
    ) {
        for (appWidgetId in appWidgetIds) {
            RemoteViews(context.packageName, R.layout.widget_aggregated_usage_layout).let {
                // Screen usage
                it.setTextViewText(
                    R.id.total_screen_time,
                    DateTimeUtils.minutesToTimeStr(totalScreenTimeMinute.toInt())
                )

                // Mobile data usage
                it.setTextViewText(
                    R.id.total_mobile_data,
                    Utils.formatDataMBs(totalMobileDataMb.toInt()),
                )

                // Wifi data usage
                it.setTextViewText(
                    R.id.total_wifi_data,
                    Utils.formatDataMBs(totalWifiDataMb.toInt()),
                )

                // Called by system. It may be first time so we need to attach onClick listeners
                if (triggeredBySystem) {
                    setUpClickListener(context, it)
                    appWidgetManager.updateAppWidget(appWidgetId, it)
                } else {
                    appWidgetManager.partiallyUpdateAppWidget(appWidgetId, it)
                }
            }
        }
        Log.d(
            TAG,
            "updateViews: [System:$triggeredBySystem] Aggregated usage widget updated successfully"
        )
    }

    private fun setUpClickListener(context: Context, views: RemoteViews) {
        val launchPendingIntent = AppUtils.getPendingIntentForMindfulUri(
            context,
            "com.mindful.android://open/home?tab=1"
        )
        val refreshPendingIntent = PendingIntent.getBroadcast(
            context,
            0,
            Intent(context.applicationContext, AggregatedUsageWidgetProvider::class.java).setAction(
                ACTION_REFRESH_WIDGET
            ),
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        // Set click listener
        views.setOnClickPendingIntent(R.id.widgetRefreshButton, refreshPendingIntent)
        views.setOnClickPendingIntent(R.id.widgetRoot, launchPendingIntent)
    }
}