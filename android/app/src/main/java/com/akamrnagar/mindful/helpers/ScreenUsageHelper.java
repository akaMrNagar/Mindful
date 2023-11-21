package com.akamrnagar.mindful.helpers;

import static com.akamrnagar.mindful.utils.Extensions.getOrDefault;

import android.app.usage.UsageEvents;
import android.app.usage.UsageStatsManager;

import androidx.annotation.NonNull;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;
import java.util.Set;


/**
 * ScreenUsageHelper is a utility class responsible for gathering screen usage statistics for
 * Android applications.
 * It fetches data about screen time usage of applications and organizes this
 * information into HashMap of app's package name and the usage in seconds.
 */
public class ScreenUsageHelper {
    /**
     * Generates screen usage stats for a specified time interval.
     *
     * @param usageStatsManager The UsageStatsManager used to retrieve screen usage data.
     * @param start             The start time of the interval in milliseconds.
     * @param end               The end time of the interval in milliseconds.
     * @return A map of package names and their screen time in seconds for the specified interval.
     */
    @NonNull
    public static HashMap<String, Long> generateUsageForInterval(@NonNull UsageStatsManager usageStatsManager, long start, long end) {

        UsageEvents usageEvents = usageStatsManager.queryEvents(start, end);
        UsageEvents.Event prevOpenEvent = null;
        HashMap<String, Long> oneDayUsageMap = new HashMap<>();


        while (usageEvents.hasNextEvent()) {
            UsageEvents.Event currentEvent = new UsageEvents.Event();
            usageEvents.getNextEvent(currentEvent);

            if (currentEvent.getEventType() == UsageEvents.Event.ACTIVITY_RESUMED) {
                prevOpenEvent = currentEvent;
            } else if (currentEvent.getEventType() == UsageEvents.Event.ACTIVITY_PAUSED) {
                if (prevOpenEvent != null) {
                    /// This block will run for the apps which have ACTIVITY_RESUMED event after 12 midnight
                    long diff = (currentEvent.getTimeStamp() - prevOpenEvent.getTimeStamp());
                    long previousTime = getOrDefault(oneDayUsageMap, prevOpenEvent.getPackageName(), 0L);
                    oneDayUsageMap.put(prevOpenEvent.getPackageName(), previousTime + diff);
                } else {
                    /// This block will run for the apps which have ACTIVITY_RESUMED event before 12 midnight
                    long diff = (currentEvent.getTimeStamp() - start);
                    long previousTime = getOrDefault(oneDayUsageMap, currentEvent.getPackageName(), 0L);
                    oneDayUsageMap.put(currentEvent.getPackageName(), previousTime + diff);
                }

            }
        }

        /// convert milliseconds to seconds
        return convertMapMsToSeconds(oneDayUsageMap);
    }


    /**
     * Generates screen usage stats for today until the current time.
     *
     * @param usageStatsManager The UsageStatsManager used to retrieve screen usage data.
     * @param start             The start time of the interval.
     * @param onlyForApps       Set of package names for which usage data is generated.
     * @return A map of package names and their screen time in seconds for today till now.
     */
    @NonNull
    public static HashMap<String, Long> generateUsageTodayTillNow(@NonNull UsageStatsManager usageStatsManager, long start, @NonNull Set<String> onlyForApps) {
        HashMap<String, Long> usageTodayMap = new HashMap<>(onlyForApps.size());

        UsageEvents usageEvents = usageStatsManager.queryEvents(start, System.currentTimeMillis());
        UsageEvents.Event prevOpenEvent = null;
        UsageEvents.Event lastEvent = null;


        while (usageEvents.hasNextEvent()) {
            UsageEvents.Event currentEvent = new UsageEvents.Event();
            usageEvents.getNextEvent(currentEvent);

            if (currentEvent.getEventType() == UsageEvents.Event.ACTIVITY_RESUMED) {
                lastEvent = currentEvent;
                if (!onlyForApps.contains(currentEvent.getPackageName())) continue;

                prevOpenEvent = currentEvent;

            } else if (currentEvent.getEventType() == UsageEvents.Event.ACTIVITY_PAUSED) {
                if (!onlyForApps.contains(currentEvent.getPackageName())) continue;

                if (prevOpenEvent != null) {
                    /// This block will run for the apps which have ACTIVITY_RESUMED event after 12 midnight
                    long diff = (currentEvent.getTimeStamp() - prevOpenEvent.getTimeStamp());
                    long previousTime = getOrDefault(usageTodayMap, prevOpenEvent.getPackageName(), 0L);
                    usageTodayMap.put(prevOpenEvent.getPackageName(), previousTime + diff);
                } else {
                    /// This block will run for the apps which have ACTIVITY_RESUMED event before 12 midnight
                    long diff = (currentEvent.getTimeStamp() - start);
                    long previousTime = getOrDefault(usageTodayMap, currentEvent.getPackageName(), 0L);
                    usageTodayMap.put(currentEvent.getPackageName(), previousTime + diff);
                }
            }
        }

        if (lastEvent != null && prevOpenEvent != null && Objects.equals(lastEvent.getPackageName(), prevOpenEvent.getPackageName())) {
            long lastOpenedAppTime = getOrDefault(usageTodayMap, prevOpenEvent.getPackageName(), 0L);
            lastOpenedAppTime += (System.currentTimeMillis() - prevOpenEvent.getTimeStamp());
            usageTodayMap.put(prevOpenEvent.getPackageName(), lastOpenedAppTime);
        }


        /// convert milliseconds to seconds
        return convertMapMsToSeconds(usageTodayMap);
    }


    /**
     * Retrieves the package name of the last used/active app within a specified time interval.
     * The calculated interval will be [ (current time - intervalSec) TO current time ]
     *
     * @param usageStatsManager The UsageStatsManager used to retrieve usage events.
     * @param intervalSec       The length of the time interval in seconds from current time.
     * @return The package name of the last used/active app within the specified time interval.
     */
    public static String getLastActiveApp(@NonNull UsageStatsManager usageStatsManager, long intervalSec) {
        UsageEvents usageEvents = usageStatsManager.queryEvents(System.currentTimeMillis() - (intervalSec * 1000), System.currentTimeMillis());
        UsageEvents.Event lastEvent = null;

        while (usageEvents.hasNextEvent()) {
            UsageEvents.Event currentEvent = new UsageEvents.Event();
            usageEvents.getNextEvent(currentEvent);

            if (currentEvent.getEventType() == UsageEvents.Event.ACTIVITY_RESUMED) {
                lastEvent = currentEvent;
            }
        }

        return lastEvent == null ? "" : lastEvent.getPackageName();
    }

    /**
     * Converts a map containing values in milliseconds to seconds.
     *
     * @param msMap The map with values in milliseconds.
     * @return A map with values converted to seconds.
     */
    private static HashMap<String, Long> convertMapMsToSeconds(@NonNull HashMap<String, Long> msMap) {
        for (Map.Entry<String, Long> entry : msMap.entrySet()) {
            msMap.put(entry.getKey(), entry.getValue() / 1000);
        }
        return msMap;
    }
}
