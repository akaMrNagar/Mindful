package com.mindful.android.models

import com.mindful.android.utils.JsonUtils
import org.json.JSONObject

/**
 * Represents the wellbeing configuration for the application.
 */
data class NotificationSettings(
    /**
     * Boolean indicating if to store notifications of non-batched apps too.
     */
    val storeNonBatchedToo: Boolean = false,

    /**
     * Set of app package names identified as distracting notification apps.
     */
    val batchedApps: Set<String> = emptySet(),
) {
    companion object {
        fun fromJson(json: String): NotificationSettings {
            val jsonObject = JSONObject(json)
            return NotificationSettings(
                storeNonBatchedToo = jsonObject.optBoolean("storeNonBatchedToo", false),
                batchedApps = JsonUtils.parseStringSet(
                    jsonObject.optJSONArray("batchedApps")?.toString()
                ),
            )
        }
    }
}