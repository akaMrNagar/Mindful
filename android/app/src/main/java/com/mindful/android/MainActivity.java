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

import static com.mindful.android.generics.ServiceBinder.ACTION_START_MINDFUL_SERVICE;
import static com.mindful.android.helpers.NewActivitiesLaunchHelper.INTENT_EXTRA_IS_SELF_RESTART;
import static com.mindful.android.services.OverlayDialogService.INTENT_EXTRA_PACKAGE_NAME;

import android.content.Intent;
import android.content.res.Configuration;
import android.os.Bundle;

import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.contract.ActivityResultContracts;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.mindful.android.generics.SafeServiceConnection;
import com.mindful.android.helpers.AlarmTasksSchedulingHelper;
import com.mindful.android.helpers.DeviceAppsHelper;
import com.mindful.android.helpers.NewActivitiesLaunchHelper;
import com.mindful.android.helpers.NotificationHelper;
import com.mindful.android.helpers.PermissionsHelper;
import com.mindful.android.helpers.SharedPrefsHelper;
import com.mindful.android.models.AppRestrictions;
import com.mindful.android.models.BedtimeSettings;
import com.mindful.android.models.FocusSession;
import com.mindful.android.models.RestrictionGroup;
import com.mindful.android.services.EmergencyPauseService;
import com.mindful.android.services.FocusSessionService;
import com.mindful.android.services.MindfulNotificationListenerService;
import com.mindful.android.services.MindfulTrackerService;
import com.mindful.android.services.MindfulVpnService;
import com.mindful.android.utils.AppConstants;
import com.mindful.android.utils.JsonDeserializer;
import com.mindful.android.utils.Utils;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Locale;

