package com.mindful.android.models

import android.app.Notification.EXTRA_BIG_TEXT
import android.app.Notification.EXTRA_TEXT
import android.app.Notification.EXTRA_TITLE
import android.app.Notification.EXTRA_TITLE_BIG
import android.database.Cursor
import android.service.notification.StatusBarNotification
import com.mindful.android.utils.Extensions.getIntOrDefault
import com.mindful.android.utils.Extensions.getLongOrDefault
import com.mindful.android.utils.Extensions.getStringOrDefault
import org.json.JSONObject

/**
 * Represents a notification received from an app.
 */
data class Notification(
    val id: Int? = null,
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
                title = (extras?.getCharSequence(EXTRA_TITLE)?.toString()
                    ?: extras?.getCharSequence(EXTRA_TITLE_BIG)?.toString()
                    ?: "").trim(),
                content = (extras?.getCharSequence(EXTRA_TEXT)?.toString()
                    ?: extras?.getCharSequence(EXTRA_BIG_TEXT)?.toString()
                    ?: "").trim(),
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
                id = jsonObject.optInt("id", -1).let { if (it > 0) it else null },
                key = jsonObject.optString("key", ""),
                packageName = jsonObject.optString("packageName", ""),
                timeStamp = jsonObject.optLong("timeStamp", 0),
                title = jsonObject.optString("title", ""),
                content = jsonObject.optString("content", ""),
                category = jsonObject.optString("category", "General"),
                isRead = jsonObject.optBoolean("isRead", false),
            )
        }

        /**
         * Parses [Notification] from a Db cursor.
         */
        fun fromCursor(cursor: Cursor): Notification {
            return Notification(
                id = cursor.getIntOrDefault("id", -1).let { if (it > 0) it else null },
                key = cursor.getStringOrDefault("key", ""),
                packageName = cursor.getStringOrDefault("package_name", ""),
                timeStamp = cursor.getLongOrDefault(
                    "time_stamp",
                    0
                ) * 1000L, // convert seconds to ms
                title = cursor.getStringOrDefault("title", ""),
                content = cursor.getStringOrDefault("content", ""),
                category = cursor.getStringOrDefault("category", "General"),
                isRead = cursor.getIntOrDefault("is_read", 0) == 1,
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
