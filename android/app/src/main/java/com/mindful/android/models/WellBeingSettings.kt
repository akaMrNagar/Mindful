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

import org.json.JSONObject

/**
 * Represents the settings related to user well-being in the application.
 */
data class WellBeingSettings(private val jsonObject: JSONObject) {
    /**
     * Flag indicating whether to block Instagram Reels.
     */
    val blockInstaReels: Boolean = jsonObject.optBoolean("blockInstaReels", false)

    /**
     * Flag indicating whether to block YouTube Shorts.
     */
    val blockYtShorts: Boolean = jsonObject.optBoolean("blockYtShorts", false)

    /**
     * Flag indicating whether to block Snapchat Spotlight.
     */
    val blockSnapSpotlight: Boolean = jsonObject.optBoolean("blockSnapSpotlight", false)

    /**
     * Flag indicating whether to block Facebook Reels.
     */
    val blockFbReels: Boolean = jsonObject.optBoolean("blockFbReels", false)

    /**
     * Flag indicating whether to block Reddit Shorts.
     */
    val blockRedditShorts: Boolean = jsonObject.optBoolean("blockRedditShorts", false)

    /**
     * Flag indicating whether to block NSFW or adult websites.
     * This is used to determine if the accessibility service is filtering websites.
     */
    val blockNsfwSites: Boolean = jsonObject.optBoolean("blockNsfwSites", false)

    /**
     * Allowed time for short content consumption, in milliseconds.
     * The value is calculated from seconds provided in the constructor.
     */
    val allowedShortContentTimeMs: Long =
        jsonObject.optInt("allowedShortsTimeSec", 30 * 60) * 1000L

    /**
     * List of website hosts that are blocked.
     */
    val blockedWebsites: MutableList<String>


    init {
        val allWebsites = mutableListOf<String>()

        // Deserialize blocked websites
        val websitesJsonArray = jsonObject.optJSONArray("blockedWebsites")
        if (websitesJsonArray != null) {
            for (i in 0 until websitesJsonArray.length()) {
                allWebsites.add(websitesJsonArray.getString(i))
            }
        }

        // Deserialize nsfw websites
        val nsfwSitesJsonArray = jsonObject.optJSONArray("nsfwWebsites")
        if (nsfwSitesJsonArray != null) {
            for (i in 0 until nsfwSitesJsonArray.length()) {
                allWebsites.add(nsfwSitesJsonArray.getString(i))
            }
        }


        this.blockedWebsites = allWebsites
    }
}
