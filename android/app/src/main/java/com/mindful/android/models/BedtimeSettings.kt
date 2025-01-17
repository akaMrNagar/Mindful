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

import android.util.Log
import org.json.JSONException
import org.json.JSONObject

/**
 * Represents the bedtime settings configuration for the application.
 */
data class BedtimeSettings(val jsonString: String) {
    /**
     * Boolean indicating if the bedtime routine schedule is ON or OFF.
     */
    var isScheduleOn: Boolean = false

    /**
     * The time when the bedtime schedule task will start, represented as total minutes from midnight (00:00).
     */
    var startTimeInMins: Int = 0

    /**
     * The total duration of the schedule from startTime to endTime, in minutes.
     */
    var totalDurationInMins: Int = 0

    /**
     * List of booleans indicating the days of the week when the schedule should be active.
     * [0] - Sunday, [1] - Monday, ..., [6] - Saturday.
     */
    var scheduleDays: MutableList<Boolean> =
        mutableListOf(false, true, true, true, true, true, false)

    /**
     * Boolean indicating if Do Not Disturb (DND) mode should be started when the bedtime routine begins.
     */
    var shouldStartDnd: Boolean = false

    /**
     * Set of app package names identified as distracting apps.
     */
    var distractingApps: HashSet<String> = HashSet(0)

    /**
     * Constructs a BedtimeSettings instance from a JSON string.
     *
     * @param jsonString JSON representation of BedtimeSettings.
     */
    init {
        if (jsonString.isEmpty()) {
            Log.d("Mindful.BedtimeSettings", "JSON string passed to the constructor is empty")
        } else {
            try {
                val jsonObject = JSONObject(jsonString)

                // Deserialize fields
                this.isScheduleOn = jsonObject.optBoolean("isScheduleOn", false)
                this.startTimeInMins = jsonObject.optInt("scheduleStartTime", 0)
                this.totalDurationInMins = jsonObject.optInt("scheduleDurationInMins", 0)
                this.shouldStartDnd = jsonObject.optBoolean("shouldStartDnd", false)

                // Deserialize schedule days
                val daysJsonArray = jsonObject.optJSONArray("scheduleDays")
                if (daysJsonArray != null) {
                    for (i in 0 until daysJsonArray.length()) {
                        scheduleDays[i] = daysJsonArray.getBoolean(i)
                    }
                }

                // Deserialize distracting apps
                val appsJsonArray = jsonObject.optJSONArray("distractingApps")
                if (appsJsonArray != null) {
                    for (i in 0 until appsJsonArray.length()) {
                        distractingApps.add(appsJsonArray.getString(i))
                    }
                }
            } catch (e: JSONException) {
                Log.e(
                    "Mindful.BedtimeSettings",
                    "Error deserializing JSON to BedtimeSettings model",
                    e
                )
            }
        }
    }

    /**
     * Provides a string representation of the BedtimeSettings object.
     *
     * @return A string representing the BedtimeSettings object.
     */
    override fun toString(): String {
        return "BedtimeSettings{" +
                "isScheduleOn=" + isScheduleOn +
                ", startTimeInMins=" + startTimeInMins +
                ", totalDurationInMins=" + totalDurationInMins +
                ", scheduleDays=" + scheduleDays +
                ", shouldStartDnd=" + shouldStartDnd +
                ", distractingApps=" + distractingApps +
                '}'
    }
}
