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
package com.mindful.android.helpers

import android.app.usage.NetworkStats
import android.app.usage.NetworkStatsManager
import android.net.ConnectivityManager
import android.util.Log

/**
 * NetworkUsageHelper is a utility class responsible for gathering network usage statistics for
 * Android applications. It provides methods to fetch network usage data for mobile and Wi-Fi
 * connections over specified time intervals.
 */
object NetworkUsageHelper {
    private const val TAG = "Mindful.NetworkUsageHelper"

    /**
     * Fetches Wi-Fi usage statistics for a specified time interval.
     *
     * @param networkStatsManager The NetworkStatsManager used to query network usage.
     * @param start               The start time of the interval in milliseconds.
     * @param end                 The end time of the interval in milliseconds.
     * @return A map where keys are app UIDs and values are the corresponding Wi-Fi usage in KBs.
     */
    fun fetchWifiUsageForInterval(
        networkStatsManager: NetworkStatsManager,
        start: Long,
        end: Long
    ): HashMap<Int, Long> {
        val wifiUsageMap = HashMap<Int, Long>()

        try {
            // Fetch Wi-Fi usage
            val networkStatsWifi =
                networkStatsManager.querySummary(ConnectivityManager.TYPE_WIFI, null, start, end)
            val bucketWifi = NetworkStats.Bucket()

            do {
                networkStatsWifi.getNextBucket(bucketWifi)
                val uid = bucketWifi.uid
                var usage = wifiUsageMap.getOrDefault(uid, 0L)
                usage += bucketWifi.rxBytes + bucketWifi.txBytes
                wifiUsageMap[uid] = usage
            } while (networkStatsWifi.hasNextBucket())

            networkStatsWifi.close()
        } catch (e: Exception) {
            Log.e(
                TAG,
                "fetchWifiUsageForInterval: Error in fetching Wi-Fi usage for device apps",
                e
            )
        }

        // Convert bytes to KBs and remove entries with no usage
        wifiUsageMap.replaceAll { _, v -> (v / 1024) }
        wifiUsageMap.entries.removeIf { entry -> entry.value == 0L }
        return wifiUsageMap
    }

    /**
     * Fetches mobile data usage statistics for a specified time interval.
     *
     * @param networkStatsManager The NetworkStatsManager used to query network usage.
     * @param start               The start time of the interval in milliseconds.
     * @param end                 The end time of the interval in milliseconds.
     * @return A map where keys are app UIDs and values are the corresponding mobile data usage in KBs.
     */
    fun fetchMobileUsageForInterval(
        networkStatsManager: NetworkStatsManager,
        start: Long,
        end: Long
    ): HashMap<Int, Long> {
        val mobileUsageMap = HashMap<Int, Long>()

        try {
            // Fetch mobile data usage
            val networkStatsMobile =
                networkStatsManager.querySummary(ConnectivityManager.TYPE_MOBILE, null, start, end)
            val bucketMobile = NetworkStats.Bucket()

            do {
                networkStatsMobile.getNextBucket(bucketMobile)
                val uid = bucketMobile.uid
                var usage = mobileUsageMap.getOrDefault(uid, 0L)
                usage += bucketMobile.rxBytes + bucketMobile.txBytes
                mobileUsageMap[uid] = usage
            } while (networkStatsMobile.hasNextBucket())

            networkStatsMobile.close()
        } catch (e: Exception) {
            Log.e(
                TAG,
                "fetchMobileUsageForInterval: Error in fetching mobile usage for device apps",
                e
            )
        }

        // Convert bytes to KBs and remove entries with no usage
        mobileUsageMap.replaceAll { _, v -> (v / 1024) }
        mobileUsageMap.entries.removeIf { entry -> entry.value == 0L }
        return mobileUsageMap
    }
}
