package com.mindful.android.models;


import android.app.Notification;
import android.app.PendingIntent;
import android.graphics.drawable.Icon;

import androidx.annotation.NonNull;

public class PendingNotification {
    public final String packageName;
    public final String titleText;
    public final String contentText;
    public final Icon largeIcon;
    public final PendingIntent pendingIntent;

    // Constructor that initializes the object using StatusBarNotification
    public PendingNotification(String packageName, String titleText, String contentText, Icon largeIcon, PendingIntent contentIntent) {
        this.packageName = packageName;
        this.titleText = titleText;
        this.contentText = contentText;
        this.largeIcon = largeIcon;
        this.pendingIntent = contentIntent;
    }
}