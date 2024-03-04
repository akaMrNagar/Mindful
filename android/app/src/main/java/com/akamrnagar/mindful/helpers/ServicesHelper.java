package com.akamrnagar.mindful.helpers;

import android.app.ActivityManager;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.IBinder;

import androidx.annotation.NonNull;

import com.akamrnagar.mindful.services.AppsTrackerService;
import com.akamrnagar.mindful.services.MindfulVpnService;

public class ServicesHelper {

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

    public static void startTrackingService(Context context) {
        if (!isServiceRunning(context, AppsTrackerService.class.getName())) {
            context.startService(new Intent(context, AppsTrackerService.class).setAction(AppsTrackerService.ACTION_START_SERVICE));
        }
    }

    public static void stopTrackingService(Context context) {
        if (isServiceRunning(context, AppsTrackerService.class.getName())) {
            context.startService(new Intent(context, AppsTrackerService.class).setAction(AppsTrackerService.ACTION_STOP_SERVICE));
        }
    }


    public static void startVpnService(Context context) {
        if (!isServiceRunning(context, MindfulVpnService.class.getName())) {
            context.startService(new Intent(context, MindfulVpnService.class).setAction(MindfulVpnService.ACTION_START_SERVICE));
        }
    }

    public static void stopVpnService(Context context) {
        if (isServiceRunning(context, MindfulVpnService.class.getName())) {
            context.startService(new Intent(context, MindfulVpnService.class).setAction(MindfulVpnService.ACTION_STOP_SERVICE));
        }
    }

    /**
     * Checks if a service with the given class name is currently running.
     *
     * @param context          The application context.
     * @param serviceClassName The name of the service class (e.g., MindfulAppsTrackerService.class.getName()).
     * @return True if the service is running, false otherwise.
     */
    public static boolean isServiceRunning(@NonNull Context context, String serviceClassName) {
        boolean isServiceRunning = false;

        ActivityManager activityManager = (ActivityManager) context.getSystemService(Context.ACTIVITY_SERVICE);
        for (ActivityManager.RunningServiceInfo serviceInfo : activityManager.getRunningServices(Integer.MAX_VALUE)) {
            if (serviceInfo.service.getClassName().equals(serviceClassName)) {
                return true;
            }
        }
        return isServiceRunning;
    }
}
