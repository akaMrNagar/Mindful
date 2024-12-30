/*
 *
 *  *
 *  *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *  *
 *  *  * This source code is licensed under the GPL-2.0 license license found in the
 *  *  * LICENSE file in the root directory of this source tree.
 *  *
 *
 */

package com.mindful.android.helpers;

import android.Manifest;
import android.app.Activity;
import android.app.AlarmManager;
import android.app.NotificationManager;
import android.app.admin.DevicePolicyManager;
import android.app.usage.UsageStatsManager;
import android.content.ComponentName;
import android.content.Context;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.PowerManager;
import android.provider.Settings;

import androidx.annotation.NonNull;
import androidx.core.app.ActivityCompat;
import androidx.core.app.NotificationManagerCompat;

import com.mindful.android.receivers.DeviceAdminReceiver;
import com.mindful.android.services.MindfulAccessibilityService;
import com.mindful.android.services.MindfulNotificationListenerService;
import com.mindful.android.utils.Utils;

import java.util.Set;

/**
 * PermissionsHelper provides utility methods for managing and requesting necessary permissions
 * for the application. It includes methods to check and request permissions for accessibility,
 * usage access, and Do Not Disturb (DND) access.
 */
public class PermissionsHelper {
    /**
     * Checks if the device administration permission is granted and optionally asks for it if not granted.
     *
     * @param context          The application context used to check permissions and start activities.
     * @param askPermissionToo Whether to prompt the user to enable device administration permission if not granted.
     * @return True if device administration permission is granted, false otherwise.
     */
    public static boolean getAndAskAdminPermission(@NonNull Context context, boolean askPermissionToo) {
        ComponentName componentName = new ComponentName(context, DeviceAdminReceiver.class);
        DevicePolicyManager devicePolicyManager = (DevicePolicyManager) context.getSystemService(Context.DEVICE_POLICY_SERVICE);

        if (devicePolicyManager.isAdminActive(componentName)) {
            return true;
        }

        if (askPermissionToo) {
            NewActivitiesLaunchHelper.openMindfulDeviceAdminSection(context, componentName);
        }
        return false;
    }

    /**
     * Checks if the accessibility permission is granted and optionally asks for it if not granted.
     *
     * @param context          The application context used to check permissions and start activities.
     * @param askPermissionToo Whether to prompt the user to enable accessibility permission if not granted.
     * @return True if accessibility permission is granted, false otherwise.
     */
    public static boolean getAndAskAccessibilityPermission(@NonNull Context context, boolean askPermissionToo) {
        if (Utils.isServiceRunning(context, MindfulAccessibilityService.class.getName())) {
            return true;
        }

        if (askPermissionToo) {
            NewActivitiesLaunchHelper.openMindfulAccessibilitySection(context);
        }
        return false;
    }

    /**
     * Checks if the usage access permission is granted and optionally asks for it if not granted.
     *
     * @param context          The application context used to check permissions and start activities.
     * @param askPermissionToo Whether to prompt the user to enable usage access permission if not granted.
     * @return True if usage access permission is granted, false otherwise.
     */
    public static boolean getAndAskUsageAccessPermission(@NonNull Context context, boolean askPermissionToo) {
        UsageStatsManager usageStatsManager = (UsageStatsManager) context.getSystemService(Context.USAGE_STATS_SERVICE);
        long now = System.currentTimeMillis();
        boolean haveUsage = !usageStatsManager.queryAndAggregateUsageStats(now - 24 * 60 * 60 * 1000, now).isEmpty();

        if (haveUsage) return true;
        if (askPermissionToo) {
            NewActivitiesLaunchHelper.openMindfulUsageAccessSection(context);
        }

        return false;
    }


    /**
     * Checks if the Display Over Other Apps permission is granted and optionally asks for it if not granted.
     *
     * @param context          The application context used to check permissions and start activities.
     * @param askPermissionToo Whether to prompt the user to enable Display Over Other Apps permission if not granted.
     * @return True if Display Over Other Apps permission is granted, false otherwise.
     */
    public static boolean getAndAskDisplayOverlayPermission(@NonNull Context context, boolean askPermissionToo) {
        if (Settings.canDrawOverlays(context)) return true;

        if (askPermissionToo) {
            NewActivitiesLaunchHelper.openMindfulDisplayOverlaySection(context);
        }
        return false;
    }

