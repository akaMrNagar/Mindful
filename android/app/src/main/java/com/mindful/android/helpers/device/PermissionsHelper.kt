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
package com.mindful.android.helpers.device

import android.Manifest
import android.annotation.SuppressLint
import android.app.Activity
import android.app.AlarmManager
import android.app.NotificationManager
import android.app.admin.DevicePolicyManager
import android.app.usage.UsageStatsManager
import android.content.ActivityNotFoundException
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import android.os.PowerManager
import android.provider.Settings
import android.util.Log
import android.widget.Toast
import androidx.core.app.ActivityCompat
import androidx.core.app.NotificationManagerCompat
import com.mindful.android.R
import com.mindful.android.helpers.storage.SharedPrefsHelper
import com.mindful.android.receivers.DeviceAdminReceiver
import com.mindful.android.services.accessibility.MindfulAccessibilityService
import com.mindful.android.utils.AppConstants
import com.mindful.android.utils.Utils

/**
 * PermissionsHelper provides utility methods for managing and requesting necessary permissions
 * for the application. It includes methods to check and request permissions for accessibility,
 * usage access, and Do Not Disturb (DND) access.
 */
object PermissionsHelper {
    private const val TAG = "Mindful.PermissionsHelper"

    /**
     * Checks if the device administration permission is granted and optionally asks for it if not granted.
     *
     * @param context          The application context used to check permissions and start activities.
     * @param askPermissionToo Whether to prompt the user to enable device administration permission if not granted.
     * @return True if device administration permission is granted, false otherwise.
     */
    fun getAndAskAdminPermission(context: Context, askPermissionToo: Boolean): Boolean {
        val componentName = ComponentName(context, DeviceAdminReceiver::class.java)
        val devicePolicyManager =
            context.getSystemService(Context.DEVICE_POLICY_SERVICE) as DevicePolicyManager

        if (devicePolicyManager.isAdminActive(componentName)) {
            return true
        }

        if (askPermissionToo) {
            try {
                val intent = Intent(DevicePolicyManager.ACTION_ADD_DEVICE_ADMIN)
                    .putExtra(DevicePolicyManager.EXTRA_DEVICE_ADMIN, componentName)
                    .putExtra(
                        DevicePolicyManager.EXTRA_ADD_EXPLANATION,
                        R.string.admin_description
                    )
                context.startActivity(intent)
            } catch (e: ActivityNotFoundException) {
                Log.e(TAG, "getAndAskAdminPermission: Unable to open device ADMIN settings", e)
            }
        }
        return false
    }

    /**
     * Checks if the accessibility permission is granted and optionally asks for it if not granted.
     *
     * @param context          The application context used to check permissions and start activities.
     * @param askPermissionToo Whether to prompt the user to enable accessibility permission if not granted.
     * @return True if accessibility permission is granted, false otherwise.
     */
    fun getAndAskAccessibilityPermission(context: Context, askPermissionToo: Boolean): Boolean {
        if (Utils.isServiceRunning(context, MindfulAccessibilityService::class.java)) {
            return true
        }

        if (askPermissionToo) {
            context.startActivity(Intent(Settings.ACTION_ACCESSIBILITY_SETTINGS))
        }
        return false
    }

