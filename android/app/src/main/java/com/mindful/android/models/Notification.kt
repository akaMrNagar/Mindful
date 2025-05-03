package com.mindful.android.models

import android.app.Notification.EXTRA_BIG_TEXT
import android.app.Notification.EXTRA_TEXT
import android.app.Notification.EXTRA_TITLE
import android.service.notification.StatusBarNotification
import org.json.JSONObject

/**
 * Represents a notification received from an app.
 */
data class Notification(
    val key: String = "",
    val packageName: String = "",
    val timeStamp: Long = 0L,
    val title: String = "",
    val content: String = "",
    val category: String = "",
    val isRead: Boolean = false,
) {
    companion object {

        /**
         * Parses [Notification] from a [StatusBarNotification].
         */
        fun fromSbn(sbn: StatusBarNotification): Notification {
            val extras = sbn.notification.extras

            return Notification(
                key = sbn.key,
                packageName = sbn.packageName,
                timeStamp = sbn.postTime,
                title = (extras?.getString(EXTRA_TITLE) ?: "").trim(),
                content = (extras?.getString(EXTRA_TEXT)
                    ?: extras?.getString(EXTRA_BIG_TEXT) ?: "").trim(),
                category = parseNotificationCategory(sbn.notification.category),
                isRead = false,
            )
        }

        /**
         * Parses [Notification] from a JSON string.
         */
        fun fromJson(json: String): Notification {
            val jsonObject = JSONObject(json)

            return Notification(
                key = jsonObject.optString("key", ""),
                packageName = jsonObject.optString("package_name", ""),
                timeStamp = jsonObject.optLong("time_stamp", 0),
                title = jsonObject.optString("title", ""),
                content = jsonObject.optString("content", ""),
                category = jsonObject.optString("category", "General"),
                isRead = jsonObject.optBoolean("is_read", false),
            )
        }


        private fun parseNotificationCategory(category: String?): String {
            return when (category) {
                android.app.Notification.CATEGORY_STOPWATCH -> "Stopwatch"
                android.app.Notification.CATEGORY_ALARM -> "Alarm"
                android.app.Notification.CATEGORY_REMINDER -> "Reminder"
                android.app.Notification.CATEGORY_EVENT -> "Event"
                android.app.Notification.CATEGORY_LOCATION_SHARING -> "Location Sharing"
                android.app.Notification.CATEGORY_SERVICE -> "Service"
                android.app.Notification.CATEGORY_TRANSPORT -> "Transport"
                android.app.Notification.CATEGORY_CALL -> "Call"
                android.app.Notification.CATEGORY_MISSED_CALL -> "Missed Call"
                android.app.Notification.CATEGORY_EMAIL -> "Email"
                android.app.Notification.CATEGORY_MESSAGE -> "Message"
                android.app.Notification.CATEGORY_SOCIAL -> "Social"
                android.app.Notification.CATEGORY_WORKOUT -> "Workout"
                android.app.Notification.CATEGORY_PROMO -> "Promotional"
                android.app.Notification.CATEGORY_PROGRESS -> "Progress"
                android.app.Notification.CATEGORY_RECOMMENDATION -> "Recommendation"
                else -> "General"
            }
        }
    }
}
