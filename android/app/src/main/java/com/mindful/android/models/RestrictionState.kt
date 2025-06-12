package com.mindful.android.models

import com.mindful.android.enums.ReminderType
import com.mindful.android.enums.RestrictionType


data class RestrictionState(
    /** The type of restriction that this state represents **/
    val type: RestrictionType,

    /** Time left in milliseconds before the restriction starts **/
    val timeLeftMillis: Long = -1,

    /** Total screen time used so far in seconds **/
    val screenTimeUsed: Long = -1L,

    /** Screen time limit or timer in seconds **/
    val screenTimeLimit: Long = -1L,

    /** The type of reminder to show during app usage **/
    val reminderType: ReminderType = ReminderType.NONE,
)