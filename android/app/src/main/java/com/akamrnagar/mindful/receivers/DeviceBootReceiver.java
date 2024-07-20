package com.akamrnagar.mindful.receivers;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

import androidx.annotation.NonNull;

import com.akamrnagar.mindful.generics.SafeServiceConnection;
import com.akamrnagar.mindful.helpers.SharedPrefsHelper;
import com.akamrnagar.mindful.helpers.WorkersHelper;
import com.akamrnagar.mindful.services.MindfulTrackerService;
import com.akamrnagar.mindful.services.MindfulVpnService;

public class DeviceBootReceiver extends BroadcastReceiver {

    private static final String TAG = "Mindful.DeviceBootReceiver";

    @Override
    public void onReceive(Context context, @NonNull Intent intent) {
        if (!Intent.ACTION_BOOT_COMPLETED.equals(intent.getAction())) return;

        Log.d(TAG, "onReceive: Device reboot broadcast received. Now doing the needful");

        boolean isBedtimeScheduleOn = SharedPrefsHelper.fetchBedtimeSettings(context).isScheduleOn;

        // Start tracking service if needed
        if (!SharedPrefsHelper.fetchAppTimers(context).isEmpty() || isBedtimeScheduleOn) {
            SafeServiceConnection<MindfulTrackerService> mTrackerServiceConn = new SafeServiceConnection<>(MindfulTrackerService.class, context);
            mTrackerServiceConn.startOnly();
        }

        // Start vpn service if needed
        if (!SharedPrefsHelper.fetchBlockedApps(context).isEmpty() && MindfulVpnService.prepare(context) == null) {
            SafeServiceConnection<MindfulVpnService> mVpnServiceConn = new SafeServiceConnection<>(MindfulVpnService.class, context);
            mVpnServiceConn.startOnly();
        }

        // NOTE: Workers are rescheduled by WorkManager automatically on device reboot

        // We are rescheduling only because user may be rebooting device during the schedule period so to block distracting apps
        // Reschedule bedtime workers if needed.
        if (isBedtimeScheduleOn) {
            WorkersHelper.scheduleBedtimeRoutine(context);
        }
    }
}