    /**
     * Checks if the Set Exact Alarm permission is granted and optionally asks for it if not granted.
     *
     * @param context          The application context used to check permissions and start activities.
     * @param askPermissionToo Whether to prompt the user to enable Set Exact Alarm permission if not granted.
     * @return True if Set Exact Alarm permission is granted, false otherwise.
     */
    public static boolean getAndAskExactAlarmPermission(@NonNull Context context, boolean askPermissionToo) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.S) return true;

        AlarmManager alarmManager = (AlarmManager) context.getSystemService(Context.ALARM_SERVICE);
        if (alarmManager.canScheduleExactAlarms()) return true;

        if (askPermissionToo) {
            NewActivitiesLaunchHelper.openMindfulExactAlarmSection(context);
        }
        return false;
    }

    /**
     * Checks if the Ignore Battery Optimization permission is granted and optionally asks for it if not granted.
     *
     * @param context          The application context used to check permissions and start activities.
     * @param askPermissionToo Whether to prompt the user to enable Ignore Battery Optimization permission if not granted.
     * @return True if Ignore Battery Optimization permission is granted, false otherwise.
     */
    public static boolean getAndAskIgnoreBatteryOptimizationPermission(@NonNull Context context, boolean askPermissionToo) {
        PowerManager powerManager = (PowerManager) context.getSystemService(Context.POWER_SERVICE);
        if (powerManager.isIgnoringBatteryOptimizations(context.getPackageName())) return true;

        if (askPermissionToo) {
            NewActivitiesLaunchHelper.openMindfulIgnoreBatteryOptimizationSection(context);
        }
        return false;
    }

    /**
     * Checks if notification permissions are granted and optionally asks for it if not granted.
     *
     * @param context          The application context used to check notification permissions.
     * @param activity         The activity used to request notification permissions if needed.
     * @param askPermissionToo Whether to request notification permission if not already granted.
     * @return True if notification permissions are granted, false otherwise.
     */
    public static boolean getAndAskNotificationPermission(@NonNull Context context, @NonNull Activity activity, boolean askPermissionToo) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            int status = context.checkSelfPermission(Manifest.permission.POST_NOTIFICATIONS);
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
                NewActivitiesLaunchHelper.openMindfulNotificationSection(context);
            } else {
                int count = SharedPrefsHelper.getSetNotificationAskCount(context, null);
                if (count < 2) {
                    ActivityCompat.requestPermissions(
                            activity,
                            new String[]{Manifest.permission.POST_NOTIFICATIONS},
                            0
                    );
                } else {
                    NewActivitiesLaunchHelper.openMindfulNotificationSection(context);
                }

                SharedPrefsHelper.getSetNotificationAskCount(context, count + 1);
            }
        }
        return false;
    }

    /**
     * Checks if the Do Not Disturb (DND) permission is granted and optionally asks for it if not granted.
     *
     * @param context          The application context used to check permissions and start activities.
     * @param askPermissionToo Whether to prompt the user to enable DND permission if not granted.
     * @return True if DND permission is granted, false otherwise.
     */
    public static boolean getAndAskDndPermission(@NonNull Context context, boolean askPermissionToo) {
        NotificationManager notificationManager = (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);
        if (notificationManager.isNotificationPolicyAccessGranted()) return true;

        if (askPermissionToo) {
            NewActivitiesLaunchHelper.openDeviceDoNotDisturbAccessSection(context);
        }
        return false;
    }

    /**
     * Checks if the Notification Access permission is granted and optionally asks for it if not granted.
     *
     * @param context          The application context used to check permissions and start activities.
     * @param askPermissionToo Whether to prompt the user to enable Notification Access permission if not granted.
     * @return True if Notification Access permission is granted, false otherwise.
     */
    public static boolean getAndAskNotificationAccessPermission(@NonNull Context context, boolean askPermissionToo) {
        Set<String> enabledPackages = NotificationManagerCompat.getEnabledListenerPackages(context);
        if (enabledPackages.contains(context.getPackageName())) return true;

        if (askPermissionToo) {
            NewActivitiesLaunchHelper.openNotificationAccessSection(context);
        }
        return false;
    }
}
