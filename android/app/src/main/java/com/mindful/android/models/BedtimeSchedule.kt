package com.mindful.android.models

import com.mindful.android.utils.JsonUtils
import org.json.JSONObject


/**
 * Represents the bedtime schedule configuration for the application.
 */
data class BedtimeSchedule(
    /**
     * Boolean indicating if the bedtime routine schedule is ON or OFF.
     */
    val isScheduleOn: Boolean = false,

    /**
     * Boolean indicating if Do Not Disturb (DND) mode should be started when the bedtime routine begins.
     */
    val shouldStartDnd: Boolean = false,

    /**
     * The time when the bedtime schedule task will start, represented as total minutes from midnight (00:00).
     */
    val scheduleStartTime: Int = 0,

    /**
     * The total duration of the schedule from startTime to endTime, in minutes.
     */
    val scheduleDurationInMins: Int = 0,

    /**
     * List of booleans indicating the days of the week when the schedule should be active.
     * [0] - Sunday, [1] - Monday, ..., [6] - Saturday.
     */
    val scheduleDays: List<Boolean> = listOf(true, true, true, true, true, false, false),

    /**
     * Set of app package names identified as distracting apps.
     */
    val distractingApps: Set<String> = emptySet(),
) {
    companion object {
        private val DEFAULT_SCHEDULE_DAYS = listOf(true, true, true, true, true, false, false)

        fun fromJson(json: String): BedtimeSchedule {
            val jsonObject = JSONObject(json)
            return BedtimeSchedule(
                isScheduleOn = jsonObject.optBoolean("isScheduleOn", false),
                shouldStartDnd = jsonObject.optBoolean("shouldStartDnd", false),
                scheduleStartTime = jsonObject.optInt("scheduleStartTime", 0),
                scheduleDurationInMins = jsonObject.optInt("scheduleDurationInMins", 0),
                distractingApps = JsonUtils.parseStringSet(
                    jsonObject.optJSONArray("distractingApps")?.toString()
                ),
                scheduleDays = JsonUtils.parseBooleanList(
                    jsonObject.optJSONArray("scheduleDays")?.toString(),
                    DEFAULT_SCHEDULE_DAYS
                )
            )
        }
    }
}