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

import androidx.annotation.NonNull;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashSet;

public class RestrictionGroup {

    /**
     * Unique ID for each restriction group
     */
    public final int id;

    /**
     * Name of the group
     */
    public final String groupName;

    /**
     * The timer set for the group in SECONDS
     */
    public final int timerSec;

    /**
     * [TimeOfDay] in minutes from where the active period will start.
     * It is stored as total minutes.
     */
    public final int activePeriodStart;

    /**
     * [TimeOfDay] in minutes when the active period will end
     * It is stored as total minutes.
     */
    public final int activePeriodEnd;

    /**
     * Total duration of active period from start to end in MINUTES
     */
    public final int periodDurationInMins;

    /**
     * List of app's packages which are associated with the group.
     */
    public final HashSet<String> distractingApps;


    /**
     * Constructor to initialize from JSON.
     *
     * @param jsonObject the JSON object containing restriction group data.
     */
    public RestrictionGroup(@NonNull JSONObject jsonObject) throws JSONException {
        this.id = jsonObject.optInt("id", 0);
        this.groupName = jsonObject.optString("groupName", "");
        this.timerSec = jsonObject.optInt("timerSec", 0);
        this.activePeriodStart = jsonObject.optInt("activePeriodStart", 0);
        this.activePeriodEnd = jsonObject.optInt("activePeriodEnd", 0);
        this.periodDurationInMins = jsonObject.optInt("periodDurationInMins", 0);

        // Deserialize apps package
        JSONArray appsJsonArray = jsonObject.optJSONArray("distractingApps");
        HashSet<String> distractingApps = new HashSet<>(0);
        if (appsJsonArray != null) {
            for (int i = 0; i < appsJsonArray.length(); i++) {
                distractingApps.add(appsJsonArray.getString(i));
            }
        }

        this.distractingApps = distractingApps;
    }
}
