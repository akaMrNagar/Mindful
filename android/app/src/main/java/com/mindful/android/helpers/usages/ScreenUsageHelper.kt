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
package com.mindful.android.helpers.usages

import android.app.usage.UsageEvents
import android.app.usage.UsageStatsManager
import java.util.Calendar

/**
 * ScreenUsageHelper provides utility methods for gathering and calculating screen usage statistics
 * for Android applications. It interacts with the UsageStatsManager to query and process usage data.
 */
object ScreenUsageHelper {
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
    fun fetchUsageForInterval(
        usageStatsManager: UsageStatsManager,
        start: Long,
        end: Long,
    ): Map<String, Long> {
        val usageMap = mutableMapOf<String, Long>()
        val lastResumedEvents = mutableMapOf<String, UsageEvents.Event>()

        // Load 3 hour earlier events for granularity
        val usageEvents = usageStatsManager.queryEvents(start - (3 * 60 * 60 * 1000), end)

        while (usageEvents.hasNextEvent()) {
            // Never move this outside the while loop otherwise the usage will be 0
            val event = UsageEvents.Event()
            usageEvents.getNextEvent(event)

            val packageName = event.packageName
            val currentTimeStamp = event.timeStamp
            val eventKey = packageName + event.className

            when (event.eventType) {
                UsageEvents.Event.ACTIVITY_RESUMED -> lastResumedEvents[eventKey] = event
                UsageEvents.Event.ACTIVITY_PAUSED, UsageEvents.Event.ACTIVITY_STOPPED -> {
                    // If any resume event for the key
                    lastResumedEvents.remove(eventKey)?.let { lastResumedEvent ->
                        /// If app is paused or stopped after the start
                        if (currentTimeStamp > start) {
                            // MaxOf guarantee that the resume event is after the start
                            val resumeTimeStamp = maxOf(lastResumedEvent.timeStamp, start)
                            usageMap[packageName] = usageMap.getOrDefault(
                                packageName,
                                0L
                            ) + (currentTimeStamp - resumeTimeStamp)
                        }
                    }
                }

                else -> {}
            }
        }

        // App is started but didn't stopped before end
        lastResumedEvents.values
            .maxByOrNull { it.timeStamp }
            ?.let { event ->
                val packageName = event.packageName
                val usageTime = usageMap.getOrDefault(packageName, 0L)
                usageMap[packageName] = usageTime + (end - event.timeStamp)
            }

        return usageMap
            .mapValues { it.value / 1000 }  // Convert ms to seconds
            .filterValues { it > 0L }       // Remove entries with no usage
    }

    /**
     * Fetches the screen usage time of a all installed application for the current day until now using usage events.
     *
     * @param usageStatsManager The UsageStatsManager used to query screen usage data.
     * @return The total screen usage time of the specified application in seconds.
     */
    fun fetchAppUsageTodayTillNow(usageStatsManager: UsageStatsManager): Map<String, Long> {
        val midNightCal = Calendar.getInstance()
        midNightCal[Calendar.HOUR_OF_DAY] = 0
        midNightCal[Calendar.MINUTE] = 0
        midNightCal[Calendar.SECOND] = 0
        midNightCal[Calendar.MILLISECOND] = 0

        val start = midNightCal.timeInMillis
        val end = System.currentTimeMillis()
        return fetchUsageForInterval(usageStatsManager, start, end)
    }
}
