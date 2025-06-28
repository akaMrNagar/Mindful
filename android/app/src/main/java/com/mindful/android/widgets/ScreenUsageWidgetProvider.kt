package com.mindful.android.widgets

import android.app.PendingIntent
import android.app.usage.UsageStatsManager
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.util.Log
import android.view.View
import android.widget.RemoteViews
import androidx.annotation.MainThread
import com.mindful.android.R
import com.mindful.android.helpers.storage.SharedPrefsHelper
import com.mindful.android.helpers.usages.ScreenUsageHelper
import com.mindful.android.utils.AppUtils
import com.mindful.android.utils.DateTimeUtils
import com.mindful.android.utils.ThreadUtils

class ScreenUsageWidgetProvider : AppWidgetProvider() {
    companion object {
        private const val TAG = "Mindful.ScreenUsageWidgetProvider"
        private const val ACTION_REFRESH_WIDGET = "com.mindful.android.action.refreshScreenUsageWidgetProvider"
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
                        ComponentName(context, ScreenUsageWidgetProvider::class.java)
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
                val packageManager = context.packageManager
                val usageStatsManager =
                    context.applicationContext.getSystemService(Context.USAGE_STATS_SERVICE) as UsageStatsManager

                val excludedApps = SharedPrefsHelper.getSetExcludedApps(context, null)
                val launchableApps = packageManager.queryIntentActivities(
                    Intent(Intent.ACTION_MAIN).addCategory(Intent.CATEGORY_LAUNCHER),
                    0
                ).map { it.activityInfo.packageName }.toSet()

                // Filter
                val usageMap =
                    ScreenUsageHelper.fetchAppUsageTodayTillNow(usageStatsManager).filter {
                        launchableApps.contains(it.key) && !excludedApps.contains(it.key)
                    }

                // Fold
                val totalUsageMinutes = (usageMap.values.sum() / 60) // To minutes
                val topApps = usageMap.entries
                    .sortedByDescending { it.value }
                    .take(3)
                    .map {
                        // Fetch app name
                        val appName = try {
                            val appInfo = packageManager.getApplicationInfo(it.key, 0)
                            packageManager.getApplicationLabel(appInfo).toString()
                        } catch (e: PackageManager.NameNotFoundException) {
                            it.key  // Fallback
                        }

                        // Return
                        appName to (it.value / 60).toInt() // To minutes
                    }


                // Update on main Thread
                ThreadUtils.runOnMainThread {
                    runCatching {
                        updateViews(
                            context = context,
                            appWidgetManager = appWidgetManager,
                            appWidgetIds = appWidgetIds,
                            triggeredBySystem = triggeredBySystem,
                            totalUsageMinutes = totalUsageMinutes.toInt(),
                            topAppsUsage = topApps
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
        totalUsageMinutes: Int,
        topAppsUsage: List<Pair<String, Int>>,
    ) {
        for (appWidgetId in appWidgetIds) {
            RemoteViews(context.packageName, R.layout.widget_screen_usage_layout).let {
                // Total usage
                it.setTextViewText(
                    R.id.total_screen_time,
                    DateTimeUtils.minutesToTimeStr(totalUsageMinutes)
                )

                // List of mapped (rowId, timeViewId, nameViewId)
                val rows = listOf(
                    Triple(R.id.first_app_row, R.id.first_app_screen_time, R.id.first_app_name),
                    Triple(
                        R.id.second_app_row,
                        R.id.second_app_screen_time,
                        R.id.second_app_name
                    ),
                    Triple(R.id.third_app_row, R.id.third_app_screen_time, R.id.third_app_name)
                )

                // Show/Hide list based on widget size
                val widgetOptions = appWidgetManager.getAppWidgetOptions(appWidgetId)
                val widgetHeightDp =
                    widgetOptions.getInt(AppWidgetManager.OPTION_APPWIDGET_MIN_HEIGHT)

                // Height is enough for the list
                if (widgetHeightDp >= 105) {
                    it.setViewVisibility(R.id.top_apps_list, View.VISIBLE)

                    // Update top apps text
                    rows.forEachIndexed { index, (rowId, timeId, nameId) ->
                        if (index < topAppsUsage.size) {
                            val (appName, minutes) = topAppsUsage[index]
                            val time = DateTimeUtils.minutesToTimeStr(minutes).let { s ->
                                s.split(" ").firstOrNull() ?: s
                            }

                            it.setViewVisibility(rowId, View.VISIBLE)
                            it.setTextViewText(nameId, appName)
                            it.setTextViewText(timeId, time)
                        } else {
                            it.setViewVisibility(rowId, View.GONE)
                        }
                    }
                } else {
                    it.setViewVisibility(R.id.top_apps_list, View.GONE)
                }

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
            "updateViews: [System:$triggeredBySystem] Screen usage widget updated successfully"
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
            Intent(context.applicationContext, ScreenUsageWidgetProvider::class.java).setAction(
                ACTION_REFRESH_WIDGET
            ),
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        // Set click listener
        views.setOnClickPendingIntent(R.id.widgetRefreshButton, refreshPendingIntent)
        views.setOnClickPendingIntent(R.id.widgetRoot, launchPendingIntent)
    }
}