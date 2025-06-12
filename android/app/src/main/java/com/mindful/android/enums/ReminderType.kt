package com.mindful.android.enums

enum class ReminderType {
    NONE,
    TOAST,
    NOTIFICATION,
    BOTTOM_SHEET;

    companion object {
        fun fromName(name: String): ReminderType {
            return when (name) {
                "none" -> NONE
                "toast" -> TOAST
                "notification" -> NOTIFICATION
                "bottomSheet" -> BOTTOM_SHEET
                else -> NONE
            }
        }
    }
}