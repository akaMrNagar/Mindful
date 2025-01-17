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

data class RestrictionGroup(val jsonObject: JSONObject) {
    /**
     * Unique ID for each restriction group
     */
    val id: Int = jsonObject.optInt("id", 0)

    /**
     * Name of the group
     */
    val groupName: String = jsonObject.optString("groupName", "")

    /**
     * The timer set for the group in SECONDS
     */
    val timerSec: Int = jsonObject.optInt("timerSec", 0)

    /**
     * [TimeOfDay] in minutes from where the active period will start.
     * It is stored as total minutes.
     */
    val activePeriodStart: Int = jsonObject.optInt("activePeriodStart", 0)

    /**
     * [TimeOfDay] in minutes when the active period will end
     * It is stored as total minutes.
     */
    val activePeriodEnd: Int = jsonObject.optInt("activePeriodEnd", 0)

    /**
     * Total duration of active period from start to end in MINUTES
     */
    val periodDurationInMins: Int = jsonObject.optInt("periodDurationInMins", 0)

    /**
     * List of app's packages which are associated with the group.
     */
    val distractingApps: HashSet<String?>


    /**
     * Constructor to initialize from JSON.
     *
     * @param jsonObject the JSON object containing restriction group data.
     */
    init {
        // Deserialize apps package
        val appsJsonArray = jsonObject.optJSONArray("distractingApps")
        val distractingApps = HashSet<String?>(0)
        if (appsJsonArray != null) {
            for (i in 0 until appsJsonArray.length()) {
                distractingApps.add(appsJsonArray.getString(i))
            }
        }

        this.distractingApps = distractingApps
    }
}
