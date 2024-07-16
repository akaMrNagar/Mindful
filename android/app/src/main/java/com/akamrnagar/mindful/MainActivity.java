package com.akamrnagar.mindful;

import android.content.Intent;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.NonNull;

import com.akamrnagar.mindful.generics.SafeServiceConnection;
import com.akamrnagar.mindful.helpers.ActivityNewTaskHelper;
import com.akamrnagar.mindful.helpers.DeviceAppsHelper;
import com.akamrnagar.mindful.helpers.NotificationHelper;
import com.akamrnagar.mindful.helpers.PermissionsHelper;
import com.akamrnagar.mindful.helpers.SharedPrefsHelper;
import com.akamrnagar.mindful.helpers.WorkersHelper;
import com.akamrnagar.mindful.models.BedtimeSettings;
import com.akamrnagar.mindful.services.MindfulTrackerService;
import com.akamrnagar.mindful.services.MindfulVpnService;
import com.akamrnagar.mindful.utils.AppConstants;
import com.akamrnagar.mindful.utils.Utils;

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
        NotificationHelper.registerNotificationChannels(this);

        // Initialize service connections
        mTrackerServiceConn = new SafeServiceConnection<>(MindfulTrackerService.class, this);
        mVpnServiceConn = new SafeServiceConnection<>(MindfulVpnService.class, this);

        // Start the tracking service if a timer is set or a bedtime schedule is active otherwise, attempt to bind if the service is already running
        if (!SharedPrefsHelper.fetchAppTimers(this).isEmpty() || SharedPrefsHelper.fetchBedtimeSettings(this).isScheduleOn) {
            mTrackerServiceConn.startAndBind(this);
        } else {
            mTrackerServiceConn.bindService(this);
        }

        // Start the vpn service if any app is blocked otherwise, attempt to bind if the service is already running
        if (!SharedPrefsHelper.fetchBlockedApps(this).isEmpty() && getAndAskVpnPermission(false)) {
            mVpnServiceConn.startAndBind(this);
        } else {
            mVpnServiceConn.bindService(this);
        }
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        MethodChannel mMethodChannel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), AppConstants.FLUTTER_METHOD_CHANNEL);
        mMethodChannel.setMethodCallHandler(this);

        /// Check if user launched the app from TLE dialog then go to app dashboard screen for that update targeted app
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
            case "showToast": {
                showToast(call);
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
                SharedPrefsHelper.storeAppTimers(this, dartJsonAppTimers);  // Cache app timers json string to shared prefs
                if (mTrackerServiceConn.isConnected()) {
                    mTrackerServiceConn.getService().updateAppTimers();
                } else {
                    mTrackerServiceConn.startAndBind(this);
                }
                result.success(true);
                break;
            }
            case "updateBlockedApps": {
                String blockedAppsJson = Utils.notNullStr(call.arguments());
                SharedPrefsHelper.storeBlockedApps(this, blockedAppsJson);  // Cache blocked apps json string to shared prefs
                if (mVpnServiceConn.isConnected()) {
                    mVpnServiceConn.getService().updateBlockedApps();
                } else if (getAndAskVpnPermission(true)) {
                    mVpnServiceConn.startAndBind(this);
                }
                result.success(true);
                break;
            }
            case "updateBedtimeSchedule": {
                String dartJsonBedtimeSettings = Utils.notNullStr(call.arguments());
                SharedPrefsHelper.storeBedtimeSettings(this, dartJsonBedtimeSettings);  // Cache bedtime settings json string to shared pref
                BedtimeSettings bedtimeSettings = new BedtimeSettings(dartJsonBedtimeSettings);
                if (bedtimeSettings.isScheduleOn) {
                    WorkersHelper.scheduleBedtimeRoutine(this);
                    mTrackerServiceConn.startAndBind(this); // This will only start service if it is already not running
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
                SharedPrefsHelper.storeWellBeingSettings(this, Utils.notNullStr(call.arguments()));
                break;
            }

            // SECTION: Permissions handler methods ------------------------------------------------------
            case "getAndAskAccessibilityPermission": {
                result.success(PermissionsHelper.getAndAskAccessibilityPermission(this, Boolean.TRUE.equals(call.arguments())));
                break;
            }
            case "getAndAskVpnPermission": {
                result.success(getAndAskVpnPermission(Boolean.TRUE.equals(call.arguments())));
                break;
            }
            case "getAndAskDndPermission": {
                result.success(PermissionsHelper.getAndAskDndPermission(this, Boolean.TRUE.equals(call.arguments())));
                break;
            }
            case "getAndAskUsageStatesPermission": {
                result.success(PermissionsHelper.getAndAskUsageStatesPermission(this, Boolean.TRUE.equals(call.arguments())));
                break;
            }
            case "getAndAskDisplayOverlayPermission": {
                result.success(PermissionsHelper.getAndAskDisplayOverlayPermission(this, Boolean.TRUE.equals(call.arguments())));
                break;
            }
            case "getAndAskBatteryOptimizationPermission": {
                result.success(PermissionsHelper.getAndAskBatteryOptimizationPermission(this, Boolean.TRUE.equals(call.arguments())));
                break;
            }
            case "getAndAskAdminPermission": {
                result.success(PermissionsHelper.getAndAskAdminPermission(this, Boolean.TRUE.equals(call.arguments())));
                break;
            }

            // SECTION: New Activity Launch methods ------------------------------------------------------
            case "openAppWithPackage": {
                ActivityNewTaskHelper.openAppWithPackage(this, call.arguments());
                result.success(true);
                break;
            }
            case "openAppSettingsForPackage": {
                ActivityNewTaskHelper.openAppSettingsForPackage(this, call.arguments());
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


    private boolean getAndAskVpnPermission(boolean askPermissionToo) {
        Intent intent = MindfulVpnService.prepare(this);
        if (askPermissionToo && intent != null) {
            startActivityForResult(intent, 0);
        }
        return intent == null;
    }


    @Override
    protected void onStop() {
        super.onStop();

        // Let VPN service know that it can restart if needed as App is stopping
        if (mVpnServiceConn.isConnected()) {
            mVpnServiceConn.getService().onApplicationStop();
        }

        /// Unbind services
        mTrackerServiceConn.unBindService(this);
        mVpnServiceConn.unBindService(this);
    }

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
