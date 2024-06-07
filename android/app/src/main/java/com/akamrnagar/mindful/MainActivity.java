package com.akamrnagar.mindful;

import android.app.Activity;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.IBinder;
import android.util.Log;
import android.widget.Toast;

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
    private static String TAG = "Mindful.MainActivity";
    private MindfulTrackerService mTrackerService = null;
    private final ServiceConnection mTrackerServiceConnection = new ServiceConnection() {

        @Override
        public void onServiceConnected(ComponentName className, IBinder binder) {
            MindfulTrackerService.TrackerServiceBinder serviceBinder = (MindfulTrackerService.TrackerServiceBinder) binder;
            mTrackerService = serviceBinder.getService();
            Log.d(TAG, "onServiceConnected: Tracker service bounded");
        }

        @Override
        public void onServiceDisconnected(ComponentName arg0) {
            mTrackerService = null;
        }
    };
    private MindfulVpnService mVpnService = null;
    private final ServiceConnection mVpnServiceConnection = new ServiceConnection() {
        @Override
        public void onServiceConnected(ComponentName className, IBinder binder) {
            MindfulVpnService.VpnServiceBinder serviceBinder = (MindfulVpnService.VpnServiceBinder) binder;
            mVpnService = serviceBinder.getService();
            Log.d(TAG, "onServiceConnected: Vpn service bounded");
        }

        @Override
        public void onServiceDisconnected(ComponentName arg0) {
            mVpnService = null;
        }
    };

    @Override
    protected void onStart() {
        super.onStart();
        // Register notification channels
        NotificationHelper.registerNotificationChannels(this);

        // Bind to services if already running
        startStopBindUnbindVpnService(true, false);
        startStopBindUnbindTrackerService(true, false);
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
            case "isVpnServiceRunning":
                result.success(ServicesHelper.isServiceRunning(this, MindfulVpnService.class.getName()));
                break;
            case "startVpnService":
                prepareAndStartVpnService();
                result.success(true);
                break;
            case "stopVpnService":
                startStopBindUnbindVpnService(false, true);
                result.success(true);
                break;
            case "refreshVpnService":
                if (mVpnService != null) mVpnService.flagNeedDataReload();
                result.success(true);
                break;
            case "refreshTrackerService":
                if (mTrackerService != null) mTrackerService.flagNeedDataReload();
                else startStopBindUnbindTrackerService(true, true);
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
            case "showToast":
                showToast(call);
                result.success(true);
                break;
            default:
                result.notImplemented();
        }

    }

    private void prepareAndStartVpnService() {
        Intent intent = MindfulVpnService.prepare(this);
        if (intent != null) {
            startActivityForResult(intent, 0);
        } else {
            /// Manually call if vpn is already configured
            onActivityResult(MindfulVpnService.SERVICE_ID, Activity.RESULT_OK, null);
        }
    }

    @Override
    protected void onActivityResult(int request, int result, Intent data) {
        if (result == Activity.RESULT_OK && request == MindfulVpnService.SERVICE_ID) {
            startStopBindUnbindVpnService(true, true);
        }
    }

    private void startStopBindUnbindVpnService(boolean shouldBind, boolean interfereService) {
        if (shouldBind && mVpnService == null) {
            if (interfereService) ServicesHelper.startVpnService(this);

            // Bind to service if it is running
            if (ServicesHelper.isServiceRunning(this, MindfulVpnService.class.getName())) {
                Intent intent = new Intent(this, MindfulVpnService.class);
                bindService(intent, mVpnServiceConnection, Context.BIND_ADJUST_WITH_ACTIVITY);
            }
        } else if (!shouldBind && mVpnService != null) {
            unbindService(mVpnServiceConnection);
            if (interfereService) ServicesHelper.stopVpnService(this);
            mVpnService = null;
        }
    }

    private void startStopBindUnbindTrackerService(boolean shouldBind, boolean interfereService) {
        if (shouldBind && mTrackerService == null) {
            if (interfereService) ServicesHelper.startTrackingService(this);

            // Bind to service if it is running
            if (ServicesHelper.isServiceRunning(this, MindfulTrackerService.class.getName())) {
                Intent intent = new Intent(this, MindfulTrackerService.class);
                bindService(intent, mTrackerServiceConnection, Context.BIND_ADJUST_WITH_ACTIVITY);
            }
        } else if (!shouldBind && mTrackerService != null) {
            unbindService(mTrackerServiceConnection);
            if (interfereService) ServicesHelper.stopTrackingService(this);
            mTrackerService = null;
        }
    }

    @Override
    protected void onStop() {
        super.onStop();

        // Let service know that app is stopping and going to background
        if (mTrackerService != null) mTrackerService.onApplicationStop();
        if (mVpnService != null) mVpnService.onApplicationStop();

        // Unbind services
        startStopBindUnbindVpnService(false, false);
        startStopBindUnbindTrackerService(false, false);
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