import io.flutter.embedding.android.FlutterFragmentActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterFragmentActivity implements MethodChannel.MethodCallHandler {

    private static final String TAG = "Mindful.MainActivity";
    private SafeServiceConnection<MindfulTrackerService> mTrackerServiceConn;
    private SafeServiceConnection<MindfulVpnService> mVpnServiceConn;
    private SafeServiceConnection<MindfulNotificationListenerService> mNotificationServiceConn;
    private SafeServiceConnection<FocusSessionService> mFocusServiceConn;
    private ActivityResultLauncher<Intent> mVpnPermissionLauncher;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        // Store uncaught exceptions
        Thread.setDefaultUncaughtExceptionHandler((thread, exception) -> SharedPrefsHelper.insertCrashLogToPrefs(this, exception));

        // Register notification channels
        NotificationHelper.registerNotificationChannels(this);

        // Schedule midnight 12 task if already not scheduled
        AlarmTasksSchedulingHelper.scheduleMidnightResetTask(this, true);

        // register permission launcher for result
        mVpnPermissionLauncher = registerForActivityResult(
                new ActivityResultContracts.StartActivityForResult(),
                result -> {
                    // Ignored
                }
        );

        // Initialize service connections
        mTrackerServiceConn = new SafeServiceConnection<>(MindfulTrackerService.class, this);
        mNotificationServiceConn = new SafeServiceConnection<>(MindfulNotificationListenerService.class, this);
        mVpnServiceConn = new SafeServiceConnection<>(MindfulVpnService.class, this);
        mFocusServiceConn = new SafeServiceConnection<>(FocusSessionService.class, this);

        /// Bind to Services if they are already running
        mTrackerServiceConn.bindService();
        mVpnServiceConn.bindService();
        mNotificationServiceConn.bindService();
        mFocusServiceConn.bindService();
    }

    private void updateLocale(@NonNull String languageCode) {
        if (!languageCode.isEmpty()) {
            Locale newLocale = new Locale(languageCode);
            Locale.setDefault(newLocale);
            Configuration config = new Configuration();
            config.setLocale(newLocale);
            getResources().updateConfiguration(config, getResources().getDisplayMetrics());
        }
    }


    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        MethodChannel mMethodChannel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), AppConstants.FLUTTER_METHOD_CHANNEL);
        mMethodChannel.setMethodCallHandler(this);
        // Check if the was restarted itself during databased import
        boolean isRestart = getIntent().getBooleanExtra(INTENT_EXTRA_IS_SELF_RESTART, false);
        String appPackage = getIntent().getStringExtra(INTENT_EXTRA_PACKAGE_NAME);
        if (isRestart) {
            mMethodChannel.invokeMethod("updateIsRestartBool", true);
        }
        // Check if the app was launched from TLE dialog and update the targeted app
        else if (appPackage != null && !appPackage.isEmpty()) {
            mMethodChannel.invokeMethod("updateTargetedApp", appPackage);
        }
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            // SECTION: Utility methods -----------------------------------------------------------------------
            case "updateLocale": {
                updateLocale(Utils.notNullStr(call.arguments()));
                result.success(true);
                break;
            }
            case "updateExcludedApps": {
                SharedPrefsHelper.getSetExcludedApps(this, Utils.notNullStr(call.arguments()));
                result.success(true);
                break;
            }
            case "getDeviceInfoMap": {
                result.success(Utils.getDeviceInfoMap(this));
                break;
            }
            case "getDeviceApps": {
                DeviceAppsHelper.getDeviceApps(
                        this,
                        result,
                        mTrackerServiceConn.isConnected() ? mTrackerServiceConn.getService().getAppsLaunchCount() : new HashMap<>(0)
                );
                break;
            }
            case "getShortsScreenTimeMs": {
                result.success(SharedPrefsHelper.getSetShortsScreenTimeMs(this, null));
                break;
            }
            case "setDataResetTime": {
                SharedPrefsHelper.getSetDataResetTimeMins(this, call.arguments() == null ? 0 : call.arguments());
                result.success(true);
                break;
            }
            case "getNativeCrashLogs": {
                result.success(SharedPrefsHelper.getCrashLogsArrayString(this));
                break;
            }
            case "clearNativeCrashLogs": {
                SharedPrefsHelper.clearCrashLogs(this);
                result.success(true);
                break;
            }
            // SECTION: Foreground service and Worker methods ---------------------------------------------------------------------------
            case "updateAppRestrictions": {
                HashMap<String, AppRestrictions> appRestrictions = SharedPrefsHelper.getSetAppRestrictions(this, Utils.notNullStr(call.arguments()));
                updateTrackerServiceRestrictions(appRestrictions, null);
                result.success(true);
                break;
            }
            case "updateRestrictionsGroups": {
                HashMap<Integer, RestrictionGroup> restrictionGroups = SharedPrefsHelper.getSetRestrictionGroups(this, Utils.notNullStr(call.arguments()));
                updateTrackerServiceRestrictions(null, restrictionGroups);
                result.success(true);
                break;
            }
            case "updateInternetBlockedApps": {
                HashSet<String> blockedApps = JsonDeserializer.jsonStrToStringHashSet(Utils.notNullStr(call.arguments()));
                if (mVpnServiceConn.isConnected()) {
                    mVpnServiceConn.getService().updateBlockedApps(blockedApps);
                } else if (!blockedApps.isEmpty() && getAndAskVpnPermission(false)) {
                    mVpnServiceConn.setOnConnectedCallback(service -> service.updateBlockedApps(blockedApps));
                    mVpnServiceConn.startAndBind();
                }
                result.success(true);
                break;
            }
            case "updateWellBeingSettings": {
                // NOTE: Only updating shared prefs because accessibility service have onSharedPrefsChange listener registered which will eventually reload needed data
                SharedPrefsHelper.getSetWellBeingSettings(this, Utils.notNullStr(call.arguments()));
                result.success(true);
                break;
            }
            case "updateBedtimeSchedule": {
                BedtimeSettings bedtimeSettings = SharedPrefsHelper.getSetBedtimeSettings(this, Utils.notNullStr(call.arguments()));
                if (bedtimeSettings.isScheduleOn) {
                    AlarmTasksSchedulingHelper.scheduleBedtimeRoutineTasks(this, bedtimeSettings);
                } else {
                    AlarmTasksSchedulingHelper.cancelBedtimeRoutineTasks(this);
                    if (bedtimeSettings.shouldStartDnd) {
                        NotificationHelper.toggleDnd(this, false);
                    }
                }
                result.success(true);
                break;
            }
            case "activeEmergencyPause": {
                if (!Utils.isServiceRunning(this, EmergencyPauseService.class.getName())
                        && Utils.isServiceRunning(this, MindfulTrackerService.class.getName())
                ) {
                    startService(new Intent(getApplicationContext(), EmergencyPauseService.class).setAction(ACTION_START_MINDFUL_SERVICE));
                    result.success(true);
                } else {
                    result.success(false);
                }
                break;
            }
            case "updateFocusSession": {
                FocusSession focusSession = new FocusSession(Utils.notNullStr(call.arguments()));
                if (mFocusServiceConn.isConnected()) {
                    mFocusServiceConn.getService().updateFocusSession(focusSession);
                } else {
                    mFocusServiceConn.setOnConnectedCallback(service -> service.startFocusSession(focusSession));
                    mFocusServiceConn.startAndBind();
                }
                result.success(true);
                break;
            }
            case "giveUpOrFinishFocusSession": {
                if (mFocusServiceConn.isConnected()) {
                    mFocusServiceConn.getService().giveUpOrStopFocusSession(Boolean.TRUE.equals(call.arguments()));
                    mFocusServiceConn.unBindService();
                }
                result.success(true);
                break;
            }
            case "updateDistractingNotificationApps": {
                HashSet<String> distractingApps = JsonDeserializer.jsonStrToStringHashSet(Utils.notNullStr(call.arguments()));
                if (mNotificationServiceConn.isConnected()) {
                    mNotificationServiceConn.getService().updateDistractingApps(distractingApps);
                } else if (!distractingApps.isEmpty()) {
                    mNotificationServiceConn.setOnConnectedCallback(service -> service.updateDistractingApps(distractingApps));
                    mNotificationServiceConn.bindService();
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
            case "getAndAskAdminPermission": {
//                Intent intent = new Intent(Settings.ACTION_NOTIFICATION_LISTENER_SETTINGS);
//                startActivity(intent);
                result.success(PermissionsHelper.getAndAskAdminPermission(this, Boolean.TRUE.equals(call.arguments())));
                break;
            }
            case "getAndAskIgnoreBatteryOptimizationPermission": {
                result.success(PermissionsHelper.getAndAskIgnoreBatteryOptimizationPermission(this, Boolean.TRUE.equals(call.arguments())));
                break;
            }
            case "getAndAskDisplayOverlayPermission": {
                result.success(PermissionsHelper.getAndAskDisplayOverlayPermission(this, Boolean.TRUE.equals(call.arguments())));
                break;
            }
            case "getAndAskExactAlarmPermission": {
                result.success(PermissionsHelper.getAndAskExactAlarmPermission(this, Boolean.TRUE.equals(call.arguments())));
                break;
            }
            case "getAndAskVpnPermission": {
                result.success(getAndAskVpnPermission(Boolean.TRUE.equals(call.arguments())));
                break;
            }
            case "disableDeviceAdmin": {
                NewActivitiesLaunchHelper.disableDeviceAdmin(this);
                result.success(true);
                break;
            }

            // SECTION: New Activity Launch methods ------------------------------------------------------
            case "openAppWithPackage": {
                NewActivitiesLaunchHelper.openAppWithPackage(this, Utils.notNullStr(call.arguments()));
                result.success(true);
                break;
            }
            case "openAppSettingsForPackage": {
                NewActivitiesLaunchHelper.openSettingsForPackage(this, Utils.notNullStr(call.arguments()));
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
            // SECTION: Utility methods ---------------------------------------------------------------------------
            case "restartApp": {
                NewActivitiesLaunchHelper.restartMindful(this);
                result.success(true);
                break;
            }
            case "launchUrl": {
                NewActivitiesLaunchHelper.launchUrl(this, Utils.notNullStr(call.arguments()));
                result.success(true);
                break;
            }
            case "parseHostFromUrl": {
                result.success(call.arguments() == null ? "" : Utils.parseHostNameFromUrl(call.arguments()));
                break;
            }
            default:
                result.notImplemented();
        }
    }


    /**
     * Updates app and group restrictions in the tracker service.
     * If the service is connected, sends updates directly; otherwise,
     * sets a callback to update once the connection is established and starts the service.
     *
     * @param appRestrictions   a map of app package names to their respective restrictions,
     *                          or null if only group restrictions are being updated.
     * @param restrictionGroups a map of restriction group IDs to their respective restrictions,
     *                          or null if only app-specific restrictions are being updated.
     */
    private void updateTrackerServiceRestrictions(
            @Nullable HashMap<String, AppRestrictions> appRestrictions,
            @Nullable HashMap<Integer, RestrictionGroup> restrictionGroups
    ) {
        if (mTrackerServiceConn.isConnected()) {
            mTrackerServiceConn.getService().updateRestrictionData(appRestrictions, restrictionGroups);
        } else if ((appRestrictions != null && !appRestrictions.isEmpty())
                || (restrictionGroups != null && !restrictionGroups.isEmpty())
        ) {
            mTrackerServiceConn.setOnConnectedCallback(service -> service.updateRestrictionData(appRestrictions, restrictionGroups));
            mTrackerServiceConn.startAndBind();
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
        if (askPermissionToo && intent != null && mVpnPermissionLauncher != null) {
            mVpnPermissionLauncher.launch(intent);
        }
        return intent == null;
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();

        // Unbind services
        mTrackerServiceConn.unBindService();
        mNotificationServiceConn.unBindService();
        mVpnServiceConn.unBindService();
        mFocusServiceConn.unBindService();
    }
}
