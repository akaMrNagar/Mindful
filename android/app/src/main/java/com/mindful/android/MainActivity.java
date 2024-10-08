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

package com.mindful.android;

import static com.mindful.android.services.EmergencyPauseService.ACTION_START_SERVICE_EMERGENCY;
import static com.mindful.android.services.FocusSessionService.INTENT_EXTRA_FOCUS_SESSION_JSON;

import android.annotation.SuppressLint;
import android.app.AlarmManager;
import android.content.Context;
import android.content.Intent;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.PowerManager;
import android.provider.Settings;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.mindful.android.generics.SafeServiceConnection;
import com.mindful.android.helpers.AlarmTasksSchedulingHelper;
import com.mindful.android.helpers.DeviceAppsHelper;
import com.mindful.android.helpers.NewActivitiesLaunchHelper;
import com.mindful.android.helpers.NotificationHelper;
import com.mindful.android.helpers.PermissionsHelper;
import com.mindful.android.helpers.SharedPrefsHelper;
import com.mindful.android.models.BedtimeSettings;
import com.mindful.android.services.EmergencyPauseService;
import com.mindful.android.services.FocusSessionService;
import com.mindful.android.services.MindfulTrackerService;
import com.mindful.android.services.MindfulVpnService;
import com.mindful.android.utils.AppConstants;
import com.mindful.android.utils.Utils;

