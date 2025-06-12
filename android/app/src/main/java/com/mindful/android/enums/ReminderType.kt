package com.mindful.android.enums

enum class ReminderType {
    NONE,
    TOAST,
    NOTIFICATION,
    MODAL_SHEET;

    companion object {
        fun fromName(name: String): ReminderType {
            return when (name) {
                "none" -> NONE
                "toast" -> TOAST
                "notification" -> NOTIFICATION
                "modalSheet" -> MODAL_SHEET
                else -> NONE
            }
        }
    }
}