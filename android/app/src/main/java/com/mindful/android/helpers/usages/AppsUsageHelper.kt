package com.mindful.android.helpers.usages

import android.app.usage.NetworkStats
import android.app.usage.NetworkStatsManager
import android.app.usage.UsageStatsManager
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import com.mindful.android.AppConstants.REMOVED_PACKAGE
import com.mindful.android.AppConstants.TETHERING_PACKAGE
import java.lang.IllegalArgumentException

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
        onSuccess: (MutableList<Map<String, Any>>) -> Unit,
    ) {
        if (startMsEpoch == null || endMsEpoch == null) {
            throw IllegalArgumentException("Either start or end time is null")
        }
        Thread {

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

            val packageManager = context.packageManager

            // Fetch set of all launchable apps
            val launchableApps = packageManager.queryIntentActivities(
                Intent(Intent.ACTION_MAIN).addCategory(Intent.CATEGORY_LAUNCHER),
                0
            ).map { it.activityInfo.packageName }.toSet()

            // Fetch package info of installed apps on device
            val installedApps =
                packageManager.getInstalledApplications(PackageManager.GET_META_DATA)

            val appsUsageMapList: MutableList<Map<String, Any>> = installedApps
                .filter { launchableApps.contains(it.packageName) }
                .mapNotNull { appInfo ->
                    val packageName = appInfo.packageName
                    val uid = appInfo.uid
                    val screenTime = screenUsage.getOrDefault(packageName, 0L)
                    val mobileData = mobileDataUsage.getOrDefault(uid, 0L)
                    val wifiData = wifiDataUsage.getOrDefault(uid, 0L)

                    // Skip if app does not have any usage
                    if (screenTime <= 0L && mobileData <= 0L && wifiData <= 0L) {
                        null
                    } else {
                        getAppInfoMap(
                            packageName = packageName,
                            screenTime = screenTime,
                            mobileData = mobileData,
                            wifiData = wifiData,
                        )
                    }
                }.toMutableList()


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


    /// Keys for the map
    const val KEY_PACKAGE_NAME = "packageName"
    const val KEY_SCREEN_TIME = "screenTime"
    const val KEY_MOBILE_DATA = "mobileData"
    const val KEY_WIFI_DATA = "wifiData"

    private fun getAppInfoMap(
        packageName: String,
        screenTime: Long,
        mobileData: Long,
        wifiData: Long,
    ): Map<String, Any> = mapOf(
        KEY_PACKAGE_NAME to packageName,
        KEY_SCREEN_TIME to screenTime,
        KEY_MOBILE_DATA to mobileData,
        KEY_WIFI_DATA to wifiData,
    );

}