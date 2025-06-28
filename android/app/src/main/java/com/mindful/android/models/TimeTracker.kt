package com.mindful.android.models

import com.mindful.android.enums.ReminderType
import com.mindful.android.enums.RestrictionType


data class TimeTracker(
    var timeSpent: Long = 0L,
    var lastTime: Long = 0L,
    var maxAllowedInterval: Long = 30L * 1000L
)
