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

import android.app.Activity
import android.app.ActivityOptions
import android.app.AlarmManager
import android.app.PendingIntent
import android.app.StatusBarManager
import android.app.admin.DevicePolicyManager
import android.content.ActivityNotFoundException
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.graphics.drawable.Icon
import android.net.Uri
import android.os.Build
import android.provider.Settings
import android.util.Log
import android.widget.Toast
import com.mindful.android.AppConstants
import com.mindful.android.MainActivity
import com.mindful.android.R
import com.mindful.android.helpers.storage.SharedPrefsHelper
import com.mindful.android.models.Notification
import com.mindful.android.receivers.DeviceAdminReceiver
import com.mindful.android.services.quickTiles.FocusQuickTileService
import io.flutter.plugin.common.MethodChannel
import java.util.Locale


/**
 * NewActivitiesLaunchHelper provides utility methods to launch various activities and settings screens on Android devices.
 * It includes methods for opening URLs, accessibility settings, notification settings,
 * usage access settings, and application settings.
 */
object NewActivitiesLaunchHelper {
    private const val TAG = "Mindful.ActivityNewTaskHelper"

    /**
     * Launches a URL in the default web browser.
     *
     * @param context The context to use for launching the activity.
     * @param url     The URL to be opened.
     */
    fun launchUrl(context: Context, url: String) {
        try {
            val urlIntent = Intent(Intent.ACTION_VIEW)
                .setData(Uri.parse(url))
            context.startActivity(urlIntent)
        } catch (e: Exception) {
            Log.e(TAG, "launchUrl: Unable to launch url: $url", e)
        }
    }

    // SECTION: For MINDFUL app ====================================================================
    /**
     * Gracefully close and restart the app.
     *
     * @param activity The activity to use.
     */
    fun restartMindful(activity: Activity) {
        val appIntent = Intent(activity, MainActivity::class.java)
            .putExtra(AppConstants.INTENT_EXTRA_IS_SELF_RESTART, true)

        val appPendingIntent = PendingIntent.getActivity(
            activity,
            0,
            appIntent,
            PendingIntent.FLAG_ONE_SHOT or PendingIntent.FLAG_IMMUTABLE
        )
        val alarmManager = activity.getSystemService(Context.ALARM_SERVICE) as AlarmManager
        alarmManager.set(AlarmManager.RTC, System.currentTimeMillis(), appPendingIntent)
        Toast.makeText(activity, "Mindful is restarting", Toast.LENGTH_LONG).show()
        activity.finishAfterTransition()
    }


    /**
     * Deactivate the admin privileges.
     *
     * @param context The context to use for launching the activity.
     */
    fun disableDeviceAdmin(context: Context) {
        try {
            val componentName = ComponentName(context, DeviceAdminReceiver::class.java)
            val devicePolicyManager =
                context.getSystemService(Context.DEVICE_POLICY_SERVICE) as DevicePolicyManager

            if (devicePolicyManager.isAdminActive(componentName)) {
                devicePolicyManager.removeActiveAdmin(componentName)
            }
        } catch (e: Exception) {
            Log.e(TAG, "disableDeviceAdmin: Failed to deactivate admin", e)
            SharedPrefsHelper.insertCrashLogToPrefs(context, e)
        }
    }


    /**
     * Opens the mindful's notification settings for permission.
     *
     * @param context The context to use for launching the activity.
     */
    fun openMindfulNotificationSection(context: Context) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val intent = Intent(Settings.ACTION_APP_NOTIFICATION_SETTINGS)
                .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                .putExtra(Settings.EXTRA_APP_PACKAGE, context.packageName)

