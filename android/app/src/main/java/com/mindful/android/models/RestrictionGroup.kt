package com.mindful.android.models

import com.mindful.android.utils.JsonUtils
import org.json.JSONObject

/**
 * Represents a group of restricted apps with shared usage settings like timers and active periods.
 */
data class RestrictionGroup(
    /**
     * Unique ID of the group.
     */
    val id: Int = 0,

    /**
     * Name of the group (e.g., "Social", "Games").
     */
    val groupName: String = "Social",

    /**
     * Time limit for all apps in the group, in seconds.
     */
    val timerSec: Int = 0,

    /**
     * Time of day (in minutes) from midnight when usage is allowed to start.
     */
    val activePeriodStart: Int = 0,

    /**
     * Total duration (in minutes) of the allowed usage period.
     */
    val periodDurationInMins: Int = 0,

    /**
     * Set of app package names associated with this group.
     */
    val distractingApps: Set<String> = emptySet(),
) {
    companion object {

        /**
         * Constructs a [RestrictionGroup] from a JSON string.
         */
        fun fromJson(json: String): RestrictionGroup {
            val jsonObject = JSONObject(json)
            return RestrictionGroup(
                id = jsonObject.optInt("id", 0),
                groupName = jsonObject.optString("groupName", "Social"),
                timerSec = jsonObject.optInt("timerSec", 0),
                activePeriodStart = jsonObject.optInt("activePeriodStart", 0),
                periodDurationInMins = jsonObject.optInt("periodDurationInMins", 0),
                distractingApps = JsonUtils.parseStringSet(
                    jsonObject.optJSONArray("distractingApps")?.toString()
                )
            )
        }
    }
}
