package com.akamrnagar.mindful.models;

import android.util.Log;

import androidx.annotation.NonNull;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

public class WellBeingSettings {

    /**
     * Flag denoting if to block instagram reels or not
     */
    public boolean blockInstaReels = false;

    /**
     * Flag denoting if to block youtube shorts or not
     */
    public boolean blockYtShorts = false;

    /**
     * Flag denoting if to block snapchat spotlight or not
     */
    public boolean blockSnapSpotlight = false;

    /**
     * Flag denoting if to block facebook reels or not
     */
    public boolean blockFbReels = false;

    /**
     * Flag denoting if the nsfw or adult  websites are blocked or not
     * i.e if accessibility service is filtering websites or not
     */
    public boolean blockNsfwSites = false;

    /**
     * Allowed time for short content in milliseconds (Calculated from seconds in constructor)
     */
    public long allowedShortContentTimeMs = 8 * 60 * 60;

    /**
     * List of website hosts which are blocked.
     */
    public List<String> blockedWebsites = new ArrayList<>(0);

    // Default empty constructor
    public WellBeingSettings() {
    }


    public WellBeingSettings(@NonNull String jsonString) {
        if (jsonString.isEmpty()) {
            Log.d("Mindful.WellBeingSettings", "JSON string passed to the constructor is empty");
        } else {
            try {

                // Below logic fix the following exception :
                // org.json.JSONException: Value of type java.lang.String cannot be converted to JSONObject
                jsonString = jsonString.replace("\\", "");
                JSONObject jsonObject = new JSONObject(jsonString.substring(1, jsonString.length() - 1));


                blockInstaReels = jsonObject.getBoolean("blockInstaReels");
                blockYtShorts = jsonObject.getBoolean("blockYtShorts");
                blockSnapSpotlight = jsonObject.getBoolean("blockSnapSpotlight");
                blockFbReels = jsonObject.getBoolean("blockFbReels");
                blockNsfwSites = jsonObject.getBoolean("blockNsfwSites");
                allowedShortContentTimeMs = jsonObject.getInt("allowedShortContentTimeSec") * 1000L;


                /// Blocked websites
                JSONArray websitesJsonArray = jsonObject.getJSONArray("blockedWebsites");

                for (int i = 0; i < websitesJsonArray.length(); i++) {
                    blockedWebsites.add(websitesJsonArray.getString(i));
                }

            } catch (JSONException e) {
                Log.e("Mindful.WellBeingSettings", "Error deserializing JSON to WellBeingSettings model", e);
            }
        }
    }
}
