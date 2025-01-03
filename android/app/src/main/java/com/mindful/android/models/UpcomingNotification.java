package com.mindful.android.models;


import android.app.Notification;
import android.os.Bundle;
import android.service.notification.StatusBarNotification;

import androidx.annotation.NonNull;

import java.util.HashMap;
import java.util.Map;

/**
 * Represents an App Notification with its metadata.
 */
public class UpcomingNotification {
    public final String packageName;
    public final String titleText;
    public final String contentText;
    public final long timeStamp;

    /**
     * Constructor that initializes the object using StatusBarNotification
     *
     * @param sbn Status Bar Notification object
     */
    public UpcomingNotification(@NonNull StatusBarNotification sbn) {
        Bundle extras = sbn.getNotification().extras;
        this.packageName = sbn.getPackageName();
        this.timeStamp = sbn.getPostTime();
        this.titleText = extras.getCharSequence(Notification.EXTRA_TITLE, "").toString().trim();
        this.contentText = extras.getCharSequence(Notification.EXTRA_TEXT, "").toString().trim();
    }

    /**
     * Converts the UpcomingNotification object to a map of string keys to object values.
     * The map can be used for serialization or other purposes.
     *
     * @return A map representing the UpcomingNotification object.
     */
    public Map<String, Object> toMap() {
        Map<String, Object> notificationMap = new HashMap<>();
        notificationMap.put("packageName", packageName);
        notificationMap.put("titleText", titleText);
        notificationMap.put("contentText", contentText);
        notificationMap.put("timeStamp", timeStamp);
        return notificationMap;
    }
}