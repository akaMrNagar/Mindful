/*
 *
 *  * Copyright (c) 2024 Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

package com.mindful.android.helpers;

import android.app.usage.NetworkStats;
import android.app.usage.NetworkStatsManager;
import android.net.ConnectivityManager;
import android.os.RemoteException;
import android.util.Log;

import androidx.annotation.NonNull;

import java.util.HashMap;

/**
 * NetworkUsageHelper is a utility class responsible for gathering network usage statistics for
 * Android applications. It provides methods to fetch network usage data for mobile and Wi-Fi
 * connections over specified time intervals.
 */
public class NetworkUsageHelper {
    private static final String TAG = "Mindful.NetworkUsageHelper";

    /**
     * Fetches Wi-Fi usage statistics for a specified time interval.
     *
     * @param networkStatsManager The NetworkStatsManager used to query network usage.
     * @param start               The start time of the interval in milliseconds.
     * @param end                 The end time of the interval in milliseconds.
     * @return A map where keys are app UIDs and values are the corresponding Wi-Fi usage in KBs.
     */
    @NonNull
    public static HashMap<Integer, Long> fetchWifiUsageForInterval(@NonNull NetworkStatsManager networkStatsManager, long start, long end) {
        HashMap<Integer, Long> wifiUsageMap = new HashMap<>();

        try {
            // Fetch Wi-Fi usage
            NetworkStats networkStatsWifi = networkStatsManager.querySummary(ConnectivityManager.TYPE_WIFI, null, start, end);
            NetworkStats.Bucket bucketWifi = new NetworkStats.Bucket();

            do {
                networkStatsWifi.getNextBucket(bucketWifi);
                int uid = bucketWifi.getUid();
                Long usage = wifiUsageMap.getOrDefault(uid, 0L);
                usage += bucketWifi.getRxBytes() + bucketWifi.getTxBytes();
                wifiUsageMap.put(uid, usage);
            } while (networkStatsWifi.hasNextBucket());

            networkStatsWifi.close();

        } catch (RemoteException e) {
            Log.e(TAG, "fetchWifiUsageForInterval: Error in fetching Wi-Fi usage for device apps", e);
        }

        // Convert bytes to KBs
        wifiUsageMap.replaceAll((k, v) -> (v / 1024));
        return wifiUsageMap;
    }

    /**
     * Fetches mobile data usage statistics for a specified time interval.
     *
     * @param networkStatsManager The NetworkStatsManager used to query network usage.
     * @param start               The start time of the interval in milliseconds.
     * @param end                 The end time of the interval in milliseconds.
     * @return A map where keys are app UIDs and values are the corresponding mobile data usage in KBs.
     */
    @NonNull
    public static HashMap<Integer, Long> fetchMobileUsageForInterval(@NonNull NetworkStatsManager networkStatsManager, long start, long end) {
        HashMap<Integer, Long> mobileUsageMap = new HashMap<>();

        try {
            // Fetch mobile data usage
            NetworkStats networkStatsMobile = networkStatsManager.querySummary(ConnectivityManager.TYPE_MOBILE, null, start, end);
            NetworkStats.Bucket bucketMobile = new NetworkStats.Bucket();

            do {
                networkStatsMobile.getNextBucket(bucketMobile);
                int uid = bucketMobile.getUid();
                Long usage = mobileUsageMap.getOrDefault(uid, 0L);
                usage += bucketMobile.getRxBytes() + bucketMobile.getTxBytes();
                mobileUsageMap.put(uid, usage);
            } while (networkStatsMobile.hasNextBucket());

            networkStatsMobile.close();

        } catch (RemoteException e) {
            Log.e(TAG, "fetchMobileUsageForInterval: Error in fetching mobile usage for device apps", e);
        }

        // Convert bytes to KBs
        mobileUsageMap.replaceAll((k, v) -> (v / 1024));
        return mobileUsageMap;
    }
}
