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

import com.mindful.android.enums.ShortsPlatformFeatures
import org.json.JSONObject

/**
 * Represents the settings related to user well-being in the application.
 */
data class WellBeingSettings(private val jsonObject: JSONObject) {
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
     * List of blocked short-form features (stored as enum indexes)
     */
    val blockedShortsPlatformFeatures: Set<ShortsPlatformFeatures>

    /**
     * List of website hosts that are blocked including custom nsfw websites.
     */
    val blockedWebsites: Set<String>

    init {

        val blockedFeatures = mutableSetOf<ShortsPlatformFeatures>()
        // Deserialize blocked shorts platform features
        val featuresJsonArray = jsonObject.optJSONArray("blockedShortsPlatformFeatures")
        if (featuresJsonArray != null) {
            for (i in 0 until featuresJsonArray.length()) {
                featuresJsonArray.optInt(i).let {
                    blockedFeatures.add(
                        ShortsPlatformFeatures.values()[i]
                    )
                }
            }
        }

        this.blockedShortsPlatformFeatures = blockedFeatures


        val blockedWebsites = mutableSetOf<String>()

        // Deserialize blocked websites
        val websitesJsonArray = jsonObject.optJSONArray("blockedWebsites")
        if (websitesJsonArray != null) {
            for (i in 0 until websitesJsonArray.length()) {
                blockedWebsites.add(websitesJsonArray.getString(i))
            }
        }

        // Deserialize nsfw websites
        val nsfwSitesJsonArray = jsonObject.optJSONArray("nsfwWebsites")
        if (nsfwSitesJsonArray != null) {
            for (i in 0 until nsfwSitesJsonArray.length()) {
                blockedWebsites.add(nsfwSitesJsonArray.getString(i))
            }
        }

        this.blockedWebsites = blockedWebsites
    }
}
