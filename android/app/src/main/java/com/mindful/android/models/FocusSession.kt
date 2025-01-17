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

data class FocusSession(val jsonMapString: String) {
    /**
     * Flag indicating whether to start DND mode.
     */
    var toggleDnd: Boolean = false


    /**
     * Total duration for this focus session.
     */
    var durationSecs: Int = 0

    /**
     * Start time in Milliseconds since Epoch for this focus session.
     */
    var startTimeMsEpoch: Long = 0L


    /**
     * Set of app package names identified as distracting apps.
     */
    var distractingApps: HashSet<String> = HashSet(0)


    /**
     * Constructs a FocusSession instance from a JSON string.
     *
     * @param jsonMapString JSON representation of FocusSession.
     */
    init {
        if (jsonMapString.isEmpty()) {
            Log.d("Mindful.FocusSession", "JSON string passed to the constructor is empty")
        } else {
            try {
                val jsonObject = JSONObject(jsonMapString)

                // Deserialize fields
                this.toggleDnd = jsonObject.optBoolean("toggleDnd", false)
                this.durationSecs = jsonObject.optInt("durationSeconds", 0)
                this.startTimeMsEpoch = jsonObject.optLong("startTimeMsEpoch", 0L)

                // Deserialize distracting apps
                val appsJsonArray = jsonObject.optJSONArray("distractingApps")
                if (appsJsonArray != null) {
                    for (i in 0 until appsJsonArray.length()) {
                        distractingApps.add(appsJsonArray.getString(i))
                    }
                }
            } catch (e: JSONException) {
                Log.e("Mindful.FocusSession", "Error deserializing JSON to FocusSession model", e)
            }
        }
    }
}
