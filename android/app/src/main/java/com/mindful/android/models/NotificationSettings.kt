package com.mindful.android.models

import android.util.Log
import com.mindful.android.utils.JsonUtils
import org.json.JSONArray
import org.json.JSONObject

/**
 * Represents the notification configuration for the application.
 */
data class NotificationSettings(
    /**
     * Boolean indicating if to store notifications of non-batched apps too.
     */
    val storeNonBatchedToo: Boolean = false,


    /**
     * Notifications recap type for schedule triggered [RecapType]
     */
    val recapSummeryOnly: Boolean = false,


    /**
     * Set of app package names identified as distracting notification apps.
     */
    val batchedApps: Set<String> = emptySet(),

    /**
     *  List of active [NotificationSchedule]
     */
    val schedules: List<NotificationSchedule> = emptyList(),
) {
    companion object {
        fun fromJson(json: String): NotificationSettings {
            val jsonObject = JSONObject(json)

            // Parse schedules
            var schedules = emptyList<NotificationSchedule>()
            try {
                val array = JSONArray(jsonObject.optString("schedules", "[]"))
                schedules = List(array.length())
                { i -> NotificationSchedule.fromJson(array.getString(i)) }
                    .filter { it.isActive }
                    .sortedBy { it.todMinutes }

            } catch (e: Exception) {
                schedules = emptyList()
                Log.e("Mindful.NotificationSettings", "fromJson: Failed to parse schedules ", e)
            }

            return NotificationSettings(
                storeNonBatchedToo = jsonObject.optBoolean("storeNonBatchedToo", false),
                recapSummeryOnly = jsonObject.optInt("recapType", 0) == 0,
                batchedApps = JsonUtils.parseStringSet(
                    jsonObject.optJSONArray("batchedApps")?.toString()
                ),
                schedules = schedules
            )
        }
    }
}