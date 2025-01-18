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
        end: Long
    ): HashMap<String, Long> {
        val usageMap = HashMap<String, Long>()

        // Load 3 hour earlier events for granularity
        val usageEvents = usageStatsManager.queryEvents(start - (3 * 60 * 60 * 1000), end)
        val lastResumedEvents: MutableMap<String, UsageEvents.Event> = HashMap()

        while (usageEvents.hasNextEvent()) {
            val event = UsageEvents.Event()
            usageEvents.getNextEvent(event)

            val packageName = event.packageName
            val eventKey = packageName + event.className
            val currentTimeStamp = event.timeStamp

            when (event.eventType) {
                UsageEvents.Event.ACTIVITY_RESUMED -> lastResumedEvents[eventKey] = event
                UsageEvents.Event.ACTIVITY_PAUSED, UsageEvents.Event.ACTIVITY_STOPPED -> {
                    // App stopped between interval
                    if (currentTimeStamp > start) {
                        var usageTime = usageMap.getOrDefault(packageName, 0L)
                        val lastResumedEvent = lastResumedEvents[eventKey]

                        // App has resume event
                        if (lastResumedEvent != null) {
                            val resumedTime = lastResumedEvent.timeStamp
                            usageTime +=
                                    // App is resumed after start (NORMAL)
                                if (resumedTime >= start) {
                                    currentTimeStamp - resumedTime
                                }
                                // App is resumed before start but stopped after start (EDGE 1)
                                else {
                                    currentTimeStamp - start
                                }
                        }
                        usageMap[packageName] = usageTime
                    }
                    lastResumedEvents.remove(eventKey)
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

        // Convert milliseconds to seconds
        usageMap.replaceAll { _, v -> v / 1000 }
        usageMap.entries.removeIf { entry -> entry.value == 0L }
        return usageMap
    }

    /**
     * Fetches the screen usage time of a all installed application for the current day until now using usage events.
     *
     * @param usageStatsManager The UsageStatsManager used to query screen usage data.
     * @return The total screen usage time of the specified application in seconds.
     */
    fun fetchAppUsageTodayTillNow(usageStatsManager: UsageStatsManager): HashMap<String, Long> {
        val midNightCal = Calendar.getInstance()
        midNightCal[Calendar.HOUR_OF_DAY] = 0
        midNightCal[Calendar.MINUTE] = 0
        midNightCal[Calendar.SECOND] = 0

        val start = midNightCal.timeInMillis
        val end = System.currentTimeMillis()
        return fetchUsageForInterval(usageStatsManager, start, end)
    }
}
