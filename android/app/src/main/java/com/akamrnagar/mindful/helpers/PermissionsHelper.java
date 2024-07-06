package com.akamrnagar.mindful.helpers;

import android.app.NotificationManager;
import android.content.Context;
import android.content.Intent;
import android.provider.Settings;

import androidx.annotation.NonNull;

public class PermissionsHelper {

    public static boolean getAndAskUsageStatesPermission(@NonNull Context context) {
        return true;
    }

    public static boolean getAndAskDisplayOverlayPermission() {
        return true;
    }

    public static boolean getAndAskBatteryOptimizationPermission() {
        return true;
    }

    public static boolean getAndAskDndPermission(@NonNull Context context) {
        NotificationManager notificationManager = (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);
        if (notificationManager.isNotificationPolicyAccessGranted()) return true;

        /// Ask for permission
        Intent intent = new Intent(Settings.ACTION_NOTIFICATION_POLICY_ACCESS_SETTINGS);
        context.startActivity(intent);
        return false;
    }


}
