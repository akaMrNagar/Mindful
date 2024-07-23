package com.mindful.android.receivers;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

import androidx.annotation.NonNull;

import com.mindful.android.generics.SafeServiceConnection;
import com.mindful.android.helpers.SharedPrefsHelper;
import com.mindful.android.helpers.WorkersHelper;
import com.mindful.android.services.MindfulTrackerService;
import com.mindful.android.services.MindfulVpnService;

/**
 * BroadcastReceiver that handles actions after the device boots up.
 */
public class DeviceBootReceiver extends BroadcastReceiver {
    private static final String TAG = "Mindful.DeviceBootReceiver";

    @Override
    public void onReceive(Context context, @NonNull Intent intent) {
        // Check if the received intent action is related to device boot completion
        if (!Intent.ACTION_BOOT_COMPLETED.equals(intent.getAction())) return;

        Log.d(TAG, "onReceive: Device reboot broadcast received. Now doing the needful");

        // Fetch bedtime settings to check if the bedtime schedule is on
        boolean isBedtimeScheduleOn = SharedPrefsHelper.fetchBedtimeSettings(context).isScheduleOn;

        // Start the MindfulTrackerService if needed
        if (!SharedPrefsHelper.fetchAppTimers(context).isEmpty() || isBedtimeScheduleOn) {
            SafeServiceConnection<MindfulTrackerService> mTrackerServiceConn = new SafeServiceConnection<>(MindfulTrackerService.class, context);
            mTrackerServiceConn.startOnly();
        }

        // Start the MindfulVpnService if needed
        if (!SharedPrefsHelper.fetchBlockedApps(context).isEmpty() && MindfulVpnService.prepare(context) == null) {
            SafeServiceConnection<MindfulVpnService> mVpnServiceConn = new SafeServiceConnection<>(MindfulVpnService.class, context);
            mVpnServiceConn.startOnly();
        }

        // NOTE: Workers are rescheduled by WorkManager automatically on device reboot.
        //  We are rescheduling only because user may be rebooting device during the schedule period so to block distracting apps
        //  Reschedule bedtime workers if needed.

        // Reschedule bedtime workers if the bedtime schedule is on
        if (isBedtimeScheduleOn) {
            WorkersHelper.scheduleBedtimeRoutine(context);
        }
    }
}
