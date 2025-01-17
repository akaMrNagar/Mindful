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

data class AppRestrictions(val jsonObject: JSONObject) {
    /**
     * Package name of the related app
     */
    val appPackage: String = jsonObject.optString("appPackage", "")

    /**
     * The timer set for the app in SECONDS
     */
    val timerSec: Int = jsonObject.optInt("timerSec", 0)

    /**
     * The number of times user can launch this app
     */
    val launchLimit: Int = jsonObject.optInt("launchLimit", 0)

    /**
     * Flag denoting if this app can access internet or not
     */
    val canAccessInternet: Boolean =
        jsonObject.optBoolean("canAccessInternet", true)

    /**
     * The interval between each usage alert in SECONDS
     */
    val alertInterval: Int = jsonObject.optInt("alertInterval", 0)

    /**
     * Whether to alert user by dialog if false user will be alerted by notification
     */
    val alertByDialog: Boolean = jsonObject.optBoolean("alertByDialog", false)

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
     * ID of the [RestrictionGroup] this app is associated with or NULL
     */
    var associatedGroupId: Int? = null


    /**
     * Constructor to initialize from JSON.
     *
     * @param jsonObject the JSON object containing app restriction data.
     */
    init {
        // Handles nullable Integer field for associatedGroupId
        if (jsonObject.has("associatedGroupId") && !jsonObject.isNull("associatedGroupId")) {
            this.associatedGroupId = jsonObject.optInt("associatedGroupId")
        } else {
            this.associatedGroupId = null
        }
    }


    override fun toString(): String {
        return "AppRestrictions{" +
                "appPackage='" + appPackage + '\'' +
                ", timerSec=" + timerSec +
                ", launchLimit=" + launchLimit +
                ", alertInterval=" + alertInterval +
                ", alertByDialog=" + alertByDialog +
                ", associatedGroupId=" + associatedGroupId +
                '}'
    }
}
