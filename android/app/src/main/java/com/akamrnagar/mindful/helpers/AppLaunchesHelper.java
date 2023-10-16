package com.akamrnagar.mindful.helpers;

import android.app.usage.UsageEvents;
import android.app.usage.UsageStats;
import android.app.usage.UsageStatsManager;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.util.Log;

import androidx.annotation.NonNull;

import com.akamrnagar.mindful.models.AndroidApp;
import com.akamrnagar.mindful.utils.AppConstants;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AppLaunchesHelper {

    public static List<AndroidApp> generateAppLaunches(Context context, List<AndroidApp> apps, UsageStatsManager usageStatsManager) {

        Calendar startCal = Calendar.getInstance();
        Calendar endCal = Calendar.getInstance();

        int todayOfWeek = startCal.get(Calendar.DAY_OF_WEEK);

        startCal.set(Calendar.HOUR_OF_DAY, 0);
        startCal.set(Calendar.MINUTE, 0);
        startCal.set(Calendar.SECOND, 0);

        endCal.set(Calendar.HOUR_OF_DAY, 23);
        endCal.set(Calendar.MINUTE, 59);
        endCal.set(Calendar.SECOND, 59);

        for (int i = 1; i <= 1; i++) {
            startCal.set(Calendar.DAY_OF_WEEK, i);
            endCal.set(Calendar.DAY_OF_WEEK, i);

            long end = 0L;
            if (i == todayOfWeek) {
                end = System.currentTimeMillis();
            } else {
                end = endCal.getTimeInMillis();
            }

            Map<String, Integer> oneDayMap = generateLaunchesForInterval(context, usageStatsManager, startCal.getTimeInMillis(), end);
            for (AndroidApp app : apps) {
                app.launchesThisWeek.set((0), oneDayMap.getOrDefault(app.packageName, 0));
            }
        }

        return apps;
    }


    //            if (currentEvent.getEventType() == UsageEvents.Event.SCREEN_NON_INTERACTIVE) // 29 time android locked or unlocked
//            if (currentEvent.getEventType() == UsageEvents.Event.USER_INTERACTION)  // 18 whats,  4 well-being
    @NonNull
    private static Map<String, Integer> generateLaunchesForInterval(Context context, @NonNull UsageStatsManager usageStatsManager, long start, long end) {

        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);

        UsageEvents usageEvents = usageStatsManager.queryEvents(cal.getTimeInMillis(), System.currentTimeMillis());
        PackageManager packageManager = context.getPackageManager();
        Map<String, Integer> oneDayLaunchesMap = new HashMap<>();
        UsageEvents.Event prevEvent = null;

        while (usageEvents.hasNextEvent()) {
            UsageEvents.Event currentEvent = new UsageEvents.Event();
            usageEvents.getNextEvent(currentEvent);

            if (currentEvent.getEventType() == UsageEvents.Event.ACTIVITY_PAUSED || currentEvent.getEventType() == UsageEvents.Event.ACTIVITY_RESUMED) {
                int prev = oneDayLaunchesMap.getOrDefault(currentEvent.getPackageName(), 0);
                prev++;
                oneDayLaunchesMap.put(currentEvent.getPackageName(), prev);
//                Log.e(AppConstants.LOG_TAG, "class:" + currentEvent.getPackageName());
            } else if (currentEvent.getEventType() == UsageEvents.Event.ACTIVITY_STOPPED) {
                int prev = oneDayLaunchesMap.getOrDefault(currentEvent.getPackageName(), 0);
                prev--;
                oneDayLaunchesMap.put(currentEvent.getPackageName(), prev);
//                Log.e(AppConstants.LOG_TAG, "class:" + currentEvent.getPackageName());
            }

        }

        for (Map.Entry<String, Integer> entry : oneDayLaunchesMap.entrySet()) {
            Log.e(AppConstants.LOG_TAG, entry.getKey() + ": " + entry.getValue());
        }

        return oneDayLaunchesMap;
    }
}