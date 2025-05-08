package com.mindful.android.models

import com.mindful.android.utils.JsonUtils
import org.json.JSONObject

/**
 * Represents a focus session with metadata like duration, type, state, and reflection.
 */
data class FocusSession(

    /**
     * Flag indicating whether to start DND mode.
     */
    val toggleDnd: Boolean = false,

    /**
     * Start time in Milliseconds since Epoch for this focus session.
     */
    val startTimeMsEpoch: Long = 0L,

    /**
     * Duration of the session in seconds.
     */
    val durationSecs: Int = 0,

    /**
     * Set of app package names identified as distracting apps.
     */
    val distractingApps: Set<String> = emptySet(),

    ) {
    companion object {
        /**
         * Constructs a [FocusSession] from a JSON string.
         */
        fun fromJson(json: String): FocusSession {
            val jsonObject = JSONObject(json)
            return FocusSession(
                toggleDnd = jsonObject.optBoolean("toggleDnd", false),
                startTimeMsEpoch = jsonObject.optLong("startTimeMsEpoch", 0L),
                durationSecs = jsonObject.optInt("durationSeconds", 0),
                distractingApps = JsonUtils.parseStringSet(
                    jsonObject.optJSONArray("distractingApps")?.toString()
                ),
            )
        }
    }
}
