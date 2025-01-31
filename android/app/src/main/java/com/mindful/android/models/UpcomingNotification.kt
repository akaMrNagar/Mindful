package com.mindful.android.models

import android.app.Notification
import android.service.notification.StatusBarNotification


/**
 * Represents an App Notification with its metadata.
 */
data class UpcomingNotification(val sbn: StatusBarNotification) {
    val packageName: String
    val titleText: String
    val contentText: String
    val timeStamp: Long

    init {
        val extras = sbn.notification.extras
        this.packageName = sbn.packageName
        this.timeStamp = sbn.postTime
        this.titleText =
            extras.getCharSequence(Notification.EXTRA_TITLE, "").toString().trim { it <= ' ' }
        this.contentText =
            extras.getCharSequence(Notification.EXTRA_TEXT, "").toString().trim { it <= ' ' }
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
        notificationMap["titleText"] = titleText
        notificationMap["contentText"] = contentText
        notificationMap["timeStamp"] = timeStamp
        return notificationMap
    }
}