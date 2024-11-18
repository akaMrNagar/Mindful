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
import androidx.annotation.Nullable;

import org.json.JSONException;
import org.json.JSONObject;

public class AppRestrictions {

    /**
     * Package name of the related app
     */
    public final String appPackage;

    /**
     * The timer set for the app in SECONDS
     */
    public final int timerSec;

    /**
     * The number of times user can launch this app
     */
    public final int launchLimit;

    /**
     * Flag denoting if this app can access internet or not
     */
    public final boolean canAccessInternet;

    /**
     * The interval between each usage alert in SECONDS
     */
    public final int alertInterval;

    /**
     * Whether to alert user by dialog if false user will be alerted by notification
     */
    public final boolean alertByDialog;

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
     * ID of the [RestrictionGroup] this app is associated with or NULL
     */
    @Nullable
    public final Integer associatedGroupId;


    /**
     * Constructor to initialize from JSON.
     *
     * @param jsonObject the JSON object containing app restriction data.
     */
    public AppRestrictions(@NonNull JSONObject jsonObject) throws JSONException {
        this.appPackage = jsonObject.optString("appPackage", "");
        this.timerSec = jsonObject.optInt("timerSec", 0);
        this.launchLimit = jsonObject.optInt("launchLimit", 0);
        this.canAccessInternet = jsonObject.optBoolean("canAccessInternet", true);
        this.alertInterval = jsonObject.optInt("alertInterval", 0);
        this.alertByDialog = jsonObject.optBoolean("alertByDialog", false);
        this.activePeriodStart = jsonObject.optInt("activePeriodStart", 0);
        this.activePeriodEnd = jsonObject.optInt("activePeriodEnd", 0);
        this.periodDurationInMins = jsonObject.optInt("periodDurationInMins", 0);

        // Handles nullable Integer field for associatedGroupId
        if (jsonObject.has("associatedGroupId") && !jsonObject.isNull("associatedGroupId")) {
            this.associatedGroupId = jsonObject.optInt("associatedGroupId");
        } else {
            this.associatedGroupId = null;
        }
    }


    @NonNull
    @Override
    public String toString() {
        return "AppRestrictions{" +
                "appPackage='" + appPackage + '\'' +
                ", timerSec=" + timerSec +
                ", launchLimit=" + launchLimit +
                ", alertInterval=" + alertInterval +
                ", alertByDialog=" + alertByDialog +
                ", associatedGroupId=" + associatedGroupId +
                '}';
    }

}
