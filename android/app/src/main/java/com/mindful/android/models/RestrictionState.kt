package com.mindful.android.models

data class RestrictionState(
    /** The message regarding the state and applied limit   **/
    val message: String,

    /** The future time in ms when the limit will be exhausted   **/
    val expirationFutureMs: Long,

    /** The total screen time used in SECONDS   **/
    val usedScreenTime: Long = -1L,

    /** The timer limit for screen time in SECONDS   **/
    val totalScreenTimer: Long = -1L,
)