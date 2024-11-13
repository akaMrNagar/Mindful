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
    public int id = -1;
    public String groupName = "";
    public int timerSec = 0;
    public HashSet<String> distractingApps = new HashSet<>(0);


    /**
     * Constructor to initialize from JSON.
     *
     * @param jsonObject the JSON object containing restriction group data.
     */
    public RestrictionGroup(@NonNull JSONObject jsonObject) throws JSONException {
        this.id = jsonObject.optInt("id", 0);
        this.groupName = jsonObject.optString("groupName", "");
        this.timerSec = jsonObject.optInt("timerSec", 0);

        // Deserialize apps package
        JSONArray appsJsonArray = jsonObject.optJSONArray("distractingApps");
        if (appsJsonArray != null) {
            for (int i = 0; i < appsJsonArray.length(); i++) {
                this.distractingApps.add(appsJsonArray.getString(i));
            }
        }
    }
}
