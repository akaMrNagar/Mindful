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
package com.mindful.android.helpers.usages

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
        end: Long,
    ): Map<Int, Long> =
        fetchNetworkUsageForInterval(networkStatsManager, ConnectivityManager.TYPE_WIFI, start, end)

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
        end: Long,
    ): Map<Int, Long> =
        fetchNetworkUsageForInterval(
            networkStatsManager,
            ConnectivityManager.TYPE_MOBILE,
            start,
            end
        )

    /**
     * Fetches network usage statistics for a specified network type over a given time interval.
     *
     * @param networkStatsManager The NetworkStatsManager used to query network usage.
     * @param networkType The type of network (e.g., ConnectivityManager.TYPE_WIFI or TYPE_MOBILE).
     * @param start The start time of the interval in milliseconds.
     * @param end The end time of the interval in milliseconds.
     * @return A map where keys are app UIDs and values are the corresponding data usage in KBs.
     */
    private fun fetchNetworkUsageForInterval(
        networkStatsManager: NetworkStatsManager,
        networkType: Int,
        start: Long,
        end: Long,
    ): Map<Int, Long> {
        val usageMap = mutableMapOf<Int, Long>()
        val networkStats = networkStatsManager.querySummary(networkType, null, start, end)

        try {
            val bucket = NetworkStats.Bucket()

            while (networkStats.hasNextBucket()) {
                networkStats.getNextBucket(bucket)
                val uid = bucket.uid
                usageMap[uid] = usageMap.getOrDefault(uid, 0L) + (bucket.rxBytes + bucket.txBytes)
            }

        } catch (e: Exception) {
            Log.e(
                TAG,
                "fetchNetworkUsageForInterval: Error fetching network usage for type $networkType",
                e
            )
        } finally {
            networkStats.close()
        }

        return usageMap
            .mapValues { it.value / 1024 }  // Convert bytes to KBs
            .filterValues { it > 0L }       // Remove entries with no usage
    }


}
