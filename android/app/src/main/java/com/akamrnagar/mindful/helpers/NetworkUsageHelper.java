package com.akamrnagar.mindful.helpers;

import static com.akamrnagar.mindful.utils.Extensions.getOrDefault;

import android.app.usage.NetworkStats;
import android.app.usage.NetworkStatsManager;
import android.net.ConnectivityManager;
import android.os.RemoteException;
import android.util.Log;

import androidx.annotation.NonNull;

import java.util.HashMap;


/**
 * NetworkUsageHelper is a utility class responsible for gathering network usage statistics for
 * Android applications.
 * It fetches stats about the mobile and Wi-Fi data usage of applications and organizes this
 * information into HashMap of app's uid and the usage in bytes.
 */
public class NetworkUsageHelper {
    private static final String TAG = "Mindful.NetworkUsageHelper";

    /**
     * Fetches Wi-Fi usage statistics for a specified time interval.
     *
     * @param networkStatsManager The NetworkStatsManager used to query network usage.
     * @param start               The start time of the interval in milliseconds.
     * @param end                 The end time of the interval in milliseconds.
     * @return A map with app UIDs as keys and their corresponding Wi-Fi usage in bytes as values.
     */
    @NonNull
    public static HashMap<Integer, Long> fetchWifiUsageForInterval(@NonNull NetworkStatsManager networkStatsManager, long start, long end) {
        HashMap<Integer, Long> wifiUsageMap = new HashMap<>();

        try {
            /// fetch wifi usage
            NetworkStats networkStatsWifi = networkStatsManager.querySummary(ConnectivityManager.TYPE_WIFI, null, start, end);
            NetworkStats.Bucket bucketWifi = new NetworkStats.Bucket();

            do {
                networkStatsWifi.getNextBucket(bucketWifi);
                if (wifiUsageMap.containsKey(bucketWifi.getUid())) {
                    Long previous = getOrDefault(wifiUsageMap, bucketWifi.getUid(), 0L);
                    previous += bucketWifi.getRxBytes();
                    previous += bucketWifi.getTxBytes();
                    wifiUsageMap.put(bucketWifi.getUid(), previous);
                } else {
                    long current = 0;
                    current += bucketWifi.getRxBytes();
                    current += bucketWifi.getTxBytes();
                    wifiUsageMap.put(bucketWifi.getUid(), current);
                }

            } while (networkStatsWifi.hasNextBucket());

            networkStatsWifi.close();

        } catch (RemoteException e) {
            Log.e(TAG, "fetchWifiUsageForInterval: Error in fetching wifi usage for device apps ", e);
        }

        return wifiUsageMap;
    }

    /**
     * Fetches mobile data usage statistics for a specified time interval.
     *
     * @param networkStatsManager The NetworkStatsManager used to query network usage.
     * @param start               The start time of the interval in milliseconds.
     * @param end                 The end time of the interval in milliseconds.
     * @return A map with app UIDs as keys and their corresponding mobile data usage in bytes as values.
     */
    @NonNull
    public static HashMap<Integer, Long> fetchMobileUsageForInterval(@NonNull NetworkStatsManager networkStatsManager, long start, long end) {
        HashMap<Integer, Long> mobileUsageMap = new HashMap<>();

        try {
            /// fetch mobile usage
            NetworkStats networkStatsMobile = networkStatsManager.querySummary(ConnectivityManager.TYPE_MOBILE, null, start, end);
            NetworkStats.Bucket bucketMobile = new NetworkStats.Bucket();

            do {
                networkStatsMobile.getNextBucket(bucketMobile);
                if (mobileUsageMap.containsKey(bucketMobile.getUid())) {
                    Long previous = getOrDefault(mobileUsageMap, bucketMobile.getUid(), 0L);
                    previous += bucketMobile.getRxBytes();
                    previous += bucketMobile.getTxBytes();
                    mobileUsageMap.put(bucketMobile.getUid(), previous);
                } else {
                    long current = 0;
                    current += bucketMobile.getRxBytes();
                    current += bucketMobile.getTxBytes();
                    mobileUsageMap.put(bucketMobile.getUid(), current);
                }

            } while (networkStatsMobile.hasNextBucket());

            networkStatsMobile.close();

        } catch (RemoteException e) {
            Log.e(TAG, "fetchMobileUsageForInterval: Error in fetching mobile usage for device apps ", e);
        }

        return mobileUsageMap;
    }
}
