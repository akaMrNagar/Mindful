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

import java.util.ArrayList;
import java.util.List;

/**
 * Represents the settings related to user well-being in the application.
 */
public class WellBeingSettings {

    /**
     * Flag indicating whether to block Instagram Reels.
     */
    public boolean blockInstaReels = false;

    /**
     * Flag indicating whether to block YouTube Shorts.
     */
    public boolean blockYtShorts = false;

    /**
     * Flag indicating whether to block Snapchat Spotlight.
     */
    public boolean blockSnapSpotlight = false;

    /**
     * Flag indicating whether to block Facebook Reels.
     */
    public boolean blockFbReels = false;

    /**
     * Flag indicating whether to block Reddit Shorts.
     */
    public boolean blockRedditShorts = false;

    /**
     * Flag indicating whether to block NSFW or adult websites.
     * This is used to determine if the accessibility service is filtering websites.
     */
    public boolean blockNsfwSites = false;

    /**
     * Allowed time for short content consumption, in milliseconds.
     * The value is calculated from seconds provided in the constructor.
     */
    public long allowedShortContentTimeMs = 30 * 60 * 1000L; // Default: 30 minutes

    /**
     * List of website hosts that are blocked.
     */
    public List<String> blockedWebsites = new ArrayList<>(0);

    // Default empty constructor
    public WellBeingSettings() {
    }

    /**
     * Constructs a WellBeingSettings instance from a JSON string.
     *
     * @param jsonString JSON representation of WellBeingSettings.
     */
    public WellBeingSettings(@NonNull String jsonString) {
        if (jsonString.isEmpty()) {
            Log.d("Mindful.WellBeingSettings", "JSON string passed to the constructor is empty");
        } else {
            try {
                // Clean the JSON string and parse it
                jsonString = jsonString.replace("\\", "");
                JSONObject jsonObject = new JSONObject(jsonString.substring(1, jsonString.length() - 1));

                // Deserialize fields
                blockInstaReels = jsonObject.optBoolean("blockInstaReels", false);
                blockYtShorts = jsonObject.optBoolean("blockYtShorts", false);
                blockSnapSpotlight = jsonObject.optBoolean("blockSnapSpotlight", false);
                blockFbReels = jsonObject.optBoolean("blockFbReels", false);
                blockRedditShorts = jsonObject.optBoolean("blockRedditShorts", false);
                blockNsfwSites = jsonObject.optBoolean("blockNsfwSites", false);
                allowedShortContentTimeMs = jsonObject.optInt("allowedShortsTimeSec", 30 * 60) * 1000L;

                // Deserialize blocked websites
                JSONArray websitesJsonArray = jsonObject.optJSONArray("blockedWebsites");
                if (websitesJsonArray != null) {
                    for (int i = 0; i < websitesJsonArray.length(); i++) {
                        blockedWebsites.add(websitesJsonArray.getString(i));
                    }
                }

            } catch (JSONException e) {
                Log.e("Mindful.WellBeingSettings", "Error deserializing JSON to WellBeingSettings model", e);
            }
        }
    }


    /**
     * Creates a deep copy of the current {@link WellBeingSettings} object.
     * <p>
     * This method returns a new {@link WellBeingSettings} instance with the same values
     * as the current object. It ensures that mutable fields, such as {@code blockedWebsites},
     * are copied independently to avoid shared references.
     *
     * @return A new {@link WellBeingSettings} instance with the same field values.
     */
    public WellBeingSettings makeCopy() {
        WellBeingSettings settings = new WellBeingSettings();

        // Copy primitive boolean values
        settings.blockInstaReels = this.blockInstaReels;
        settings.blockYtShorts = this.blockYtShorts;
        settings.blockSnapSpotlight = this.blockSnapSpotlight;
        settings.blockFbReels = this.blockFbReels;
        settings.blockRedditShorts = this.blockRedditShorts;
        settings.blockNsfwSites = this.blockNsfwSites;

        // Copy long value
        settings.allowedShortContentTimeMs = this.allowedShortContentTimeMs;

        // Deep copy the list of blocked websites to ensure independence
        settings.blockedWebsites = new ArrayList<>(this.blockedWebsites);

        return settings;
    }

}
