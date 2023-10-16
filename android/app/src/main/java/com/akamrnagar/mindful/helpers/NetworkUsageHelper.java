package com.akamrnagar.mindful.helpers;

import android.app.usage.NetworkStats;
import android.app.usage.NetworkStatsManager;
import android.content.Context;
import android.content.pm.PackageManager;
import android.net.ConnectivityManager;
import android.os.Build;
import android.os.RemoteException;
import android.telephony.TelephonyManager;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;

import com.akamrnagar.mindful.models.AndroidApp;
import com.akamrnagar.mindful.utils.AppConstants;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.Log;

public class NetworkUsageHelper {


    @RequiresApi(api = Build.VERSION_CODES.M)
    public static List<AndroidApp> generateNetworkUsage(List<AndroidApp> apps, PackageManager packageManager, @NonNull Context context) {
        NetworkStatsManager networkStatsManager = (NetworkStatsManager) context.getSystemService(Context.NETWORK_STATS_SERVICE);

        Calendar startCal = Calendar.getInstance();
        Calendar endCal = Calendar.getInstance();
        int todayOfWeek = startCal.get(Calendar.DAY_OF_WEEK);

        startCal.set(Calendar.HOUR_OF_DAY, 0);
        startCal.set(Calendar.MINUTE, 0);
        startCal.set(Calendar.SECOND, 0);

        endCal.set(Calendar.HOUR_OF_DAY, 23);
        endCal.set(Calendar.MINUTE, 59);
        endCal.set(Calendar.SECOND, 59);


        for (int i = 1; i <= todayOfWeek; i++) {
            startCal.set(Calendar.DAY_OF_WEEK, i);
            endCal.set(Calendar.DAY_OF_WEEK, i);

            long end = 0L;
            if (i == todayOfWeek) {
                end = System.currentTimeMillis();
            } else {
                end = endCal.getTimeInMillis();
            }

            /// one day usage
            HashMap<Integer, Long> mobileOneDay = fetchMobileUsageForInterval(networkStatsManager, startCal.getTimeInMillis(), end);
            HashMap<Integer, Long> wifiOneDay = fetchWifiUsageForInterval(networkStatsManager, startCal.getTimeInMillis(), end);

            for (AndroidApp app : apps) {
                if (mobileOneDay.containsKey(app.appUid)) {
                    app.mobileUsageThisWeek.set((i - 1), mobileOneDay.getOrDefault(app.appUid, 0L));
                }
                if (wifiOneDay.containsKey(app.appUid)) {
                    app.wifiUsageThisWeek.set((i - 1), wifiOneDay.getOrDefault(app.appUid, 0L));
                }
            }
        }


        return apps;
    }


    @NonNull
    private static HashMap<Integer, Long> fetchWifiUsageForInterval(@NonNull NetworkStatsManager networkStatsManager, long start, long end) {
        HashMap<Integer, Long> wifiUsageMap = new HashMap<>();

        try {
            /// fetch wifi usage
            NetworkStats networkStatsWifi = networkStatsManager.querySummary(ConnectivityManager.TYPE_WIFI, null, start, end);
            NetworkStats.Bucket bucketWifi = new NetworkStats.Bucket();

            do {
                networkStatsWifi.getNextBucket(bucketWifi);
                if (wifiUsageMap.containsKey(bucketWifi.getUid())) {
                    Long previous = wifiUsageMap.getOrDefault(bucketWifi.getUid(), 0L);
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
            Log.e(AppConstants.ERROR_TAG, "fetchWifiUsageForInterval():  Error in fetching wifi usage for app ");
        }

        return wifiUsageMap;
    }

    @NonNull
    private static HashMap<Integer, Long> fetchMobileUsageForInterval(@NonNull NetworkStatsManager networkStatsManager, long start, long end) {
        HashMap<Integer, Long> mobileUsageMap = new HashMap<>();

        try {
            /// fetch wifi usage
            NetworkStats networkStatsMobile = networkStatsManager.querySummary(ConnectivityManager.TYPE_MOBILE, null, start, end);
            NetworkStats.Bucket bucketMobile = new NetworkStats.Bucket();

            do {
                networkStatsMobile.getNextBucket(bucketMobile);
                if (mobileUsageMap.containsKey(bucketMobile.getUid())) {
                    Long previous = mobileUsageMap.getOrDefault(bucketMobile.getUid(), 0L);
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
            Log.e(AppConstants.ERROR_TAG, "fetchMobileUsageForInterval():  Error in fetching wifi usage for app ");
        }

        return mobileUsageMap;
    }
}
