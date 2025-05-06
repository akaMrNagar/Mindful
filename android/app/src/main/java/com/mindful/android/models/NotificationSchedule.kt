package com.mindful.android.models

import android.util.Log
import org.json.JSONObject


/**
 * Represents the notification schedule for the application.
 */
data class NotificationSchedule(
    /**
     *  Name or Label for the schedule
     */
    val label: String = "",

    /**
     *  [TimeOfDay] in minutes of the schedule.
     *  It is stored as total minutes.
     */
    val todMinutes: Int = 0,

    /**
     *  Boolean denoting the status of this notification schedule
     */
    val isActive: Boolean = false,
) {
    companion object {
        fun fromJson(json: String): NotificationSchedule {
            val jsonObject = JSONObject(json)

            return NotificationSchedule(
                label = jsonObject.optString("label", ""),
                todMinutes = jsonObject.optInt("time", 0),
                isActive = jsonObject.optBoolean("isActive", false),
            )
        }
    }
}