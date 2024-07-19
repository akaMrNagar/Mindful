package com.akamrnagar.mindful.helpers;

import android.app.NotificationManager;
import android.app.admin.DevicePolicyManager;
import android.app.usage.UsageStatsManager;
import android.content.ComponentName;
import android.content.Context;

import androidx.annotation.NonNull;

import com.akamrnagar.mindful.receivers.MindfulAdminReceiver;
import com.akamrnagar.mindful.services.MindfulAccessibilityService;

public class PermissionsHelper {

    public static boolean getAndAskAccessibilityPermission(@NonNull Context context, boolean askPermissionToo) {
        if (ServicesHelper.isServiceRunning(context, MindfulAccessibilityService.class.getName())) {
            return true;
        }

        if (askPermissionToo) ActivityNewTaskHelper.openMindfulAccessibilitySection(context);
        return false;
    }

    public static boolean getAndAskAdminPermission(@NonNull Context context, boolean askPermissionToo) {
        ComponentName componentName = new ComponentName(context, MindfulAdminReceiver.class);
        DevicePolicyManager devicePolicyManager = (DevicePolicyManager) context.getSystemService(Context.DEVICE_POLICY_SERVICE);

        if (devicePolicyManager.isAdminActive(componentName)) {
            return true;
        }
        if (askPermissionToo) {
            ActivityNewTaskHelper.openMindfulDeviceAdminSection(context, componentName);
        }
        return false;
    }


    public static boolean getAndAskUsageAccessPermission(@NonNull Context context, boolean askPermissionToo) {
        UsageStatsManager usageStatsManager = (UsageStatsManager) context.getSystemService(Context.USAGE_STATS_SERVICE);
        long now = System.currentTimeMillis();
        boolean haveUsage = !usageStatsManager.queryAndAggregateUsageStats(now - 24 * 60 * 60 * 1000, now).isEmpty();

        if (haveUsage) return true;
        if (askPermissionToo) {
            ActivityNewTaskHelper.openDeviceUsageAccessSection(context);
        }

        return false;
    }

    public static boolean getAndAskDndPermission(@NonNull Context context, boolean askPermissionToo) {
        NotificationManager notificationManager = (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);
        if (notificationManager.isNotificationPolicyAccessGranted()) return true;

        /// Ask for permission
        if (askPermissionToo) ActivityNewTaskHelper.openDoNotDisturbAccessSection(context);
        return false;
    }
}
