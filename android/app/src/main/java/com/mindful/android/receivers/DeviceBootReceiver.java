package com.mindful.android.receivers;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

import androidx.annotation.NonNull;

import com.mindful.android.generics.SafeServiceConnection;
import com.mindful.android.helpers.AlarmTasksSchedulingHelper;
import com.mindful.android.helpers.SharedPrefsHelper;
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
        if (!SharedPrefsHelper.fetchAppTimers(context).isEmpty()) {
            SafeServiceConnection<MindfulTrackerService> mTrackerServiceConn = new SafeServiceConnection<>(MindfulTrackerService.class, context);
            mTrackerServiceConn.startOnly(MindfulTrackerService.ACTION_START_SERVICE_TIMER_MODE);
        }

        // Start the MindfulVpnService if needed
        if (!SharedPrefsHelper.fetchBlockedApps(context).isEmpty() && MindfulVpnService.prepare(context) == null) {
            SafeServiceConnection<MindfulVpnService> mVpnServiceConn = new SafeServiceConnection<>(MindfulVpnService.class, context);
            mVpnServiceConn.startOnly(MindfulVpnService.ACTION_START_SERVICE_VPN);
        }

        // Reschedule bedtime workers if the bedtime schedule is on
        if (isBedtimeScheduleOn) AlarmTasksSchedulingHelper.scheduleBedtimeStartTask(context);

        // Reschedule midnight reset worker
        AlarmTasksSchedulingHelper.scheduleMidnightResetTask(context, false);
    }
}
