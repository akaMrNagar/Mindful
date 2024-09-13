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

import java.util.Arrays;
import java.util.HashSet;
import java.util.List;

/**
 * Represents the bedtime settings configuration for the application.
 */
public class BedtimeSettings {

    /**
     * Boolean indicating if the bedtime routine schedule is ON or OFF.
     */
    public boolean isScheduleOn = false;

    /**
     * The time when the bedtime schedule task will start, represented as total minutes from midnight (00:00).
     */
    public int startTimeInMins = 0;

    /**
     * The total duration of the schedule from startTime to endTime, in minutes.
     */
    public int totalDurationInMins = 0;

    /**
     * List of booleans indicating the days of the week when the schedule should be active.
     * [0] - Sunday, [1] - Monday, ..., [6] - Saturday.
     */
    public List<Boolean> scheduleDays = Arrays.asList(false, true, true, true, true, true, false);

    /**
     * Boolean indicating if Do Not Disturb (DND) mode should be started when the bedtime routine begins.
     */
    public boolean shouldStartDnd = false;

    /**
     * Set of app package names identified as distracting apps.
     */
    public HashSet<String> distractingApps = new HashSet<>(0);

    /**
     * Constructs a BedtimeSettings instance from a JSON string.
     *
     * @param jsonString JSON representation of BedtimeSettings.
     */
    public BedtimeSettings(@NonNull String jsonString) {
        if (jsonString.isEmpty()) {
            Log.d("Mindful.BedtimeSettings", "JSON string passed to the constructor is empty");
        } else {
            try {
                // Clean the JSON string and parse it
                jsonString = jsonString.replace("\\", "");
                JSONObject jsonObject = new JSONObject(jsonString.substring(1, jsonString.length() - 1));

                // Deserialize fields
                isScheduleOn = jsonObject.getBoolean("isScheduleOn");
                startTimeInMins = jsonObject.getInt("startTimeInMins");
                totalDurationInMins = jsonObject.getInt("totalDurationInMins");
                shouldStartDnd = jsonObject.getBoolean("shouldStartDnd");

                // Deserialize schedule days
                JSONArray daysJsonArray = jsonObject.getJSONArray("scheduleDays");
                for (int i = 0; i < daysJsonArray.length(); i++) {
                    scheduleDays.set(i, daysJsonArray.getBoolean(i));
                }

                // Deserialize distracting apps
                JSONArray appsJsonArray = jsonObject.getJSONArray("distractingApps");
                for (int i = 0; i < appsJsonArray.length(); i++) {
                    distractingApps.add(appsJsonArray.getString(i));
                }

            } catch (JSONException e) {
                Log.e("Mindful.BedtimeSettings", "Error deserializing JSON to BedtimeSettings model", e);
            }
        }
    }

    /**
     * Provides a string representation of the BedtimeSettings object.
     *
     * @return A string representing the BedtimeSettings object.
     */
    @NonNull
    @Override
    public String toString() {
        return "BedtimeSettings{" +
                "isScheduleOn=" + isScheduleOn +
                ", startTimeInMins=" + startTimeInMins +
                ", totalDurationInMins=" + totalDurationInMins +
                ", scheduleDays=" + scheduleDays +
                ", shouldStartDnd=" + shouldStartDnd +
                ", distractingApps=" + distractingApps +
                '}';
    }
}
