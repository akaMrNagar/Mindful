package com.akamrnagar.mindful.helpers;

import android.Manifest;
import android.app.Activity;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.content.Context;
import android.content.pm.PackageManager;
import android.os.Build;

import androidx.annotation.NonNull;
import androidx.core.app.ActivityCompat;

public class NotificationHelper {
    // Channels
    private static final String NOTIFICATION_IMPORTANT_CHANNEL_NAME = "Important";
    private static final String NOTIFICATION_OTHER_CHANNEL_NAME = "Other";
    public static final String NOTIFICATION_IMPORTANT_CHANNEL_ID = "mindful.notification.channel.important";
    public static final String NOTIFICATION_OTHER_CHANNEL_ID = "mindful.notification.channel.other";

    public static void registerNotificationGroupAndChannels(Context context) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            // Channels
            NotificationChannel importantChannel = new NotificationChannel(NOTIFICATION_IMPORTANT_CHANNEL_ID, NOTIFICATION_IMPORTANT_CHANNEL_NAME, NotificationManager.IMPORTANCE_HIGH);
            NotificationChannel otherChannel = new NotificationChannel(NOTIFICATION_OTHER_CHANNEL_ID, NOTIFICATION_OTHER_CHANNEL_NAME, NotificationManager.IMPORTANCE_MIN);
            importantChannel.setDescription("These notifications include crucial reminders and updates, designed to help you stay on track.");
            otherChannel.setDescription("These are non-critical updates. They can be disabled but are included to comply with Android requirements.");


            // Register
            NotificationManager notificationManager = (NotificationManager) context.getSystemService(NotificationManager.class);
            notificationManager.createNotificationChannel(otherChannel);
            notificationManager.createNotificationChannel(importantChannel);
        }
    }

    public static boolean getAndAskNotificationPermission(@NonNull Context context, @NonNull Activity activity, boolean askPermissionToo) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            final int status = context.checkSelfPermission(Manifest.permission.POST_NOTIFICATIONS);
            if (status == PackageManager.PERMISSION_GRANTED) {
                return true;
            }
        } else {
            NotificationManager notificationManager =
                    (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);
            if (notificationManager.areNotificationsEnabled()) {
                return true;
            }
        }

        if (askPermissionToo) {
            if (Build.VERSION.SDK_INT < Build.VERSION_CODES.TIRAMISU) {
                ActivityNewTaskHelper.openMindfulNotificationSection(context);
            } else {
                int count = SharedPrefsHelper.fetchNotificationAskCount(context);
                if (count < 2) {
                    ActivityCompat.requestPermissions(
                            activity,
                            new String[]{Manifest.permission.POST_NOTIFICATIONS},
                            0
                    );
                } else {
                    ActivityNewTaskHelper.openMindfulNotificationSection(context);
                }

                SharedPrefsHelper.storeNotificationAskCount(context, count + 1);
            }
        }
        return false;
    }

}
