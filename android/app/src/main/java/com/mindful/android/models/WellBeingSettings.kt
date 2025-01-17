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

/**
 * Represents the settings related to user well-being in the application.
 */
class WellBeingSettings {
    /**
     * Flag indicating whether to block Instagram Reels.
     */
    var blockInstaReels: Boolean = false

    /**
     * Flag indicating whether to block YouTube Shorts.
     */
    var blockYtShorts: Boolean = false

    /**
     * Flag indicating whether to block Snapchat Spotlight.
     */
    var blockSnapSpotlight: Boolean = false

    /**
     * Flag indicating whether to block Facebook Reels.
     */
    var blockFbReels: Boolean = false

    /**
     * Flag indicating whether to block Reddit Shorts.
     */
    var blockRedditShorts: Boolean = false

    /**
     * Flag indicating whether to block NSFW or adult websites.
     * This is used to determine if the accessibility service is filtering websites.
     */
    var blockNsfwSites: Boolean = false

    /**
     * Allowed time for short content consumption, in milliseconds.
     * The value is calculated from seconds provided in the constructor.
     */
    var allowedShortContentTimeMs: Long = 30 * 60 * 1000L // Default: 30 minutes

    /**
     * List of website hosts that are blocked.
     */
    var blockedWebsites: MutableList<String> = ArrayList(0)

    // Default empty constructor
    constructor()

    /**
     * Constructs a WellBeingSettings instance from a JSON string.
     *
     * @param jsonString JSON representation of WellBeingSettings.
     */
    constructor(jsonString: String) {
        if (jsonString.isEmpty()) {
            Log.d("Mindful.WellBeingSettings", "JSON string passed to the constructor is empty")
        } else {
            try {
                val jsonObject = JSONObject(jsonString)

                // Deserialize fields
                this.blockInstaReels = jsonObject.optBoolean("blockInstaReels", false)
                this.blockYtShorts = jsonObject.optBoolean("blockYtShorts", false)
                this.blockSnapSpotlight = jsonObject.optBoolean("blockSnapSpotlight", false)
                this.blockFbReels = jsonObject.optBoolean("blockFbReels", false)
                this.blockRedditShorts = jsonObject.optBoolean("blockRedditShorts", false)
                this.blockNsfwSites = jsonObject.optBoolean("blockNsfwSites", false)
                this.allowedShortContentTimeMs =
                    jsonObject.optInt("allowedShortsTimeSec", 30 * 60) * 1000L

                // Deserialize blocked websites
                val websitesJsonArray = jsonObject.optJSONArray("blockedWebsites")
                if (websitesJsonArray != null) {
                    for (i in 0 until websitesJsonArray.length()) {
                        blockedWebsites.add(websitesJsonArray.getString(i))
                    }
                }
            } catch (e: JSONException) {
                Log.e(
                    "Mindful.WellBeingSettings",
                    "Error deserializing JSON to WellBeingSettings model",
                    e
                )
            }
        }
    }


    /**
     * Creates a deep copy of the current [WellBeingSettings] object.
     *
     *
     * This method returns a new [WellBeingSettings] instance with the same values
     * as the current object. It ensures that mutable fields, such as `blockedWebsites`,
     * are copied independently to avoid shared references.
     *
     * @return A new [WellBeingSettings] instance with the same field values.
     */
    fun makeCopy(): WellBeingSettings {
        val settings = WellBeingSettings()

        // Copy primitive boolean values
        settings.blockInstaReels = this.blockInstaReels
        settings.blockYtShorts = this.blockYtShorts
        settings.blockSnapSpotlight = this.blockSnapSpotlight
        settings.blockFbReels = this.blockFbReels
        settings.blockRedditShorts = this.blockRedditShorts
        settings.blockNsfwSites = this.blockNsfwSites

        // Copy long value
        settings.allowedShortContentTimeMs = this.allowedShortContentTimeMs

        // Deep copy the list of blocked websites to ensure independence
        settings.blockedWebsites = ArrayList(this.blockedWebsites)

        return settings
    }
}
