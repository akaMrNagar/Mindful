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

import android.util.Log
import org.json.JSONException
import org.json.JSONObject

data class FocusSession(private val jsonObject: JSONObject) {
    /**
     * Flag indicating whether to start DND mode.
     */
    val toggleDnd: Boolean = jsonObject.optBoolean("toggleDnd", false)


    /**
     * Total duration for this focus session.
     */
    val durationSecs: Int = jsonObject.optInt("durationSeconds", 0)

    /**
     * Start time in Milliseconds since Epoch for this focus session.
     */
    val startTimeMsEpoch: Long = jsonObject.optLong("startTimeMsEpoch", 0L)


    /**
     * Set of app package names identified as distracting apps.
     */
    val distractingApps: HashSet<String>


    init {
        // Deserialize distracting apps
        val appsJsonArray = jsonObject.optJSONArray("distractingApps")
        val distractingApps = HashSet<String>(0)
        if (appsJsonArray != null) {
            for (i in 0 until appsJsonArray.length()) {
                distractingApps.add(appsJsonArray.getString(i))
            }
        }
        this.distractingApps = distractingApps
    }
}
