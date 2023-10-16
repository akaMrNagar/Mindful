package com.akamrnagar.mindful.helpers;

import android.app.usage.UsageEvents;
import android.app.usage.UsageStatsManager;
import android.content.Context;
import android.os.Build;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;

import com.akamrnagar.mindful.models.AndroidApp;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ScreenUsageHelper {

    public static List<AndroidApp> generateScreenUsage(List<AndroidApp> apps, UsageStatsManager usageStatsManager) {

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
    public static HashMap<String, Long> generateUsageForInterval(@NonNull UsageStatsManager usageStatsManager, long start, long end) {

        UsageEvents usageEvents = usageStatsManager.queryEvents(start, end);
        UsageEvents.Event prevEvent = null;
        HashMap<String, Long> oneDayUsageMap = new HashMap<>();


        while (usageEvents.hasNextEvent()) {
            UsageEvents.Event currentEvent = new UsageEvents.Event();
            usageEvents.getNextEvent(currentEvent);

            if (currentEvent.getEventType() == UsageEvents.Event.ACTIVITY_RESUMED) {
                prevEvent = currentEvent;
            } else if ((currentEvent.getEventType() == UsageEvents.Event.ACTIVITY_PAUSED)
                    && prevEvent != null) {

                String packageName = prevEvent.getPackageName();
                long diff = (currentEvent.getTimeStamp() - prevEvent.getTimeStamp());
                if (oneDayUsageMap.containsKey(packageName)) {
                    long currentScreenTime = oneDayUsageMap.get(packageName);
                    oneDayUsageMap.put(packageName, currentScreenTime + diff);
                } else {
                    oneDayUsageMap.put(packageName, diff);
                }
            }
        }

        /// convert milliseconds to seconds
        for (Map.Entry<String, Long> entry : oneDayUsageMap.entrySet()) {
            oneDayUsageMap.put(entry.getKey(), entry.getValue() / 1000);
        }

        return oneDayUsageMap;
    }
}
