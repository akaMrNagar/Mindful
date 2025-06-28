package com.mindful.android.models

import android.util.Log
import com.mindful.android.enums.ReminderType
import org.json.JSONObject

/**
 * Represents app-level restriction configuration, such as usage time and access limits.
 */
data class WebRestriction(
    /**
     * website host.
     */
    val host: String = "",

    /**
     * Daily timer limit for the app, in seconds.
     */
    val timerSec: Int = 0,

    /**
     * Launch limit per day.
     */
    val launchLimit: Int = 0,

    /**
     * Time of day (in minutes) from midnight when the app usage is allowed to start.
     */
    val activePeriodStart: Int = 0,

    /**
     * Time of day (in minutes) from midnight when the app usage is blocked.
     */
    val activePeriodEnd: Int = 0,

    /**
     * Type of usage reminders to show while using timed app.
     */
    val reminderType: ReminderType = ReminderType.NOTIFICATION,

    /**
     * Flag to know if is Nsfw
     */
    val isNsfw: Boolean = false,

    /**
     * ID of the restriction group this app belongs to (nullable).
     */
    val associatedGroupId: Int? = null,
) {
    companion object {
        /**
         * Constructs an [AppRestriction] from a JSON string.
         */
        fun fromJson(json: String): WebRestriction {
            val jsonObject = JSONObject(json)
            return WebRestriction(
                host = jsonObject.optString("host", ""),
                timerSec = jsonObject.optInt("timerSec", 0),
                launchLimit = jsonObject.optInt("launchLimit", 0),
                activePeriodStart = jsonObject.optInt("activePeriodStart", 0),
                activePeriodEnd = jsonObject.optInt("activePeriodEnd", 0),
                isNsfw = jsonObject.optBoolean("isNsfw", false),
                reminderType = ReminderType.fromName(jsonObject.optString("reminderType", "toast")),
                associatedGroupId = if (jsonObject.isNull("associatedGroupId")) null else jsonObject.optInt(
                    "associatedGroupId"
                ),
            )
        }
    }
}
