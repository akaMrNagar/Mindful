package com.mindful.android.models.database

data class AppRestriction(
    /**
     * Package name of the related app
     */
    val appPackage: String,

    /**
     * The timer set for the app in SECONDS
     */
    val timerSec: Int,

    /**
     * The number of times user can launch this app
     */
    val launchLimit: Int,

    /**
     * [TimeOfDay] in minutes from where the active period will start.
     * It is stored as total minutes.
     */
    val activePeriodStart: Int,

    /**
     * Total duration of active period from start to end in MINUTES
     */
    val periodDurationInMins: Int,

    /**
     * Flag denoting if this app can access internet or not
     */
    val canAccessInternet: Boolean,

    /**
     * ID of the [RestrictionGroup] this app is associated with or NULL
     */
    val associatedGroupId: Int?,
)