import java.util.HashSet;
import java.util.Locale;
import java.util.Map;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity implements MethodChannel.MethodCallHandler {

    private static final String TAG = "Mindful.MainActivity";
    private SafeServiceConnection<MindfulTrackerService> mTrackerServiceConn;
    private SafeServiceConnection<MindfulVpnService> mVpnServiceConn;
    private SafeServiceConnection<FocusSessionService> mFocusServiceConn;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        updateLocale(null);

        // Register notification channels
        NotificationHelper.registerNotificationGroupAndChannels(this);

        // Schedule midnight 12 task if already not scheduled
        AlarmTasksSchedulingHelper.scheduleMidnightResetTask(this, true);

        // Initialize service connections
        mTrackerServiceConn = new SafeServiceConnection<>(MindfulTrackerService.class, this);
        mVpnServiceConn = new SafeServiceConnection<>(MindfulVpnService.class, this);
        mFocusServiceConn = new SafeServiceConnection<>(FocusSessionService.class, this);
    }

    private void updateLocale(@Nullable String languageCode) {
        String resolvedLanguageCode = languageCode != null ? languageCode : SharedPrefsHelper.fetchLocale(this);

        if (!resolvedLanguageCode.isEmpty()) {
            Locale newLocale = new Locale(resolvedLanguageCode);
            Locale.setDefault(newLocale);
            Resources resources = getResources();
            Configuration config = resources.getConfiguration();
            config.setLocale(newLocale);
            resources.updateConfiguration(config, resources.getDisplayMetrics());
        }
    }


    @Override
    protected void onStart() {
        super.onStart();

        /// Bind to Services if they are already running
        mTrackerServiceConn.bindService();
        mVpnServiceConn.bindService();
        mFocusServiceConn.bindService();
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        MethodChannel mMethodChannel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), AppConstants.FLUTTER_METHOD_CHANNEL);
        mMethodChannel.setMethodCallHandler(this);

        // Check if the app was launched from TLE dialog and update the targeted app
        String appPackage = getIntent().getStringExtra("appPackage");
        if (appPackage != null && !appPackage.isEmpty()) {
            mMethodChannel.invokeMethod("updateTargetedApp", appPackage);
        }
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            // SECTION: Utility methods -----------------------------------------------------------------------
            case "updateLocale": {
                String languageCode = Utils.notNullStr(call.arguments());
                updateLocale(languageCode);
                SharedPrefsHelper.storeLocale(this, languageCode);
                result.success(true);
                break;
            }
            case "getOnboardingStatus": {
                result.success(SharedPrefsHelper.getOnboardingStatus(this));
                break;
            }
            case "setOnboardingDone": {
                SharedPrefsHelper.setOnboardingDone(this);
                result.success(true);
                break;
            }
            case "getAppVersion": {
                result.success(Utils.getAppVersion(this));
                break;
            }
            case "getDeviceInfoMap": {
                result.success(Utils.getDeviceInfoMap());
                break;
            }
            case "getDeviceApps": {
                DeviceAppsHelper.getDeviceApps(this, result);
                break;
            }
            case "getShortsScreenTimeMs": {
                result.success(SharedPrefsHelper.fetchShortsScreenTimeMs(this));
                break;
            }
            case "setDataResetTime": {
                SharedPrefsHelper.storeDataResetTimeMins(this, call.arguments() == null ? 0 : (int) call.arguments());
                result.success(true);
                break;
            }
            case "launchUrl": {
                NewActivitiesLaunchHelper.launchUrl(this, Utils.notNullStr(call.arguments()));
                result.success(true);
                break;
            }
            case "shareFile": {
                NewActivitiesLaunchHelper.shareFile(this, Utils.notNullStr(call.arguments()));
                result.success(true);
                break;
            }
            case "parseHostFromUrl": {
                result.success(call.arguments() == null ? "" : Utils.parseHostNameFromUrl(call.arguments()));
                break;
            }

            // SECTION: Foreground service and Worker methods ---------------------------------------------------------------------------
            case "updateAppTimers": {
                String dartJsonAppTimers = Utils.notNullStr(call.arguments());
                Map<String, Long> appTimers = Utils.jsonStrToStringLongHashMap(dartJsonAppTimers);
                SharedPrefsHelper.storeAppTimersJson(this, dartJsonAppTimers);  // Cache app timers json string to shared prefs
                if (mTrackerServiceConn.isConnected()) {
                    mTrackerServiceConn.getService().updateAppTimers();
                } else if (!appTimers.isEmpty()) {
                    mTrackerServiceConn.startAndBind(MindfulTrackerService.ACTION_START_SERVICE_TIMER_MODE);
                }
                result.success(true);
                break;
            }
            case "updateBlockedApps": {
                String blockedAppsJson = Utils.notNullStr(call.arguments());
                HashSet<String> blockedApps = Utils.jsonStrToStringHashSet(blockedAppsJson);
                SharedPrefsHelper.storeBlockedAppsJson(this, blockedAppsJson);  // Cache blocked apps json string to shared prefs
                if (mVpnServiceConn.isConnected()) {
                    mVpnServiceConn.getService().updateBlockedApps();
                } else if (!blockedApps.isEmpty() && getAndAskVpnPermission(false)) {
                    mVpnServiceConn.startAndBind(MindfulVpnService.ACTION_START_SERVICE_VPN);
                }
                result.success(true);
                break;
            }
            case "updateBedtimeSchedule": {
                String dartJsonBedtimeSettings = Utils.notNullStr(call.arguments());
                SharedPrefsHelper.storeBedtimeSettingsJson(this, dartJsonBedtimeSettings);  // Cache bedtime settings json string to shared pref
                BedtimeSettings bedtimeSettings = new BedtimeSettings(dartJsonBedtimeSettings);
                if (bedtimeSettings.isScheduleOn) {
                    AlarmTasksSchedulingHelper.scheduleBedtimeStartTask(this);
                } else {
                    AlarmTasksSchedulingHelper.cancelBedtimeRoutineTasks(this);
                    Intent serviceIntent = new Intent(this, MindfulTrackerService.class).setAction(MindfulTrackerService.ACTION_STOP_SERVICE_BEDTIME_MODE);
                    startService(serviceIntent);
                }
                result.success(true);
                break;
            }
            case "updateWellBeingSettings": {
                // NOTE: Only updating shared prefs because accessibility service have onSharedPrefsChange listener registered which will eventually reload needed data
                SharedPrefsHelper.storeWellBeingSettingsJson(this, Utils.notNullStr(call.arguments()));
                result.success(true);
                break;
            }
            case "getLeftEmergencyPasses": {
                result.success(SharedPrefsHelper.fetchEmergencyPassesCount(this));
                break;
            }
            case "useEmergencyPass": {
                if (!Utils.isServiceRunning(this, EmergencyPauseService.class.getName())
                        && Utils.isServiceRunning(this, MindfulTrackerService.class.getName())
                ) {
                    startService(new Intent(this, EmergencyPauseService.class).setAction(ACTION_START_SERVICE_EMERGENCY));
                    result.success(true);
                } else {
                    result.success(false);
                }
                break;
            }
            case "startFocusSession": {
                if (!Utils.isServiceRunning(this, FocusSessionService.class.getName())) {
                    Intent intent = new Intent(this, FocusSessionService.class);
                    intent.setAction(FocusSessionService.ACTION_START_SERVICE_FOCUS);
                    intent.putExtra(INTENT_EXTRA_FOCUS_SESSION_JSON, Utils.notNullStr(call.arguments()));
                    startService(intent);
                    mFocusServiceConn.bindService();
                    result.success(true);
                } else {
                    result.success(false);
                }
                break;
            }
            case "UpdateFocusSession": {
                if (mFocusServiceConn.isConnected()) {
                    String dartJsonFocusSessionDistractingApps = Utils.notNullStr(call.arguments());
                    mFocusServiceConn.getService().updateDistractingApps(Utils.jsonStrToStringHashSet(dartJsonFocusSessionDistractingApps));
                    result.success(true);
                } else {
                    result.success(false);
                }
                break;
            }

            case "stopFocusSession": {
                if (mFocusServiceConn.isConnected()) {
                    mFocusServiceConn.getService().giveUpAndStopSession();
                }
                result.success(true);
                break;
            }

            // SECTION: Permissions handler methods ------------------------------------------------------
            case "getAndAskNotificationPermission": {
                result.success(NotificationHelper.getAndAskNotificationPermission(this, this, Boolean.TRUE.equals(call.arguments())));
                break;
            }
            case "getAndAskAccessibilityPermission": {
                result.success(PermissionsHelper.getAndAskAccessibilityPermission(this, Boolean.TRUE.equals(call.arguments())));
                break;
            }
            case "getAndAskDndPermission": {
                result.success(PermissionsHelper.getAndAskDndPermission(this, Boolean.TRUE.equals(call.arguments())));
                break;
            }
            case "getAndAskUsageAccessPermission": {
                result.success(PermissionsHelper.getAndAskUsageAccessPermission(this, Boolean.TRUE.equals(call.arguments())));
                break;
            }
            case "getAndAskIgnoreBatteryOptimizationPermission": {
                result.success(getAndAskIgnoreBatteryOptimizationPermission(Boolean.TRUE.equals(call.arguments())));
                break;
            }
            case "getAndAskVpnPermission": {
                result.success(getAndAskVpnPermission(Boolean.TRUE.equals(call.arguments())));
                break;
            }
            case "getAndAskDisplayOverlayPermission": {
                result.success(getAndAskDisplayOverlayPermission(Boolean.TRUE.equals(call.arguments())));
                break;
            }
            case "getAndAskExactAlarmPermission": {
                result.success(getAndAskExactAlarmPermission(Boolean.TRUE.equals(call.arguments())));
                break;
            }

            // SECTION: New Activity Launch methods ------------------------------------------------------
            case "openAppWithPackage": {
                NewActivitiesLaunchHelper.openAppWithPackage(this, call.arguments());
                result.success(true);
                break;
            }
            case "openAppSettingsForPackage": {
                NewActivitiesLaunchHelper.openSettingsForPackage(this, call.arguments());
                result.success(true);
                break;
            }
            case "openDeviceDndSettings": {
                NewActivitiesLaunchHelper.openDeviceDndSettings(this);
                result.success(true);
                break;
            }
            case "openAutoStartSettings": {
                result.success(NewActivitiesLaunchHelper.openAutoStartSettings(this));
                break;
            }
            default:
                result.notImplemented();
        }
    }

    /**
     * Checks if the Create VPN permission is granted and optionally asks for it if not granted.
     *
     * @param askPermissionToo Whether to prompt the user to enable Create VPN permission if not granted.
     * @return True if Create VPN permission is granted, false otherwise.
     */
    private boolean getAndAskVpnPermission(boolean askPermissionToo) {
        Intent intent = MindfulVpnService.prepare(this);
        if (askPermissionToo && intent != null) {
            startActivityForResult(intent, 0);
        }
        return intent == null;
    }

    /**
     * Checks if the Display Over Other Apps permission is granted and optionally asks for it if not granted.
     *
     * @param askPermissionToo Whether to prompt the user to enable Display Over Other Apps permission if not granted.
     * @return True if Display Over Other Apps permission is granted, false otherwise.
     */
    private boolean getAndAskDisplayOverlayPermission(boolean askPermissionToo) {
        if (Settings.canDrawOverlays(this)) return true;

        if (askPermissionToo) {
            Intent intent = new Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION);
            intent.setData(android.net.Uri.parse("package:" + getPackageName()));
            startActivityForResult(intent, 0);
            Toast.makeText(this, "Please allow Mindful to display overlay", Toast.LENGTH_LONG).show();
        }
        return false;
    }

    /**
     * Checks if the Set Exact Alarm permission is granted and optionally asks for it if not granted.
     *
     * @param askPermissionToo Whether to prompt the user to enable Set Exact Alarm permission if not granted.
     * @return True if Set Exact Alarm permission is granted, false otherwise.
     */
    public boolean getAndAskExactAlarmPermission(boolean askPermissionToo) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.S) return true;

        AlarmManager alarmManager = (AlarmManager) getSystemService(Context.ALARM_SERVICE);
        if (alarmManager.canScheduleExactAlarms()) return true;

        if (askPermissionToo) {
            Intent intent = new Intent(Settings.ACTION_REQUEST_SCHEDULE_EXACT_ALARM);
            intent.setData(android.net.Uri.parse("package:" + getPackageName()));
            startActivityForResult(intent, 0);
        }
        return false;
    }

    /**
     * Checks if the Ignore Battery Optimization permission is granted and optionally asks for it if not granted.
     *
     * @param askPermissionToo Whether to prompt the user to enable Ignore Battery Optimization permission if not granted.
     * @return True if Ignore Battery Optimization permission is granted, false otherwise.
     */
    public boolean getAndAskIgnoreBatteryOptimizationPermission(boolean askPermissionToo) {
        PowerManager powerManager = (PowerManager) getSystemService(Context.POWER_SERVICE);
        if (powerManager.isIgnoringBatteryOptimizations(getPackageName())) return true;

        if (askPermissionToo) {
            @SuppressLint("BatteryLife") Intent intent = new Intent(Settings.ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS);
            intent.setData(Uri.parse("package:" + getPackageName()));
            startActivityForResult(intent, 0);
        }
        return false;
    }

    @Override
    protected void onStop() {
        super.onStop();

        // Notify VPN service that it can restart if needed
        if (mVpnServiceConn.isConnected()) {
            mVpnServiceConn.getService().onApplicationStop();
        }

        // Unbind services
        mTrackerServiceConn.unBindService();
        mVpnServiceConn.unBindService();
        mFocusServiceConn.unBindService();
    }
}
