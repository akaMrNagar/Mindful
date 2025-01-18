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

data class AppRestrictions(private val jsonObject: JSONObject) {
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
     * [TimeOfDay] in minutes from where the active period will start.
     * It is stored as total minutes.
     */
    val activePeriodStart: Int = jsonObject.optInt("activePeriodStart", 0)

    /**
     * Total duration of active period from start to end in MINUTES
     */
    val periodDurationInMins: Int = jsonObject.optInt("periodDurationInMins", 0)

    /**
     * ID of the [RestrictionGroup] this app is associated with or NULL
     */
    val associatedGroupId: Int? =
        if (jsonObject.has("associatedGroupId")) jsonObject.optInt("associatedGroupId")
        else null

}
