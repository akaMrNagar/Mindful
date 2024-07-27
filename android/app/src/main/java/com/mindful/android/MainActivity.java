package com.mindful.android;

import android.content.Intent;
import android.provider.Settings;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.NonNull;

import com.mindful.android.generics.SafeServiceConnection;
import com.mindful.android.helpers.ActivityNewTaskHelper;
import com.mindful.android.helpers.DeviceAppsHelper;
import com.mindful.android.helpers.NotificationHelper;
import com.mindful.android.helpers.PermissionsHelper;
import com.mindful.android.helpers.SharedPrefsHelper;
import com.mindful.android.helpers.WorkersHelper;
import com.mindful.android.models.BedtimeSettings;
import com.mindful.android.services.EmergencyTimerService;
import com.mindful.android.services.MindfulTrackerService;
import com.mindful.android.services.MindfulVpnService;
import com.mindful.android.utils.AppConstants;
import com.mindful.android.utils.Utils;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity implements MethodChannel.MethodCallHandler {

    private static final String TAG = "Mindful.MainActivity";
    private SafeServiceConnection<MindfulTrackerService> mTrackerServiceConn;
    private SafeServiceConnection<MindfulVpnService> mVpnServiceConn;

    @Override
    protected void onStart() {
        super.onStart();
        // Register notification channels
        NotificationHelper.registerNotificationGroupAndChannels(this);

        // Schedule or update midnight 12 worker
        WorkersHelper.scheduleMidnightWorker(this);

        // Initialize service connections
        mTrackerServiceConn = new SafeServiceConnection<>(MindfulTrackerService.class, this);
        mVpnServiceConn = new SafeServiceConnection<>(MindfulVpnService.class, this);

        // Start or bind the tracking service based on app timers or bedtime schedule
        if (!SharedPrefsHelper.fetchAppTimers(this).isEmpty() || SharedPrefsHelper.fetchBedtimeSettings(this).isScheduleOn) {
            mTrackerServiceConn.startAndBind();
        } else {
            mTrackerServiceConn.bindService();
        }

        // Start or bind the VPN service based on blocked apps and VPN permissions
        if (!SharedPrefsHelper.fetchBlockedApps(this).isEmpty() && getAndAskVpnPermission(false)) {
            mVpnServiceConn.startAndBind();
        } else {
            mVpnServiceConn.bindService();
        }
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
            case "getDeviceApps": {
                DeviceAppsHelper.getDeviceApps(this, result);
                break;
            }
            case "getShortsScreenTimeMs": {
                result.success(SharedPrefsHelper.fetchShortsScreenTimeMs(this));
                break;
            }
            case "showToast": {
                showToast(call);
                result.success(true);
                break;
            }
            case "parseHostFromUrl": {
                result.success(call.arguments() == null ? "" : Utils.parseHostNameFromUrl(call.arguments()));
                break;
            }
            case "setDataResetTime": {
                SharedPrefsHelper.storeDataResetTimeMins(this, call.arguments() == null ? 0 : (int) call.arguments());
                result.success(true);
                break;
            }
            case "launchUrl": {
                ActivityNewTaskHelper.launchUrl(this, Utils.notNullStr(call.arguments()));
                result.success(true);
                break;
            }

            // SECTION: Foreground service and Worker methods ---------------------------------------------------------------------------
            case "updateAppTimers": {
                String dartJsonAppTimers = Utils.notNullStr(call.arguments());
                SharedPrefsHelper.storeAppTimersJson(this, dartJsonAppTimers);  // Cache app timers json string to shared prefs
                if (mTrackerServiceConn.isConnected()) {
                    mTrackerServiceConn.getService().updateAppTimers();
                } else {
                    mTrackerServiceConn.startAndBind();
                }
                result.success(true);
                break;
            }
            case "updateBlockedApps": {
                String blockedAppsJson = Utils.notNullStr(call.arguments());
                SharedPrefsHelper.storeBlockedAppsJson(this, blockedAppsJson);  // Cache blocked apps json string to shared prefs
                if (mVpnServiceConn.isConnected()) {
                    mVpnServiceConn.getService().updateBlockedApps();
                } else if (getAndAskVpnPermission(true)) {
                    mVpnServiceConn.startAndBind();
                }
                result.success(true);
                break;
            }
            case "updateBedtimeSchedule": {
                String dartJsonBedtimeSettings = Utils.notNullStr(call.arguments());
                SharedPrefsHelper.storeBedtimeSettingsJson(this, dartJsonBedtimeSettings);  // Cache bedtime settings json string to shared pref
                BedtimeSettings bedtimeSettings = new BedtimeSettings(dartJsonBedtimeSettings);
                if (bedtimeSettings.isScheduleOn) {
                    WorkersHelper.scheduleBedtimeRoutine(this);
                    mTrackerServiceConn.startAndBind(); // Start service if it is not already running
                } else {
                    WorkersHelper.cancelBedtimeRoutine(this);
                    if (mTrackerServiceConn.isConnected()) {
                        mTrackerServiceConn.getService().startStopBedtimeLockdown(false, null);
                        mTrackerServiceConn.getService().stopIfNoUsage();
                    }
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
                startService(new Intent(this, EmergencyTimerService.class));
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
                result.success(PermissionsHelper.getAndAskAdminPermission(this, Boolean.TRUE.equals(call.arguments())));
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

            // SECTION: New Activity Launch methods ------------------------------------------------------
            case "openAppWithPackage": {
                ActivityNewTaskHelper.openAppWithPackage(this, call.arguments());
                result.success(true);
                break;
            }
            case "openAppSettingsForPackage": {
                ActivityNewTaskHelper.openSettingsForPackage(this, call.arguments());
                result.success(true);
                break;
            }
            case "openDeviceDndSettings": {
                ActivityNewTaskHelper.openDeviceDndSettings(this);
                result.success(true);
                break;
            }
            default:
                result.notImplemented();
        }
    }

    /**
     * Requests VPN permission if needed.
     *
     * @param askPermissionToo Whether to ask for permission if not already granted.
     * @return True if permission is already granted, false otherwise.
     */
    private boolean getAndAskVpnPermission(boolean askPermissionToo) {
        Intent intent = MindfulVpnService.prepare(this);
        if (askPermissionToo && intent != null) {
            startActivityForResult(intent, 0);
        }
        return intent == null;
    }

    /**
     * Requests display overlay permission if needed.
     *
     * @param askPermissionToo Whether to ask for permission if not already granted.
     * @return True if permission is already granted, false otherwise.
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
    }

    /**
     * Shows a toast message.
     *
     * @param call The method call containing the message and duration.
     */
    private void showToast(@NonNull MethodCall call) {
        String msg = call.argument("message");
        Integer duration = call.argument("duration");

        if (msg == null || duration == null) {
            Log.w(TAG, "showToast: Method called with null arguments");
            return;
        }

        Toast.makeText(this, msg, duration).show();
    }
}
