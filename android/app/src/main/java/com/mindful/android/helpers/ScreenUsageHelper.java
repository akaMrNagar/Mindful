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
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.work.impl.background.systemalarm.SystemAlarmDispatcher;

import java.util.Calendar;
import java.util.Comparator;
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
     * @return A map with package names as keys and their corresponding screen usage time in seconds as values.
     */
    @NonNull
    public static HashMap<String, Long> fetchUsageForInterval(@NonNull UsageStatsManager usageStatsManager, long start, long end) {
        HashMap<String, Long> usageMap = new HashMap<>();

        // Load 3 hour earlier events for granularity
        UsageEvents usageEvents = usageStatsManager.queryEvents(start - (3 * 60 * 60 * 1000), end);
        Map<String, UsageEvents.Event> lastResumedEvents = new HashMap<>();

        while (usageEvents.hasNextEvent()) {
            UsageEvents.Event event = new UsageEvents.Event();
            usageEvents.getNextEvent(event);

            String packageName = event.getPackageName();
            String eventKey = packageName + event.getClassName();
            long currentTimeStamp = event.getTimeStamp();

            switch (event.getEventType()) {
                case UsageEvents.Event.ACTIVITY_RESUMED:
                    lastResumedEvents.put(eventKey, event);
                    break;

                case UsageEvents.Event.ACTIVITY_PAUSED:
                case UsageEvents.Event.ACTIVITY_STOPPED:

                    // App stopped between interval
                    if (currentTimeStamp > start) {
                        Long usageTime = usageMap.getOrDefault(packageName, 0L);
                        UsageEvents.Event lastResumedEvent = lastResumedEvents.get(eventKey);

                        // App has resume event
                        if (lastResumedEvent != null) {
                            long resumedTime = lastResumedEvent.getTimeStamp();
                            if (resumedTime >= start) {
                                // App is resumed after start (NORMAL)
                                usageTime += (currentTimeStamp - resumedTime);
                            } else {
                                // App is resumed before start but stopped after start (EDGE 1)
                                usageTime += (currentTimeStamp - start);
                            }
                        }
                        usageMap.put(packageName, usageTime);
                    }
                    lastResumedEvents.remove(eventKey);
                    break;

                default:
                    break;
            }
        }

        // App is started but didn't stopped before end
        lastResumedEvents.values().stream()
                .max(Comparator.comparingLong(UsageEvents.Event::getTimeStamp))
                .ifPresent(event -> {
                    String packageName = event.getPackageName();
                    Long usageTime = usageMap.getOrDefault(packageName, 0L);
                    usageTime += (end - event.getTimeStamp());
                    usageMap.put(packageName, usageTime);
                });

        // Convert milliseconds to seconds
        usageMap.replaceAll((key, value) -> value / 1000);
        return usageMap;
    }

    /**
     * Fetches the screen usage time of a all installed application for the current day until now using usage events.
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
        return fetchUsageForInterval(usageStatsManager, start, end);
    }
}
