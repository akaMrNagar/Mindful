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

import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.AlarmManager;
import android.app.PendingIntent;
import android.app.admin.DevicePolicyManager;
import android.content.ActivityNotFoundException;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Build;
import android.provider.Settings;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;

import com.mindful.android.MainActivity;
import com.mindful.android.R;
import com.mindful.android.receivers.DeviceAdminReceiver;
import com.mindful.android.services.MindfulAccessibilityService;
import com.mindful.android.utils.Utils;

/**
 * NewActivitiesLaunchHelper provides utility methods to launch various activities and settings screens on Android devices.
 * It includes methods for opening URLs, accessibility settings, notification settings,
 * usage access settings, and application settings.
 */
public class NewActivitiesLaunchHelper {
    public static final String INTENT_EXTRA_IS_SELF_RESTART = "isSelfRestart";


    private static final String TAG = "Mindful.ActivityNewTaskHelper";

    /**
     * Launches a URL in the default web browser.
     *
     * @param context The context to use for launching the activity.
     * @param url     The URL to be opened.
     */
    public static void launchUrl(@NonNull Context context, @NonNull String url) {
        try {
            Intent urlIntent = new Intent(Intent.ACTION_VIEW).setData(Uri.parse(url));
            context.startActivity(urlIntent);
        } catch (Exception e) {
            Log.e(TAG, "launchUrl: Unable to launch url: " + url, e);
        }
    }

    // SECTION: For MINDFUL app ====================================================================

    /**
     * Gracefully close and restart the app.
     *
     * @param activity The activity to use.
     */
    public static void restartMindful(@NonNull Activity activity) {
        Intent appIntent = new Intent(activity, MainActivity.class);
        appIntent.putExtra(INTENT_EXTRA_IS_SELF_RESTART, true);
        PendingIntent appPendingIntent = PendingIntent.getActivity(activity, 0, appIntent, PendingIntent.FLAG_ONE_SHOT | PendingIntent.FLAG_IMMUTABLE);
        AlarmManager alarmManager = (AlarmManager) activity.getSystemService(Context.ALARM_SERVICE);
        alarmManager.set(AlarmManager.RTC, System.currentTimeMillis(), appPendingIntent);
        Toast.makeText(activity, "Mindful is restarting", Toast.LENGTH_LONG).show();
        activity.finishAfterTransition();
    }

    /**
     * Opens the accessibility settings for enabling the Mindful accessibility service.
     *
     * @param context The context to use for launching the activity.
     */
    public static void openMindfulAccessibilitySection(@NonNull Context context) {
        if (!Utils.isServiceRunning(context, MindfulAccessibilityService.class.getName())) {
            context.startActivity(new Intent(Settings.ACTION_ACCESSIBILITY_SETTINGS));
        }
    }

