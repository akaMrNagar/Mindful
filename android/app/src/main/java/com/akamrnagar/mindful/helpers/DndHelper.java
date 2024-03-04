package com.akamrnagar.mindful.helpers;

import android.app.NotificationManager;
import android.content.Context;
import android.content.Intent;
import android.provider.Settings;

import androidx.annotation.NonNull;

public class DndHelper {

    // Method to enable DND mode
    public static void setDndMode(@NonNull Context context, boolean enable) {
        NotificationManager notificationManager = (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);
        if (notificationManager.isNotificationPolicyAccessGranted()) {
            // Set the interruption filter mode to DND
            notificationManager.setInterruptionFilter(enable ? NotificationManager.INTERRUPTION_FILTER_PRIORITY : NotificationManager.INTERRUPTION_FILTER_ALL);
        } else {
            requestDndPermission(context);
        }
    }

    // Method to request DND permission from the user
    private static void requestDndPermission(@NonNull Context context) {
        Intent intent = new Intent(Settings.ACTION_NOTIFICATION_POLICY_ACCESS_SETTINGS);
        context.startActivity(intent);
    }

}
