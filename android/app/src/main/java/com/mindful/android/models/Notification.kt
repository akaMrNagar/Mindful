package com.mindful.android.models

import android.service.notification.StatusBarNotification

/**
 * Represents a notification received from an app.
 */
data class Notification(
    val packageName: String,
    val timeStamp: Long = 0L,
    val title: String = "",
    val content: String = "",
    val isRead: Boolean = false,
) {
    companion object {

        /**
         * Parses [Notification] from a [StatusBarNotification] row.
         */
        fun fromSbn(sbn: StatusBarNotification): Notification {
            val extras = sbn.notification.extras

            return Notification(
                packageName = sbn.packageName,
                timeStamp = sbn.postTime,
                title = extras.getCharSequence(android.app.Notification.EXTRA_TITLE, "").toString()
                    .trim(),
                content = extras.getCharSequence(android.app.Notification.EXTRA_TEXT, "").toString()
                    .trim(),
                isRead = false
            )
        }

    }

    /**
     * Converts the UpcomingNotification object to a map of string keys to object values.
     * The map can be used for serialization or other purposes.
     *
     * @return A map representing the UpcomingNotification object.
     */
    fun toMap(): Map<String, Any> {
        val notificationMap: MutableMap<String, Any> = HashMap()
        notificationMap["packageName"] = packageName
        notificationMap["title"] = title
        notificationMap["content"] = content
        notificationMap["timeStamp"] = timeStamp
        return notificationMap
    }
}