    /**
     * Opens the notification settings for the Mindful app.
     *
     * @param context The context to use for launching the activity.
     */
    public static void openMindfulNotificationSection(@NonNull Context context) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            Intent intent = new Intent(Settings.ACTION_APP_NOTIFICATION_SETTINGS);
            intent.putExtra(Settings.EXTRA_APP_PACKAGE, context.getPackageName());
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            context.startActivity(intent);
        } else {
            openSettingsForPackage(context, context.getPackageName());
        }
        Toast.makeText(context, R.string.toast_enable_notification, Toast.LENGTH_LONG).show();
    }

    // SECTION: For device setting sections or pages app ===========================================

    /**
     * Opens the device admin settings for the Mindful app.
     *
     * @param context       The context to use for launching the activity.
     * @param componentName The component name of the Mindful device admin receiver.
     */
    public static void openMindfulDeviceAdminSection(@NonNull Context context, ComponentName componentName) {
        try {
            Intent intent = new Intent(DevicePolicyManager.ACTION_ADD_DEVICE_ADMIN);
            intent.putExtra(DevicePolicyManager.EXTRA_DEVICE_ADMIN, componentName);
            intent.putExtra(DevicePolicyManager.EXTRA_ADD_EXPLANATION, R.string.admin_description);
            context.startActivity(intent);
        } catch (ActivityNotFoundException e) {
            Log.e(TAG, "openDeviceAdminSettings: Unable to open device ADMIN settings", e);
        }
    }

    /**
     * Deactivate the admin privileges.
     *
     * @param context The context to use for launching the activity.
     */
    public static void disableDeviceAdmin(@NonNull Context context) {
        try {
            ComponentName componentName = new ComponentName(context, DeviceAdminReceiver.class);
            DevicePolicyManager devicePolicyManager = (DevicePolicyManager) context.getSystemService(Context.DEVICE_POLICY_SERVICE);

            if (devicePolicyManager.isAdminActive(componentName)) {
                devicePolicyManager.removeActiveAdmin(componentName);
            }
        } catch (Exception e) {
            Log.e(TAG, "disableDeviceAdmin: Failed to deactivate admin", e);
        }
    }

    /**
     * Opens the Mindful usage access settings for permission.
     *
     * @param context The context to use for launching the activity.
     */
    public static void openMindfulUsageAccessSection(@NonNull Context context) {
        try {
            Intent intent = new Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS);
            intent.setData(Uri.parse("package:" + context.getPackageName()));
            context.startActivity(intent);
        } catch (ActivityNotFoundException e) {
            Intent intent = new Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS);
            context.startActivity(intent);
        }
    }

    /**
     * Opens the display overlay settings for permission.
     *
     * @param context The context to use for launching the activity.
     */
    public static void openMindfulDisplayOverlaySection(@NonNull Context context) {
        try {
            Intent intent = new Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION);
            intent.setData(android.net.Uri.parse("package:" + context.getPackageName()));
            context.startActivity(intent);
            Toast.makeText(context, "Please allow Mindful to display overlay", Toast.LENGTH_LONG).show();
        } catch (Exception e) {
            Log.e(TAG, "openMindfulDisplayOverlaySection: Unable to open device DISPLAY OVERLAY settings", e);

        }
    }

    /**
     * Opens the exact alarm and reminders settings for permission.
     *
     * @param context The context to use for launching the activity.
     */
    @RequiresApi(api = Build.VERSION_CODES.S)
    public static void openMindfulExactAlarmSection(@NonNull Context context) {
        try {
            Intent intent = new Intent(Settings.ACTION_REQUEST_SCHEDULE_EXACT_ALARM);
            intent.setData(android.net.Uri.parse("package:" + context.getPackageName()));
            context.startActivity(intent);
        } catch (Exception e) {
            Log.e(TAG, "openMindfulExactAlarmSection: Unable to open device EXACT ALARM settings", e);

        }
    }

    /**
     * Opens the ignore battery optimization settings for permission.
     *
     * @param context The context to use for launching the activity.
     */
    public static void openMindfulIgnoreBatteryOptimizationSection(@NonNull Context context) {
        try {
            @SuppressLint("BatteryLife") Intent intent = new Intent(Settings.ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS);
            intent.setData(Uri.parse("package:" + context.getPackageName()));
            context.startActivity(intent);
        } catch (Exception e) {
            Log.e(TAG, "openMindfulIgnoreBatteryOptimizationSection: Unable to open device IGNORE BATTERY OPTIMIZATION settings", e);
        }
    }

    /**
     * Opens the do not disturb access settings.
     *
     * @param context The context to use for launching the activity.
     */
    public static void openDeviceDoNotDisturbAccessSection(@NonNull Context context) {
        Intent intent = new Intent(Settings.ACTION_NOTIFICATION_POLICY_ACCESS_SETTINGS);
        context.startActivity(intent);
    }

    /**
     * Opens the do not disturb settings.
     *
     * @param context The context to use for launching the activity.
     */
    public static void openDeviceDndSettings(@NonNull Context context) {
        try {
            context.startActivity(new Intent("android.settings.ZEN_MODE_SETTINGS"));
        } catch (ActivityNotFoundException e) {
            Log.e(TAG, "openDeviceDndSettings: Unable to open device DND settings", e);
        }
    }


    /**
     * Navigates user to the appropriate auto-start settings screen based on the device manufacturer.
     * If the manufacturer-specific intent fails, it falls back to ignore battery optimizations.
     *
     * @param context The context to use for launching the activity.
     * @return Boolean flag if successful in launching the activity.
     */
    public static boolean openAutoStartSettings(Context context) {
        try {
            String manufacturer = Build.MANUFACTURER.toLowerCase();
            Intent intent = new Intent();

            switch (manufacturer) {
                case "xiaomi":
                    intent.setComponent(new ComponentName("com.miui.securitycenter", "com.miui.permcenter.autostart.AutoStartManagementActivity"));
                    break;
                case "huawei":
                    intent.setComponent(new ComponentName("com.huawei.systemmanager", "com.huawei.systemmanager.startupmgr.ui.StartupNormalAppListActivity"));
                    break;
                case "oppo":
                    intent.setComponent(new ComponentName("com.coloros.safecenter", "com.coloros.safecenter.startupapp.StartupAppListActivity"));
                    break;
                case "vivo":
                    intent.setComponent(new ComponentName("com.iqoo.secure", "com.iqoo.secure.ui.phoneoptimize.AddWhiteListActivity"));
                    break;
                case "asus":
                    intent.setComponent(new ComponentName("com.asus.mobilemanager", "com.asus.mobilemanager.entry.FunctionActivity"));
                    break;
                case "samsung":
                    intent.setComponent(new ComponentName("com.samsung.android.lool", "com.samsung.android.sm.battery.ui.BatteryActivity"));
                    break;
                case "oneplus":
                    intent.setComponent(new ComponentName("com.oneplus.security", "com.oneplus.security.chainlaunch.view.ChainLaunchAppListActivity"));
                    break;
                case "sony":
                    intent.setComponent(new ComponentName("com.sonymobile.cta", "com.sonymobile.cta.SomcCTAMainActivity"));
                    break;
                case "lenovo":
                    intent.setComponent(new ComponentName("com.lenovo.security", "com.lenovo.security.purebackground.PureBackgroundActivity"));
                    break;
                default:
                    return false;
            }

            intent.setData(Uri.parse("package:" + context.getPackageName()));
            context.startActivity(intent);
        } catch (Exception e) {
            return false;
        }

        return true;
    }

    // SECTION: For different app packages =========================================================

    /**
     * Opens the specified app using its package name.
     *
     * @param context    The context to use for launching the activity.
     * @param appPackage The package name of the app to be launched.
     */
    public static void openAppWithPackage(@NonNull Context context, @NonNull String appPackage) {
        if (appPackage.isEmpty()) {
            return;
        }

        try {
            Intent appIntent = context.getPackageManager().getLaunchIntentForPackage(appPackage);

            if (appIntent != null) {
                context.startActivity(appIntent);
            }
        } catch (ActivityNotFoundException e) {
            Log.e(TAG, "openAppWithPackage:Package not found, Unable to launch app : " + appPackage, e);
        }
    }

    /**
     * Opens the settings page for a specified app using its package name.
     *
     * @param context    The context to use for launching the activity.
     * @param appPackage The package name of the app whose settings are to be opened.
     */
    public static void openSettingsForPackage(@NonNull Context context, @NonNull String appPackage) {
        if (appPackage.isEmpty()) {
            return;
        }

        try {
            if (context.getPackageManager().getLaunchIntentForPackage(appPackage) != null) {
                Intent intent = new Intent(android.provider.Settings.ACTION_APPLICATION_DETAILS_SETTINGS);
                intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                intent.setData(Uri.parse("package:" + appPackage));
                context.startActivity(intent);
            }
        } catch (ActivityNotFoundException e) {
            Log.e(TAG, "openAppSettingsForPackage: Unable to launch app settings for " + appPackage, e);
        }
    }
}
