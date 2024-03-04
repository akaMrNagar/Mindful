package com.akamrnagar.mindful;

import android.app.Activity;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.IBinder;

import androidx.annotation.NonNull;

import com.akamrnagar.mindful.helpers.DeviceAppsHelper;
import com.akamrnagar.mindful.helpers.NotificationHelper;
import com.akamrnagar.mindful.helpers.ServicesHelper;
import com.akamrnagar.mindful.helpers.WorkersHelper;
import com.akamrnagar.mindful.services.AppsTrackerService;
import com.akamrnagar.mindful.services.MindfulVpnService;
import com.akamrnagar.mindful.utils.AppConstants;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.util.PathUtils;

public class MainActivity extends FlutterActivity implements MethodChannel.MethodCallHandler {
    private AppsTrackerService mTrackerService;
    private boolean mIsBound = false;
    private final ServiceConnection mTrackerServiceConnection = new ServiceConnection() {
        @Override
        public void onServiceConnected(ComponentName className, IBinder binder) {
            AppsTrackerService.TrackerServiceBinder serviceBinder = (AppsTrackerService.TrackerServiceBinder) binder;
            mTrackerService = serviceBinder.getService();
            mIsBound = true;
        }

        @Override
        public void onServiceDisconnected(ComponentName arg0) {
            mIsBound = false;
        }
    };

    @Override
    protected void onStart() {
        super.onStart();
        NotificationHelper.registerNotificationChannels(this);
        refreshAppTimers();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        if (mIsBound) {
            unbindService(mTrackerServiceConnection);
            mIsBound = false;
        }
    }


    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        MethodChannel channel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), AppConstants.METHOD_CHANNEL);
        channel.setMethodCallHandler(this);

        /// Check if user launched the app from TLE dialog then go to app dashboard screen
        String appPackage = getIntent().getStringExtra("appPackage");
        if (appPackage != null && !appPackage.isEmpty()) {
            channel.invokeMethod("openAppDashboard", appPackage);
        }
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            case "getAppDirectoryPath":
                result.success(PathUtils.getDataDirectory(this));
                break;
            case "getDeviceApps":
                DeviceAppsHelper.getDeviceApps(this, result);
                break;
            case "startTrackingService":
                ServicesHelper.startTrackingService(this);
                result.success(true);
                break;
            case "stopTrackingService":
                ServicesHelper.stopTrackingService(this);
                result.success(true);
                break;
            case "startVpnService":
                prepareVpnService();
                result.success(true);
                break;
            case "stopVpnService":
                ServicesHelper.stopVpnService(this);
                result.success(true);
                break;
            case "refreshAppTimers":
                refreshAppTimers();
                result.success(true);
                break;
            case "scheduleBedtimeTask":
                WorkersHelper.scheduleBedtimeTask(this, call);
                result.success(true);
                break;
            case "cancelBedtimeTask":
                WorkersHelper.cancelBedtimeTask(this);
                result.success(true);
                break;
            default:
                result.notImplemented();
        }

    }

    @Override
    protected void onActivityResult(int request, int result, Intent data) {
        if (result == Activity.RESULT_OK && request == MindfulVpnService.SERVICE_ID) {
            ServicesHelper.startVpnService(this);
        }
    }

    private void refreshAppTimers() {
        /// Called only for first time
        if (!mIsBound || mTrackerService == null) {
            ServicesHelper.startTrackingService(this);
            Intent intent = new Intent(this, AppsTrackerService.class);
            bindService(intent, mTrackerServiceConnection, Context.BIND_ADJUST_WITH_ACTIVITY);
        } else {
            mTrackerService.refreshAppTimers();
        }
    }

    private void prepareVpnService() {
        Intent intent = android.net.VpnService.prepare(this);
        if (intent != null) {
            startActivityForResult(intent, 0);
        } else {
            onActivityResult(MindfulVpnService.SERVICE_ID, Activity.RESULT_OK, null);
        }
    }
}
