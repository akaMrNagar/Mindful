package com.akamrnagar.mindful.helpers;

import android.app.usage.UsageEvents;
import android.app.usage.UsageStatsManager;
import android.util.Log;

import androidx.annotation.NonNull;

import com.akamrnagar.mindful.models.AndroidApp;
import com.akamrnagar.mindful.utils.AppConstants;

import java.util.Calendar;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;

public class ScreenUsageHelper {
    public static List<AndroidApp> generateUsageForThisWeek(List<AndroidApp> apps, UsageStatsManager usageStatsManager) {

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

            HashMap<String, Long> oneDayMap = generateUsageForInterval(usageStatsManager, startCal.getTimeInMillis(), end);
            for (AndroidApp app : apps) {
                app.screenTimeThisWeek.set((i - 1), oneDayMap.getOrDefault(app.packageName, 0L));
            }
        }

        return apps;
    }

    @NonNull
    private static HashMap<String, Long> generateUsageForInterval(@NonNull UsageStatsManager usageStatsManager, long start, long end) {

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
                    long previousTime = oneDayUsageMap.getOrDefault(prevOpenEvent.getPackageName(), 0L);
                    oneDayUsageMap.put(prevOpenEvent.getPackageName(), previousTime + diff);
                } else {
                    /// This block will run for the apps which have ACTIVITY_RESUMED event before 12 midnight
                    long diff = (currentEvent.getTimeStamp() - start);
                    long previousTime = oneDayUsageMap.getOrDefault(currentEvent.getPackageName(), 0L);
                    oneDayUsageMap.put(currentEvent.getPackageName(), previousTime + diff);
                }

            }
        }

        /// convert milliseconds to seconds
        return convertMapMsToSeconds(oneDayUsageMap);
    }

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
                    long previousTime = usageTodayMap.getOrDefault(prevOpenEvent.getPackageName(), 0L);
                    usageTodayMap.put(prevOpenEvent.getPackageName(), previousTime + diff);
                } else {
                    /// This block will run for the apps which have ACTIVITY_RESUMED event before 12 midnight
                    long diff = (currentEvent.getTimeStamp() - start);
                    long previousTime = usageTodayMap.getOrDefault(currentEvent.getPackageName(), 0L);
                    usageTodayMap.put(currentEvent.getPackageName(), previousTime + diff);
                }
            }
        }

        if (lastEvent != null && prevOpenEvent != null && Objects.equals(lastEvent.getPackageName(), prevOpenEvent.getPackageName())) {
            long lastOpenedAppTime = usageTodayMap.getOrDefault(prevOpenEvent.getPackageName(), 0L);
            lastOpenedAppTime += (System.currentTimeMillis() - prevOpenEvent.getTimeStamp());
            usageTodayMap.put(prevOpenEvent.getPackageName(), lastOpenedAppTime);
        }


        /// convert milliseconds to seconds
        return convertMapMsToSeconds(usageTodayMap);
    }


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

    private static HashMap<String, Long> convertMapMsToSeconds(@NonNull HashMap<String, Long> msMap) {
        for (Map.Entry<String, Long> entry : msMap.entrySet()) {
            msMap.put(entry.getKey(), entry.getValue() / 1000);
        }
        return msMap;
    }
}
