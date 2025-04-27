package com.mindful.android.models

import org.json.JSONObject

/**
 * Represents app-level restriction configuration, such as usage time and access limits.
 */
data class AppRestriction(
    /**
     * Package name of the app.
     */
    val appPackage: String = "",

    /**
     * Daily timer limit for the app, in seconds.
     */
    val timerSec: Int = 0,

    /**
     * Launch limit per day.
     */
    val launchLimit: Int = 0,

    /**
     * Time of day (in minutes) from midnight when the app becomes usable.
     */
    val activePeriodStart: Int = 0,

    /**
     * Total active period duration in minutes.
     */
    val periodDurationInMins: Int = 0,

    /**
     * ID of the restriction group this app belongs to (nullable).
     */
    val associatedGroupId: Int? = null,
) {
    companion object {
        /**
         * Constructs an [AppRestriction] from a JSON string.
         */
        fun fromJson(json: String): AppRestriction {
            val jsonObject = JSONObject(json)
            return AppRestriction(
                appPackage = jsonObject.optString("appPackage", ""),
                timerSec = jsonObject.optInt("timerSec", 0),
                launchLimit = jsonObject.optInt("launchLimit", 0),
                activePeriodStart = jsonObject.optInt("activePeriodStart", 0),
                periodDurationInMins = jsonObject.optInt("periodDurationInMins", 0),
                associatedGroupId = if (jsonObject.isNull("associatedGroupId")) null else jsonObject.optInt(
                    "associatedGroupId"
                ),
            )
        }
    }
}
