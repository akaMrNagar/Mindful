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
import com.akamrnagar.mindful.helpers.ServicesHelper;
import com.akamrnagar.mindful.helpers.WorkersHelper;
import com.akamrnagar.mindful.services.MindfulAccessibilityService;
import com.akamrnagar.mindful.services.MindfulTrackerService;
import com.akamrnagar.mindful.services.MindfulVpnService;
import com.akamrnagar.mindful.utils.AppConstants;
import com.akamrnagar.mindful.utils.Utils;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.util.PathUtils;

public class MainActivity extends FlutterActivity implements MethodChannel.MethodCallHandler {
    private static final String TAG = "Mindful.MainActivity";
    private final SafeServiceConnection<MindfulTrackerService> mTrackerServiceConn = new SafeServiceConnection<>(MindfulTrackerService.class);
    private final SafeServiceConnection<MindfulVpnService> mVpnServiceConn = new SafeServiceConnection<>(MindfulVpnService.class);


    @Override
    protected void onStart() {
        super.onStart();
        // Register notification channels
        NotificationHelper.registerNotificationChannels(this);

        // Bind to services if already running
        mTrackerServiceConn.bindService(this);
        mVpnServiceConn.bindService(this);
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        MethodChannel channel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), AppConstants.FLUTTER_METHOD_CHANNEL);
        channel.setMethodCallHandler(this);

        /// Check if user launched the app from TLE dialog then go to app dashboard screen for that update targeted app
        String appPackage = getIntent().getStringExtra("appPackage");
        if (appPackage != null && !appPackage.isEmpty()) {
            channel.invokeMethod("updateTargetedApp", appPackage);
        }
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            // Utility calls -----------------------------------------------------------------------
            case "getAppDirectoryPath":
                result.success(PathUtils.getDataDirectory(this));
                break;
            case "getDeviceApps":
                DeviceAppsHelper.getDeviceApps(this, result);
                break;
            case "showToast":
                showToast(call);
                result.success(true);
                break;
            case "parseUrl":
                result.success(call.arguments() == null ? "" : Utils.parseHostNameFromUrl(call.arguments()));
                break;

            // Accessibility service calls -----------------------------------------------------------------
            case "isAccessibilityServiceRunning":
                result.success(ServicesHelper.isServiceRunning(this, MindfulAccessibilityService.class.getName()));
                break;
            case "startAccessibilityService":
                ActivityNewTaskHelper.openMindfulAccessibilitySection(this);
                result.success(true);
                break;

            // Vpn service calls ---------------------------------------------------------------------------
            case "isVpnServiceRunning":
                result.success(ServicesHelper.isServiceRunning(this, MindfulVpnService.class.getName()));
                break;
            case "startVpnService":
                if (prepareVpn()) mVpnServiceConn.startAndBind(this);
                result.success(true);
                break;
            case "stopVpnService":
                mVpnServiceConn.stopAndUnBind(this);
                result.success(true);
                break;
            case "flagVpnRestart":
                if (mVpnServiceConn.isConnected()) {
                    mVpnServiceConn.getService().flagVpnServiceRestart();
                }
                result.success(true);
                break;

            // Tracking service calls ------------------------------------------------------------------
            case "tryToStopTrackingService":
                tryToStopTrackingService();
                result.success(true);
                break;
            case "refreshAppTimers":
                if (mTrackerServiceConn.isConnected()) {
                    mTrackerServiceConn.getService().refreshAppTimers();
                } else {
                    mTrackerServiceConn.startAndBind(this);
                }
                result.success(true);
                break;

            // Bedtime schedule routine calls ------------------------------------------------------
            case "scheduleBedtimeRoutine":
                WorkersHelper.scheduleBedtimeRoutine(this, call);
                mTrackerServiceConn.startAndBind(this);
//                startStopBindUnbindTrackerService(true, true);
                result.success(true);
                break;
            case "cancelBedtimeRoutine":
                WorkersHelper.cancelBedtimeRoutine(this);
                // TODO: what if the schedule is running and user cancels it, but apps remains paused and blocked
                tryToStopTrackingService();
                result.success(true);
                break;


            // Permissions handler calls ------------------------------------------------------
            case "getAndAskDndPermission":
                result.success(PermissionsHelper.getAndAskDndPermission(this));
                break;
            case "getAndAskUsageStatesPermission":
                result.success(PermissionsHelper.getAndAskUsageStatesPermission(this));
                break;
            case "getAndAskDisplayOverlayPermission":
                result.success(PermissionsHelper.getAndAskDisplayOverlayPermission());
                break;
            case "getAndAskBatteryOptimizationPermission":
                result.success(PermissionsHelper.getAndAskBatteryOptimizationPermission());
                break;

            // New Activity Launch  calls ------------------------------------------------------
            case "openAppWithPackage":
                ActivityNewTaskHelper.openAppWithPackage(this, call.arguments());
                result.success(true);
                break;
            case "openAppSettingsForPackage":
                ActivityNewTaskHelper.openAppSettingsForPackage(this, call.arguments());
                result.success(true);
                break;
            case "openDeviceDndSettings":
                ActivityNewTaskHelper.openDeviceDndSettings(this);
                result.success(true);
                break;
            default:
                result.notImplemented();
        }

    }

    private boolean prepareVpn() {
        Intent intent = MindfulVpnService.prepare(this);
        if (intent == null) {
            return true;
        } else {
            startActivityForResult(intent, 0);
            return false;
        }

    }

    private void tryToStopTrackingService() {
        if (mTrackerServiceConn.isConnected() && mTrackerServiceConn.getService().canStopTrackingService()) {
            mTrackerServiceConn.stopAndUnBind(this);
        }
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
