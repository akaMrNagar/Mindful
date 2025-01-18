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
package com.mindful.android.models

import org.json.JSONObject

/**
 * Represents the bedtime settings configuration for the application.
 */
data class BedtimeSettings(private val jsonObject: JSONObject) {
    /**
     * Boolean indicating if the bedtime routine schedule is ON or OFF.
     */
    val isScheduleOn: Boolean = jsonObject.optBoolean("isScheduleOn", false)

    /**
     * The time when the bedtime schedule task will start, represented as total minutes from midnight (00:00).
     */
    val startTimeInMins: Int = jsonObject.optInt("scheduleStartTime", 0)

    /**
     * The total duration of the schedule from startTime to endTime, in minutes.
     */
    val totalDurationInMins: Int = jsonObject.optInt("scheduleDurationInMins", 0)

    /**
     * Boolean indicating if Do Not Disturb (DND) mode should be started when the bedtime routine begins.
     */
    val shouldStartDnd: Boolean = jsonObject.optBoolean("shouldStartDnd", false)

    /**
     * List of booleans indicating the days of the week when the schedule should be active.
     * [0] - Sunday, [1] - Monday, ..., [6] - Saturday.
     */
    val scheduleDays: List<Boolean>


    /**
     * Set of app package names identified as distracting apps.
     */
    val distractingApps: HashSet<String>


    init {
        // Deserialize schedule days
        val daysJsonArray = jsonObject.optJSONArray("scheduleDays")
        val days = mutableListOf(false, true, true, true, true, true, false)
        if (daysJsonArray != null) {
            for (i in 0 until daysJsonArray.length()) {
                days[i] = daysJsonArray.optBoolean(i, false)
            }
        }
        this.scheduleDays = days

        // Deserialize distracting apps
        val appsJsonArray = jsonObject.optJSONArray("distractingApps")
        val distractingApps = HashSet<String>(0)
        if (appsJsonArray != null) {
            for (i in 0 until appsJsonArray.length()) {
                distractingApps.add(appsJsonArray.getString(i))
            }
        }
        this.distractingApps = distractingApps
    }
}