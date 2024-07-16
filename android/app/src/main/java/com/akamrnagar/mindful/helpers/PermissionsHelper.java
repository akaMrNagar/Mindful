package com.akamrnagar.mindful.helpers;

import android.app.NotificationManager;
import android.app.admin.DevicePolicyManager;
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


    public static boolean getAndAskUsageStatesPermission(@NonNull Context context, boolean askPermissionToo) {
        return true;
    }

    public static boolean getAndAskDisplayOverlayPermission(@NonNull Context context, boolean askPermissionToo) {
        return true;
    }

    public static boolean getAndAskBatteryOptimizationPermission(@NonNull Context context, boolean askPermissionToo) {
        return true;
    }

    public static boolean getAndAskDndPermission(@NonNull Context context, boolean askPermissionToo) {
        NotificationManager notificationManager = (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);
        if (notificationManager.isNotificationPolicyAccessGranted()) return true;

        /// Ask for permission
        if (askPermissionToo) ActivityNewTaskHelper.openDoNotDisturbAccessSection(context);

        return false;
    }


    public static boolean revokeAdminPermission(@NonNull Context context) {
        ComponentName componentName = new ComponentName(context, MindfulAdminReceiver.class);
        DevicePolicyManager devicePolicyManager = (DevicePolicyManager) context.getSystemService(Context.DEVICE_POLICY_SERVICE);

        if (devicePolicyManager.isAdminActive(componentName)) {
            devicePolicyManager.removeActiveAdmin(componentName);
        }

        return true;
    }


}
