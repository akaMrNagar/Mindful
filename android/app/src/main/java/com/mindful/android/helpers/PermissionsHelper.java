package com.mindful.android.helpers;

import android.app.NotificationManager;
import android.app.admin.DevicePolicyManager;
import android.app.usage.UsageStatsManager;
import android.content.ComponentName;
import android.content.Context;

import androidx.annotation.NonNull;

import com.mindful.android.receivers.MindfulAdminReceiver;
import com.mindful.android.services.MindfulAccessibilityService;
import com.mindful.android.utils.Utils;

/**
 * PermissionsHelper provides utility methods for managing and requesting necessary permissions
 * for the application. It includes methods to check and request permissions for accessibility,
 * device administration, usage access, and Do Not Disturb (DND) access.
 */
public class PermissionsHelper {

    /**
     * Checks if the accessibility permission is granted and optionally asks for it if not granted.
     *
     * @param context The application context used to check permissions and start activities.
     * @param askPermissionToo Whether to prompt the user to enable accessibility permission if not granted.
     * @return True if accessibility permission is granted, false otherwise.
     */
    public static boolean getAndAskAccessibilityPermission(@NonNull Context context, boolean askPermissionToo) {
        if (Utils.isServiceRunning(context, MindfulAccessibilityService.class.getName())) {
            return true;
        }

        if (askPermissionToo) {
            ActivityNewTaskHelper.openMindfulAccessibilitySection(context);
        }
        return false;
    }

    /**
     * Checks if the device administration permission is granted and optionally asks for it if not granted.
     *
     * @param context The application context used to check permissions and start activities.
     * @param askPermissionToo Whether to prompt the user to enable device administration permission if not granted.
     * @return True if device administration permission is granted, false otherwise.
     */
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

    /**
     * Checks if the usage access permission is granted and optionally asks for it if not granted.
     *
     * @param context The application context used to check permissions and start activities.
     * @param askPermissionToo Whether to prompt the user to enable usage access permission if not granted.
     * @return True if usage access permission is granted, false otherwise.
     */
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

    /**
     * Checks if the Do Not Disturb (DND) permission is granted and optionally asks for it if not granted.
     *
     * @param context The application context used to check permissions and start activities.
     * @param askPermissionToo Whether to prompt the user to enable DND permission if not granted.
     * @return True if DND permission is granted, false otherwise.
     */
    public static boolean getAndAskDndPermission(@NonNull Context context, boolean askPermissionToo) {
        NotificationManager notificationManager = (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);
        if (notificationManager.isNotificationPolicyAccessGranted()) return true;

        if (askPermissionToo) {
            ActivityNewTaskHelper.openDeviceDoNotDisturbAccessSection(context);
        }
        return false;
    }
}
