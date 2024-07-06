package com.akamrnagar.mindful.models;

import android.util.Log;

import androidx.annotation.NonNull;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.Arrays;
import java.util.HashSet;
import java.util.List;

public class BedtimeSettings {


    /**
     * Boolean notifying if the bedtime routine schedule is ON or OFF
     */
    public boolean isScheduleOn = false;

    /**
     * Time when the bedtime schedule task will starts
     * It is stored as total minutes from midnight 12.
     */
    public int startTimeInMins = 0;

    /**
     * Total duration of schedule between startTime amd endTime
     */
    public int totalDurationMins = 0;

    /**
     * Boolean denoting the status of the bedtime schedule means
     * [For User] if the schedule is running or not.
     * [For Developer]  if the task worker is scheduled or cancelled.
     */
    public List<Boolean> scheduleDays = Arrays.asList(false, true, true, true, true, true, false);


    /**
     * Boolean denoting if to start DO NOT DISTURB mode or not when bedtime starts.
     */
    public boolean shouldStartDnd = false;

    /**
     * List of app's packages which are selected as distracting apps.
     * The [shouldPauseApps] and [shouldBlockInternet] actions will be applied to
     * these apps.
     */
    public HashSet<String> distractingApps = new HashSet<>(0);


    public BedtimeSettings(@NonNull String jsonString) {
        if (jsonString.isEmpty()) {
            Log.e("Mindful.BedtimeSettings", "JSON string passed to the constructor is empty");
        } else {
            try {

                // Below logic fix the following exception :
                // org.json.JSONException: Value of type java.lang.String cannot be converted to JSONObject
                jsonString = jsonString.replace("\\", "");
                JSONObject jsonObject = new JSONObject(jsonString.substring(1, jsonString.length() - 1));

                isScheduleOn = jsonObject.getBoolean("isScheduleOn");
                startTimeInMins = jsonObject.getInt("startTimeInMins");
                totalDurationMins = jsonObject.getInt("totalDurationMins");
                shouldStartDnd = jsonObject.getBoolean("shouldStartDnd");

                /// Schedule days
                JSONArray daysJsonArray = jsonObject.getJSONArray("scheduleDays");

                for (int i = 0; i < daysJsonArray.length(); i++) {
                    scheduleDays.set(i, daysJsonArray.getBoolean(i));
                }

                // Distracting apps
                JSONArray appsJsonArray = jsonObject.getJSONArray("distractingApps");
                for (int i = 0; i < appsJsonArray.length(); i++) {
                    distractingApps.add(appsJsonArray.getString(i));
                }

//                Log.d("Mindful.BedtimeSettings", "Json deserialization completed successfully.");

            } catch (JSONException e) {
                Log.e("Mindful.BedtimeSettings", "Error deserializing JSON to BedtimeSettings model", e);
            }
        }
    }

    @NonNull
    @Override
    public String toString() {
        return "BedtimeSettings{" +
                "isScheduleOn=" + isScheduleOn +
                ", startTimeInMins=" + startTimeInMins +
                ", totalDurationMins=" + totalDurationMins +
                ", scheduleDays=" + scheduleDays +
                ", shouldStartDnd=" + shouldStartDnd +
                ", distractingApps=" + distractingApps +
                '}';
    }
}
