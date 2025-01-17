package com.mindful.android.helpers

import android.app.usage.NetworkStats
import android.app.usage.NetworkStatsManager
import android.app.usage.UsageStatsManager
import android.content.Context
import android.content.pm.PackageManager
import android.util.Log
import com.mindful.android.utils.AppConstants.REMOVED_PACKAGE
import com.mindful.android.utils.AppConstants.TETHERING_PACKAGE
import java.lang.IllegalArgumentException
import java.util.Date

object AppsUsageHelper {
    /**
     * Retrieves a Map of app packages along with their usage statistics.
     *
     * @param context       The context to use for fetching app information.
     * @param startMsEpoch The start time of the interval in MS.
     * @param endMsEpoch The end time of the interval in MS.
     * @param onSuccess Callback which will be invoke after fetching usages.
     */
    fun getAppsUsageForInterval(
        context: Context,
        startMsEpoch: Long?,
        endMsEpoch: Long?,
        onSuccess: (Any) -> Unit,
    ) {
        if (startMsEpoch == null || endMsEpoch == null) {
            throw IllegalArgumentException("Either start or end time is null")
        }
        Thread {
            val appsUsageMapList: MutableList<Map<String, Any>> = ArrayList()

            // Fetch usages for the date
            val usageStatsManager =
                context.getSystemService(Context.USAGE_STATS_SERVICE) as UsageStatsManager

            val networkStatsManager =
                context.getSystemService(Context.NETWORK_STATS_SERVICE) as NetworkStatsManager

            val screenUsage = ScreenUsageHelper.fetchUsageForInterval(
                usageStatsManager = usageStatsManager,
                start = startMsEpoch,
                end = endMsEpoch
            )

            val mobileDataUsage = NetworkUsageHelper.fetchMobileUsageForInterval(
                networkStatsManager = networkStatsManager,
                start = startMsEpoch,
                end = endMsEpoch
            )
            val wifiDataUsage = NetworkUsageHelper.fetchWifiUsageForInterval(
                networkStatsManager = networkStatsManager,
                start = startMsEpoch,
                end = endMsEpoch
            )

            // Fetch package info of installed apps on device
            val packageManager = context.packageManager
            val installedApps =
                packageManager.getInstalledPackages(PackageManager.GET_META_DATA)

            for (appInfo in installedApps) {
                val packageName = appInfo.packageName


                // Skip if app is not launchable
                if (packageManager.getLaunchIntentForPackage(packageName) == null)
                    continue


                val uid = appInfo.applicationInfo.uid
                val screenTime = screenUsage.getOrDefault(packageName, 0L)
                val mobileData = mobileDataUsage.getOrDefault(uid, 0L)
                val wifiData = wifiDataUsage.getOrDefault(uid, 0L)

                // Skip if app does not have any usage
                if (screenTime <= 0L && mobileData <= 0L && wifiData <= 0L)
                    continue

                appsUsageMapList.add(
                    getAppInfoMap(
                        packageName = packageName,
                        screenTime = screenTime,
                        mobileData = mobileData,
                        wifiData = wifiData,
                    )
                )
            }


            // Add additional apps for network usage
            // Tethering and  Hotspot
            appsUsageMapList.add(
                getAppInfoMap(
                    packageName = TETHERING_PACKAGE,
                    screenTime = 0L,
                    mobileData = mobileDataUsage.getOrDefault(
                        NetworkStats.Bucket.UID_TETHERING,
                        0L
                    ),
                    wifiData = wifiDataUsage.getOrDefault(
                        NetworkStats.Bucket.UID_TETHERING,
                        0L
                    ),
                )
            )

            // removed apps
            appsUsageMapList.add(
                getAppInfoMap(
                    packageName = REMOVED_PACKAGE,
                    screenTime = 0L,
                    mobileData = mobileDataUsage.getOrDefault(
                        NetworkStats.Bucket.UID_REMOVED,
                        0L
                    ),
                    wifiData = wifiDataUsage.getOrDefault(
                        NetworkStats.Bucket.UID_TETHERING,
                        0L
                    ),
                )
            )

            onSuccess(appsUsageMapList)
        }.start()
    }


    private fun getAppInfoMap(
        packageName: String,
        screenTime: Long,
        mobileData: Long,
        wifiData: Long,
    ): Map<String, Any> {
        return mapOf(
            "packageName" to packageName,
            "screenTime" to screenTime,
            "mobileData" to mobileData,
            "wifiData" to wifiData,
        );
    }
}