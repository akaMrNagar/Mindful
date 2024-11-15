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

package com.mindful.android.helpers;

import android.app.usage.UsageEvents;
import android.app.usage.UsageStatsManager;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

/**
 * ScreenUsageHelper provides utility methods for gathering and calculating screen usage statistics
 * for Android applications. It interacts with the UsageStatsManager to query and process usage data.
 */
public class ScreenUsageHelper {

    /**
     * Fetches screen usage statistics for a specified time interval using usage events.
     * If the target package is not null then this method will fetch usage for that app only
     * otherwise for all device apps.
     *
     * @param usageStatsManager The UsageStatsManager used to query screen usage data.
     * @param start             The start time of the interval in milliseconds.
     * @param end               The end time of the interval in milliseconds.
     * @param targetedPackage   The package name of the app for fetching its screen usage.
     * @return A map with package names as keys and their corresponding screen usage time in seconds as values.
     */
    @NonNull
    public static HashMap<String, Long> fetchUsageForInterval(@NonNull UsageStatsManager usageStatsManager, long start, long end, @Nullable String targetedPackage) {
        HashMap<String, Long> oneDayUsageMap = new HashMap<>();
        UsageEvents usageEvents = usageStatsManager.queryEvents(start, end);
        Map<String, UsageEvents.Event> lastResumedEvents = new HashMap<>();
        boolean isFirstEvent = true;


        while (usageEvents.hasNextEvent()) {
            UsageEvents.Event currentEvent = new UsageEvents.Event(); // Do not move this from while loop
            usageEvents.getNextEvent(currentEvent);
            int eventType = currentEvent.getEventType();

            String packageName = currentEvent.getPackageName();
            /// If target package is not null
            if (targetedPackage != null && !packageName.equals(targetedPackage)) continue;

            String className = currentEvent.getClassName();
            String eventKey = packageName + className;

            if (eventType == UsageEvents.Event.ACTIVITY_RESUMED) {
                lastResumedEvents.put(eventKey, currentEvent);
            } else if (eventType == UsageEvents.Event.ACTIVITY_STOPPED || eventType == UsageEvents.Event.ACTIVITY_PAUSED) {
                Long screenTime = oneDayUsageMap.getOrDefault(packageName, 0L);
                UsageEvents.Event lastResumedEvent = lastResumedEvents.get(eventKey);

                if (lastResumedEvent != null
                        && lastResumedEvent.getPackageName().equals(packageName)
                        && lastResumedEvent.getClassName().equals(className)
                ) {
                    // Calculate usage from the last ACTIVITY_RESUMED to this ACTIVITY_PAUSED
                    screenTime += (currentEvent.getTimeStamp() - lastResumedEvent.getTimeStamp());
                    lastResumedEvents.remove(eventKey);
                } else if (isFirstEvent) {
                    // Log.d("TAG", "fetchUsageForInterval: app " + packageName);
                    // Fallback logic in case no matching ACTIVITY_RESUMED was found. May be this app was opened before START time
                    screenTime += (currentEvent.getTimeStamp() - start);
                }
                oneDayUsageMap.put(packageName, screenTime);
                isFirstEvent = false;
            }
        }

        // Convert milliseconds to seconds
        oneDayUsageMap.replaceAll((k, v) -> (v / 1000));
        return oneDayUsageMap;
    }
    
    /**
     * Fetches the screen usage time of a specific application for the current day until now using usage events.
     *
     * @param usageStatsManager The UsageStatsManager used to query screen usage data.
     * @param packageName       The package name of the application whose usage time is to be fetched.
     * @return The total screen usage time of the specified application in seconds.
     */
    public static int fetchAppUsageTodayTillNow(@NonNull UsageStatsManager usageStatsManager, String packageName) {
        Calendar midNightCal = Calendar.getInstance();
        midNightCal.set(Calendar.HOUR_OF_DAY, 0);
        midNightCal.set(Calendar.MINUTE, 0);
        midNightCal.set(Calendar.SECOND, 0);

        long start = midNightCal.getTimeInMillis();
        long end = System.currentTimeMillis();
        long screenTime = fetchUsageForInterval(usageStatsManager, start, end, packageName).getOrDefault(packageName, 0L);

        // Log.d("Time", "fetchAppUsageFromEvents: package: " + packageName + " screen time seconds : " + screenTime);
        return (int) screenTime;
    }

    /**
     * Fetches the screen usage time of a specific application for the current day until now using usage events.
     *
     * @param usageStatsManager The UsageStatsManager used to query screen usage data.
     * @return The total screen usage time of the specified application in seconds.
     */
    @NonNull
    public static HashMap<String, Long> fetchAppUsageTodayTillNow(@NonNull UsageStatsManager usageStatsManager) {
        Calendar midNightCal = Calendar.getInstance();
        midNightCal.set(Calendar.HOUR_OF_DAY, 0);
        midNightCal.set(Calendar.MINUTE, 0);
        midNightCal.set(Calendar.SECOND, 0);

        long start = midNightCal.getTimeInMillis();
        long end = System.currentTimeMillis();
        return fetchUsageForInterval(usageStatsManager, start, end, null);
    }
}