    /**
     * Checks if the usage access permission is granted and optionally asks for it if not granted.
     *
     * @param context          The application context used to check permissions and start activities.
     * @param askPermissionToo Whether to prompt the user to enable usage access permission if not granted.
     * @return True if usage access permission is granted, false otherwise.
     */
    fun getAndAskUsageAccessPermission(context: Context, askPermissionToo: Boolean): Boolean {
        val usageStatsManager =
            context.getSystemService(Context.USAGE_STATS_SERVICE) as UsageStatsManager
        val now = System.currentTimeMillis()
        val haveUsage =
            usageStatsManager.queryAndAggregateUsageStats(now - AppConstants.ONE_DAY_IN_MS, now)
                .isNotEmpty()

        if (haveUsage) return true

        if (askPermissionToo) {
            try {
                val intent = Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS)
                    .setData(Uri.parse("package:${context.packageName}"))

                context.startActivity(intent)
            } catch (e: ActivityNotFoundException) {
                val intent = Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS)
                context.startActivity(intent)
            }
        }

        return false
    }


    /**
     * Checks if the Display Over Other Apps permission is granted and optionally asks for it if not granted.
     *
     * @param context          The application context used to check permissions and start activities.
     * @param askPermissionToo Whether to prompt the user to enable Display Over Other Apps permission if not granted.
     * @return True if Display Over Other Apps permission is granted, false otherwise.
     */
    fun getAndAskDisplayOverlayPermission(context: Context, askPermissionToo: Boolean): Boolean {
        if (Settings.canDrawOverlays(context)) return true

        if (askPermissionToo) {
            try {
                val intent = Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION)
                    .setData(Uri.parse("package:${context.packageName}"))

                context.startActivity(intent)
                Toast.makeText(
                    context,
                    "Please allow Mindful to display overlay",
                    Toast.LENGTH_LONG
                ).show()
            } catch (e: Exception) {
                Log.e(
                    TAG,
                    "canDrawOverlays: Unable to open device DISPLAY OVERLAY settings",
                    e
                )
            }
        }
        return false
    }

    /**
     * Checks if the Set Exact Alarm permission is granted and optionally asks for it if not granted.
     *
     * @param context          The application context used to check permissions and start activities.
     * @param askPermissionToo Whether to prompt the user to enable Set Exact Alarm permission if not granted.
     * @return True if Set Exact Alarm permission is granted, false otherwise.
     */
    fun getAndAskExactAlarmPermission(context: Context, askPermissionToo: Boolean): Boolean {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.S) return true

        val alarmManager = context.getSystemService(Context.ALARM_SERVICE) as AlarmManager
        if (alarmManager.canScheduleExactAlarms()) return true

        if (askPermissionToo) {
            try {
                val intent = Intent(Settings.ACTION_REQUEST_SCHEDULE_EXACT_ALARM)
                    .setData(Uri.parse("package:${context.packageName}"))

                context.startActivity(intent)
            } catch (e: Exception) {
                Log.e(
                    TAG,
                    "getAndAskExactAlarmPermission: Unable to open device EXACT ALARM settings",
                    e
                )
            }
        }
        return false
    }

    /**
     * Checks if the Ignore Battery Optimization permission is granted and optionally asks for it if not granted.
     *
     * @param context          The application context used to check permissions and start activities.
     * @param askPermissionToo Whether to prompt the user to enable Ignore Battery Optimization permission if not granted.
     * @return True if Ignore Battery Optimization permission is granted, false otherwise.
     */
    fun getAndAskIgnoreBatteryOptimizationPermission(
        context: Context,
        askPermissionToo: Boolean,
    ): Boolean {
        val powerManager = context.getSystemService(Context.POWER_SERVICE) as PowerManager
        if (powerManager.isIgnoringBatteryOptimizations(context.packageName)) return true

        if (askPermissionToo) {
            try {
                @SuppressLint("BatteryLife")
                val intent = Intent(Settings.ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS)
                    .setData(Uri.parse("package:" + context.packageName))
                context.startActivity(intent)
            } catch (e: Exception) {
                Log.e(
                    TAG,
                    "getAndAskIgnoreBatteryOptimizationPermission: Unable to open device IGNORE BATTERY OPTIMIZATION settings",
                    e
                )
            }
        }
        return false
    }

    /**
     * Checks if notification permissions are granted and optionally asks for it if not granted.
     *
     * @param activity         The activity used to request notification permissions if needed.
     * @param askPermissionToo Whether to request notification permission if not already granted.
     * @return True if notification permissions are granted, false otherwise.
     */
    fun getAndAskNotificationPermission(
        activity: Activity,
        askPermissionToo: Boolean,
    ): Boolean {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            val status = activity.checkSelfPermission(Manifest.permission.POST_NOTIFICATIONS)
            if (status == PackageManager.PERMISSION_GRANTED) {
                return true
            }
        } else {
            val notificationManager =
                activity.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            if (notificationManager.areNotificationsEnabled()) {
                return true
            }
        }

        if (askPermissionToo) {
            if (Build.VERSION.SDK_INT < Build.VERSION_CODES.TIRAMISU) {
                NewActivitiesLaunchHelper.openMindfulNotificationSection(activity)
            } else {
                val count = SharedPrefsHelper.getSetNotificationAskCount(activity, null)
                if (count < 2) {
                    ActivityCompat.requestPermissions(
                        activity,
                        arrayOf(Manifest.permission.POST_NOTIFICATIONS),
                        0
                    )
                } else {
                    NewActivitiesLaunchHelper.openMindfulNotificationSection(activity)
                }

                SharedPrefsHelper.getSetNotificationAskCount(activity, count + 1)
            }
        }
        return false
    }

    /**
     * Checks if the Do Not Disturb (DND) permission is granted and optionally asks for it if not granted.
     *
     * @param context          The application context used to check permissions and start activities.
     * @param askPermissionToo Whether to prompt the user to enable DND permission if not granted.
     * @return True if DND permission is granted, false otherwise.
     */
    fun getAndAskDndPermission(context: Context, askPermissionToo: Boolean): Boolean {
        val notificationManager =
            context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        if (notificationManager.isNotificationPolicyAccessGranted) return true

        if (askPermissionToo) {
            try {
                context.startActivity(Intent(Settings.ACTION_NOTIFICATION_POLICY_ACCESS_SETTINGS))
            } catch (e: ActivityNotFoundException) {
                Log.e(
                    TAG,
                    "getAndAskDndPermission: Unable to open DO NOT DISTURB ACCESS settings",
                    e
                )
            }
        }
        return false
    }

    /**
     * Checks if the Notification Access permission is granted and optionally asks for it if not granted.
     *
     * @param context          The application context used to check permissions and start activities.
     * @param askPermissionToo Whether to prompt the user to enable Notification Access permission if not granted.
     * @return True if Notification Access permission is granted, false otherwise.
     */
    fun getAndAskNotificationAccessPermission(
        context: Context,
        askPermissionToo: Boolean,
    ): Boolean {
        val enabledPackages = NotificationManagerCompat.getEnabledListenerPackages(context)
        if (enabledPackages.contains(context.packageName)) return true

        if (askPermissionToo) {
            try {
                context.startActivity(Intent(Settings.ACTION_NOTIFICATION_LISTENER_SETTINGS))
            } catch (e: ActivityNotFoundException) {
                Log.e(
                    TAG,
                    "getAndAskNotificationAccessPermission: Unable to open NOTIFICATION ACCESS settings",
                    e
                )
            }
        }
        return false
    }
}
