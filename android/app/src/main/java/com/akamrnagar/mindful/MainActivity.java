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
import com.akamrnagar.mindful.helpers.WorkerTasksHelper;
import com.akamrnagar.mindful.services.MindfulTrackerService;
import com.akamrnagar.mindful.services.MindfulVpnService;
import com.akamrnagar.mindful.utils.AppConstants;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.util.PathUtils;

public class MainActivity extends FlutterActivity implements MethodChannel.MethodCallHandler {
    private MindfulTrackerService mTrackerService;
    private final ServiceConnection mTrackerServiceConnection = new ServiceConnection() {

        @Override
        public void onServiceConnected(ComponentName className, IBinder binder) {
            MindfulTrackerService.TrackerServiceBinder serviceBinder = (MindfulTrackerService.TrackerServiceBinder) binder;
            mTrackerService = serviceBinder.getService();
            mIsBound = true;
        }

        @Override
        public void onServiceDisconnected(ComponentName arg0) {
            mIsBound = false;
        }
    };
    private boolean mIsBound = false;


    @Override
    protected void onStart() {
        super.onStart();
        NotificationHelper.registerNotificationChannels(this);
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
            case "getAppDirectoryPath":
                result.success(PathUtils.getDataDirectory(this));
                break;
            case "getDeviceApps":
                DeviceAppsHelper.getDeviceApps(this, result);
                break;
            case "refreshTrackerService":
                refreshTrackerService();
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
            case "scheduleBedtimeTask":
                WorkerTasksHelper.scheduleBedtimeTask(this, call);
                result.success(true);
                break;
            case "cancelBedtimeTask":
                WorkerTasksHelper.cancelBedtimeTask(this);
                result.success(true);
                break;
            case "runAm":
                ServicesHelper.startTrackingService(this);
                break;
            default:
                result.notImplemented();
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

    @Override
    protected void onActivityResult(int request, int result, Intent data) {
        if (result == Activity.RESULT_OK && request == MindfulVpnService.SERVICE_ID) {
            ServicesHelper.startVpnService(this);
        }
    }

    private void refreshTrackerService() {
        /// Called only for first time
        if (!mIsBound || mTrackerService == null) {
            ServicesHelper.startTrackingService(this);
            Intent intent = new Intent(this, MindfulTrackerService.class);
            bindService(intent, mTrackerServiceConnection, Context.BIND_ADJUST_WITH_ACTIVITY);
        } else {
            mTrackerService.refreshService();
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        if (mIsBound) {
            unbindService(mTrackerServiceConnection);
            mIsBound = false;
        }
    }
}
