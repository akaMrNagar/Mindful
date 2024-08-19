package com.mindful.android.helpers;

import android.app.usage.UsageEvents;
import android.app.usage.UsageStatsManager;
import android.util.Log;

import androidx.annotation.NonNull;

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
     *
     * @param usageStatsManager The UsageStatsManager used to query screen usage data.
     * @param start             The start time of the interval in milliseconds.
     * @param end               The end time of the interval in milliseconds.
     * @return A map with package names as keys and their corresponding screen usage time in seconds as values.
     */
    @NonNull
    public static HashMap<String, Long> fetchUsageForInterval(@NonNull UsageStatsManager usageStatsManager, long start, long end) {
        HashMap<String, Long> oneDayUsageMap = new HashMap<>();
        UsageEvents usageEvents = usageStatsManager.queryEvents(start, end);
        Map<String, UsageEvents.Event> lastResumedEvents = new HashMap<>();
        boolean isFirstEvent = true;


        while (usageEvents.hasNextEvent()) {
            UsageEvents.Event currentEvent = new UsageEvents.Event(); // Do not move this from while loop
            usageEvents.getNextEvent(currentEvent);
            String packageName = currentEvent.getPackageName();
            int eventType = currentEvent.getEventType();

            if (eventType == UsageEvents.Event.ACTIVITY_RESUMED) {
                lastResumedEvents.put(packageName, currentEvent);
                isFirstEvent = false;
            } else if (eventType == UsageEvents.Event.ACTIVITY_PAUSED) {
                Long screenTime = oneDayUsageMap.getOrDefault(packageName, 0L);
                UsageEvents.Event lastResumedEvent = lastResumedEvents.get(packageName);
                if (lastResumedEvent != null) {
                    // Calculate usage from the last ACTIVITY_RESUMED to this ACTIVITY_PAUSED
                    screenTime += (currentEvent.getTimeStamp() - lastResumedEvent.getTimeStamp());
                    oneDayUsageMap.put(packageName, screenTime);
                    lastResumedEvents.remove(packageName);
                } else if (isFirstEvent) {
                    // Fallback logic in case no matching ACTIVITY_RESUMED was found. May be this app was opened before START time
                    screenTime += (currentEvent.getTimeStamp() - start);
                    oneDayUsageMap.put(packageName, screenTime);
                    isFirstEvent = false;
                }
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
    public static long fetchAppUsageTodayTillNow(@NonNull UsageStatsManager usageStatsManager, String packageName) {
        Calendar midNightCal = Calendar.getInstance();
        midNightCal.set(Calendar.HOUR_OF_DAY, 0);
        midNightCal.set(Calendar.MINUTE, 0);
        midNightCal.set(Calendar.SECOND, 0);

        long start = midNightCal.getTimeInMillis();
        long end = System.currentTimeMillis();
        UsageEvents usageEvents = usageStatsManager.queryEvents(start, end);
        UsageEvents.Event lastAppResumeEvent = null;
        long screenTime = 0;


        while (usageEvents.hasNextEvent()) {
            UsageEvents.Event currentEvent = new UsageEvents.Event(); // Do not move this from while loop
            usageEvents.getNextEvent(currentEvent);

            // Skip it if the event does not belong to the specified app
            if (!currentEvent.getPackageName().equals(packageName)) continue;

            int eventType = currentEvent.getEventType();
            if (eventType == UsageEvents.Event.ACTIVITY_RESUMED) {
                lastAppResumeEvent = currentEvent;
            } else if (eventType == UsageEvents.Event.ACTIVITY_PAUSED) {
                if (lastAppResumeEvent != null) {
                    screenTime += (currentEvent.getTimeStamp() - lastAppResumeEvent.getTimeStamp());
                } else {
                    screenTime += (currentEvent.getTimeStamp() - start);
                }
            }
        }

        // If the app is still open (no PAUSED event yet), calculate time till `end`
        if (lastAppResumeEvent != null && lastAppResumeEvent.getTimeStamp() < end) {
            screenTime += (end - lastAppResumeEvent.getTimeStamp());
        }

        Log.d("Time", "fetchAppUsageFromEvents: package: " + packageName + " screen time seconds : " + (screenTime / 1000));
        return (screenTime / 1000);
    }
}
