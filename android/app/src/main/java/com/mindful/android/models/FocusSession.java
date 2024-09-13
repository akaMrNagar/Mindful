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

package com.mindful.android.models;

import android.util.Log;

import androidx.annotation.NonNull;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashSet;

public class FocusSession {

    /**
     * Flag indicating whether to start DND mode.
     */
    public boolean toggleDnd = false;


    /**
     * Total duration for this focus session.
     */
    public int durationSecs = 0;

    /**
     * Start time in Milliseconds since Epoch for this focus session.
     */
    public long startTimeMsEpoch = 0L;


    /**
     * Set of app package names identified as distracting apps.
     */
    public HashSet<String> distractingApps = new HashSet<>(0);


    /**
     * Constructs a FocusSession instance from a JSON string.
     *
     * @param jsonMapString JSON representation of FocusSession.
     */
    public FocusSession(@NonNull String jsonMapString) {
        if (jsonMapString.isEmpty()) {
            Log.d("Mindful.FocusSession", "JSON string passed to the constructor is empty");
        } else {
            try {
                JSONObject jsonObject = new JSONObject(jsonMapString);

                // Deserialize fields
                toggleDnd = jsonObject.getBoolean("toggleDnd");
                durationSecs = jsonObject.getInt("durationSeconds");
                startTimeMsEpoch = jsonObject.getLong("startTimeMsEpoch");

                // Deserialize distracting apps
                JSONArray appsJsonArray = jsonObject.getJSONArray("distractingApps");
                for (int i = 0; i < appsJsonArray.length(); i++) {
                    distractingApps.add(appsJsonArray.getString(i));
                }

            } catch (JSONException e) {
                Log.e("Mindful.FocusSession", "Error deserializing JSON to FocusSession model", e);
            }
        }

    }

}
