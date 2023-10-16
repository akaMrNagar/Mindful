package com.akamrnagar.mindful.helpers;

import android.app.usage.UsageEvents;
import android.app.usage.UsageStatsManager;

import androidx.annotation.NonNull;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

public class ServiceHelper {

    @NonNull
    public static HashMap<String, Long> generateUsageTodayTillNow(@NonNull UsageStatsManager usageStatsManager, @NonNull List<String> appsWithTimer) {

        HashMap<String, Long> oneDayUsageMap = new HashMap<>();
        if (appsWithTimer.isEmpty()) return oneDayUsageMap;

        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);

        UsageEvents usageEvents = usageStatsManager.queryEvents(cal.getTimeInMillis(), System.currentTimeMillis());

        UsageEvents.Event lastUnknownEvent = null;
        UsageEvents.Event lastKnownEvent = null;


        while (usageEvents.hasNextEvent()) {
            UsageEvents.Event currentEvent = new UsageEvents.Event();
            usageEvents.getNextEvent(currentEvent);

            if (currentEvent.getEventType() == UsageEvents.Event.ACTIVITY_RESUMED) {
                lastUnknownEvent = currentEvent;
            }


            if (!appsWithTimer.contains(currentEvent.getPackageName())) continue;
            if (currentEvent.getEventType() == UsageEvents.Event.ACTIVITY_RESUMED) {
                lastKnownEvent = currentEvent;

            } else if ((currentEvent.getEventType() == UsageEvents.Event.ACTIVITY_PAUSED)
                    && lastKnownEvent != null) {

                String packageName = lastKnownEvent.getPackageName();
                long diff = (currentEvent.getTimeStamp() - lastKnownEvent.getTimeStamp());
                if (oneDayUsageMap.containsKey(packageName)) {
                    long currentScreenTime = oneDayUsageMap.get(packageName);
                    oneDayUsageMap.put(packageName, currentScreenTime + diff);
                } else {
                    oneDayUsageMap.put(packageName, diff);
                }
            }
        }

        if (Objects.equals(lastUnknownEvent.getPackageName(), lastKnownEvent.getPackageName())) {
            long lastOpenedAppTime = oneDayUsageMap.getOrDefault(lastKnownEvent.getPackageName(), 0L);
            lastOpenedAppTime += (System.currentTimeMillis() - lastKnownEvent.getTimeStamp());
            oneDayUsageMap.put(lastKnownEvent.getPackageName(), lastOpenedAppTime);
        }

        /// convert milliseconds to seconds
        for (Map.Entry<String, Long> entry : oneDayUsageMap.entrySet()) {
            oneDayUsageMap.put(entry.getKey(), entry.getValue() / 1000);
        }

        return oneDayUsageMap;
    }

    public static String getLastActiveAppToday(@NonNull UsageStatsManager usageStatsManager) {

        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);


        UsageEvents usageEvents = usageStatsManager.queryEvents(cal.getTimeInMillis(), System.currentTimeMillis());

        UsageEvents.Event lastEvent = null;


        while (usageEvents.hasNextEvent()) {
            UsageEvents.Event currentEvent = new UsageEvents.Event();
            usageEvents.getNextEvent(currentEvent);

            if (currentEvent.getEventType() == UsageEvents.Event.ACTIVITY_RESUMED) {
                lastEvent = currentEvent;
            }
        }

        return lastEvent.getPackageName();
    }
}
