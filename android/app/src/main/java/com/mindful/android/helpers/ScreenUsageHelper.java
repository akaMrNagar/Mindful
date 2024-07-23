package com.mindful.android.helpers;

import android.app.usage.UsageStats;
import android.app.usage.UsageStatsManager;

import androidx.annotation.NonNull;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

/**
 * ScreenUsageHelper provides utility methods for gathering and calculating screen usage statistics
 * for Android applications. It interacts with the UsageStatsManager to query and process usage data.
 */
public class ScreenUsageHelper {

    /**
     * Generates screen usage statistics for a specified time interval.
     *
     * @param usageStatsManager The UsageStatsManager used to query screen usage data.
     * @param start             The start time of the interval in milliseconds.
     * @param end               The end time of the interval in milliseconds.
     * @return A map with package names as keys and their corresponding screen usage time in seconds as values.
     */
    @NonNull
    public static HashMap<String, Long> generateUsageForInterval(@NonNull UsageStatsManager usageStatsManager, long start, long end) {
        HashMap<String, Long> oneDayUsageMap = new HashMap<>();
        List<UsageStats> usageStatsList = usageStatsManager.queryUsageStats(UsageStatsManager.INTERVAL_DAILY, start, end);
        UsageStats prevStat = null;

        for (UsageStats usageStat : usageStatsList) {
            long lastTimeUsed = usageStat.getLastTimeUsed();
            if (lastTimeUsed < start || lastTimeUsed > end) continue;

            // Record last event between the interval
            if (prevStat == null || lastTimeUsed > prevStat.getLastTimeUsed()) {
                prevStat = usageStat;
            }

            String packageName = usageStat.getPackageName();
            long screenTime = oneDayUsageMap.getOrDefault(packageName, 0L);
            screenTime += usageStat.getTotalTimeInForeground();

            oneDayUsageMap.put(packageName, screenTime);
        }

        // If the last event is same as the launched app means it is opened but not closed which eventually means it is running
        if (prevStat != null) {
            Long calcTime = oneDayUsageMap.getOrDefault(prevStat.getPackageName(), 0L);
            calcTime += (System.currentTimeMillis() - prevStat.getLastTimeUsed());
            oneDayUsageMap.put(prevStat.getPackageName(), calcTime);
        }

        // Convert milliseconds to seconds
        oneDayUsageMap.replaceAll((k, v) -> (v / 1000));
        return oneDayUsageMap;
    }

    /**
     * Fetches the screen usage time of a specific application for the current day until now.
     *
     * @param usageStatsManager The UsageStatsManager used to query screen usage data.
     * @param packageName       The package name of the application whose usage time is to be fetched.
     * @return The total screen usage time of the specified application in seconds.
     */
    public static long fetchAppUsageTodayTillNow(@NonNull UsageStatsManager usageStatsManager, String packageName) {

        Calendar midNightCal = Calendar.getInstance();
        midNightCal.set(Calendar.HOUR_OF_DAY, 0);
        midNightCal.set(Calendar.MINUTE, 0);
        midNightCal.set(Calendar.SECOND, 0);

        long start = midNightCal.getTimeInMillis();
        long end = System.currentTimeMillis();

        List<UsageStats> usageStatsList = usageStatsManager.queryUsageStats(UsageStatsManager.INTERVAL_DAILY, start, end);
        UsageStats prevStat = null;
        long screenTime = 0;

        for (UsageStats usageStat : usageStatsList) {

            long lastTimeUsed = usageStat.getLastTimeUsed();
            if (lastTimeUsed < start || lastTimeUsed > end) continue;

            // Record last event between the interval
            if (prevStat == null || lastTimeUsed > prevStat.getLastTimeUsed()) {
                prevStat = usageStat;
            }

            // Get total screen time of the launched app
            if (usageStat.getPackageName().equals(packageName)) {
                screenTime += usageStat.getTotalTimeInForeground();
            }
        }

        // If the last event is same as the launched app means it is opened but not closed which eventually means it is running
        if (prevStat != null && prevStat.getPackageName().equals(packageName)) {
            screenTime += (System.currentTimeMillis() - prevStat.getLastTimeUsed());
        }

        return (screenTime / 1000);
    }

}