            context.startActivity(intent)
        } else {
            openSettingsForPackage(context, context.packageName)
        }
        Toast.makeText(context, R.string.toast_enable_notification, Toast.LENGTH_LONG).show()
    }


    /**
     * Prompts the user for to add the quick focus tile.
     *
     * @param context The context to use for launching the activity.
     */
    fun promptForQuickFocusTile(context: Context, result: MethodChannel.Result) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            try {
                val statusBarManager = context.getSystemService(StatusBarManager::class.java)
                statusBarManager?.requestAddTileService(
                    ComponentName(context, FocusQuickTileService::class.java),
                    context.getString(R.string.shortcut_focus_mode_label),
                    Icon.createWithResource(context, R.drawable.ic_focus_mode),
                    context.mainExecutor
                ) {
                    result.success(it == StatusBarManager.TILE_ADD_REQUEST_RESULT_TILE_ADDED)
                }
            } catch (e: Exception) {
                result.success(false)
            }
        } else {
            result.success(false)
        }
    }

    /**
     * Opens the do not disturb device settings.
     *
     * @param context The context to use for launching the activity.
     */
    fun openDeviceDndSettings(context: Context) {
        try {
            context.startActivity(Intent("android.settings.ZEN_MODE_SETTINGS"))
        } catch (e: ActivityNotFoundException) {
            Log.e(TAG, "openDeviceDndSettings: Unable to open device DND settings", e)
        }
    }

    /**
     * Navigates user to the appropriate auto-start settings screen based on the device manufacturer.
     * If the manufacturer-specific intent fails, it falls back to ignore battery optimizations.
     *
     * @param context The context to use for launching the activity.
     * @return Boolean flag if successful in launching the activity.
     */
    fun openAutoStartSettings(context: Context): Boolean {
        try {
            val manufacturer = Build.MANUFACTURER.lowercase(Locale.getDefault())
            val intent = Intent()

            when (manufacturer) {
                "xiaomi" -> intent.setComponent(
                    ComponentName(
                        "com.miui.securitycenter",
                        "com.miui.permcenter.autostart.AutoStartManagementActivity"
                    )
                )

                "huawei" -> intent.setComponent(
                    ComponentName(
                        "com.huawei.systemmanager",
                        "com.huawei.systemmanager.startupmgr.ui.StartupNormalAppListActivity"
                    )
                )

                "oppo" -> intent.setComponent(
                    ComponentName(
                        "com.coloros.safecenter",
                        "com.coloros.safecenter.startupapp.StartupAppListActivity"
                    )
                )

                "vivo" -> intent.setComponent(
                    ComponentName(
                        "com.iqoo.secure",
                        "com.iqoo.secure.ui.phoneoptimize.AddWhiteListActivity"
                    )
                )

                "asus" -> intent.setComponent(
                    ComponentName(
                        "com.asus.mobilemanager",
                        "com.asus.mobilemanager.entry.FunctionActivity"
                    )
                )

                "samsung" -> intent.setComponent(
                    ComponentName(
                        "com.samsung.android.lool",
                        "com.samsung.android.sm.battery.ui.BatteryActivity"
                    )
                )

                "oneplus" -> intent.setComponent(
                    ComponentName(
                        "com.oneplus.security",
                        "com.oneplus.security.chainlaunch.view.ChainLaunchAppListActivity"
                    )
                )

                "sony" -> intent.setComponent(
                    ComponentName(
                        "com.sonymobile.cta",
                        "com.sonymobile.cta.SomcCTAMainActivity"
                    )
                )

                "lenovo" -> intent.setComponent(
                    ComponentName(
                        "com.lenovo.security",
                        "com.lenovo.security.purebackground.PureBackgroundActivity"
                    )
                )

                else -> return false
            }
            intent.setData(Uri.parse("package:" + context.packageName))
            context.startActivity(intent)
        } catch (e: Exception) {
            return false
        }

        return true
    }

    // SECTION: For different app packages =========================================================
    /**
     * Opens the specified app using its package name.
     *
     * @param context    The context to use for launching the activity.
     * @param appPackage The package name of the app to be launched.
     */
    fun openAppWithPackage(context: Context, appPackage: String) {
        if (appPackage.isEmpty()) {
            return
        }

        try {
            context.packageManager.getLaunchIntentForPackage(appPackage)?.let {
                context.startActivity(it)
            }
        } catch (e: ActivityNotFoundException) {
            Log.e(
                TAG,
                "openAppWithPackage:Package not found, Unable to launch app : $appPackage",
                e
            )
        }
    }

    /**
     * Opens the specified app using its pending intent and notification.
     *
     * @param context    The context to use for launching the activity.
     * @param pendingIntent The nullable pending intent of notification.
     * @param notification The notification itself.
     */
    fun openAppWithNotificationThread(
        context: Context,
        notification: Notification,
        pendingIntent: PendingIntent?,
    ) {
        try {
            (pendingIntent ?: throw Exception("Null pending intent")).let {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) {
                    it.send(
                        ActivityOptions.makeBasic().setPendingIntentBackgroundActivityStartMode(
                            ActivityOptions.MODE_BACKGROUND_ACTIVITY_START_ALLOWED
                        ).toBundle()
                    )
                } else {
                    it.send()
                }
            }
        } catch (e: Exception) {
            Log.d(TAG, "openAppWithNotificationThread: Pending intent is null, trying to ope app directly.")
            openAppWithPackage(context, notification.packageName)
        }
    }

    /**
     * Opens the settings page for a specified app using its package name.
     *
     * @param context    The context to use for launching the activity.
     * @param appPackage The package name of the app whose settings are to be opened.
     */
    fun openSettingsForPackage(context: Context, appPackage: String) {
        if (appPackage.isEmpty()) {
            return
        }

        try {
            if (context.packageManager.getLaunchIntentForPackage(appPackage) != null) {
                val intent = Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS)
                    .setFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    .setData(Uri.parse("package:$appPackage"))
                context.startActivity(intent)
            }
        } catch (e: ActivityNotFoundException) {
            Log.e(
                TAG,
                "openAppSettingsForPackage: Unable to launch app settings for $appPackage",
                e
            )
        }
    }
}
