/*
 *
 *  *
 *  *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *  *
 *  *  * This source code is licensed under the GPL-2.0 license license found in the
 *  *  * LICENSE file in the root directory of this source tree.
 *  *
 *
 */

package com.mindful.android.receivers;

import android.annotation.SuppressLint;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.work.OneTimeWorkRequest;
import androidx.work.WorkManager;
import androidx.work.Worker;
import androidx.work.WorkerParameters;

import com.mindful.android.generics.SafeServiceConnection;
import com.mindful.android.helpers.AlarmTasksSchedulingHelper;
import com.mindful.android.helpers.NotificationHelper;
import com.mindful.android.helpers.SharedPrefsHelper;
import com.mindful.android.models.AppRestrictions;
import com.mindful.android.models.BedtimeSettings;
import com.mindful.android.models.RestrictionGroup;
import com.mindful.android.services.MindfulTrackerService;
import com.mindful.android.services.MindfulVpnService;
import com.mindful.android.utils.Utils;

import java.util.HashMap;
import java.util.HashSet;

/**
 * BroadcastReceiver that listens for device boot and package replacement events
 * to restart required services and reschedule any pending alarms.
 */
public class DeviceBootReceiver extends BroadcastReceiver {
    private static final String TAG = "Mindful.DeviceBootReceiver";

    @SuppressLint("UnsafeProtectedBroadcastReceiver")
    @Override
    public void onReceive(Context context, Intent intent) {
        String action = Utils.getActionFromIntent(intent);

        if (Intent.ACTION_BOOT_COMPLETED.equals(action) || Intent.ACTION_MY_PACKAGE_REPLACED.equals(action)) {
            Log.d(TAG, "onReceive: Device reboot broadcast received, initializing necessary services and tasks.");

            // Queue a one-time work request to execute BootWorker tasks
            WorkManager.getInstance(context).enqueue(new OneTimeWorkRequest.Builder(BootWorker.class).build());
        }
    }

    /**
     * Worker class to perform tasks required on device boot, such as starting services
     * and rescheduling alarms for restrictions and bedtime routines.
     */
    public static class BootWorker extends Worker {
        private final Context mContext;
        private final SafeServiceConnection<MindfulTrackerService> mTrackerServiceConn;
        private final SafeServiceConnection<MindfulVpnService> mVpnServiceConn;

        public BootWorker(@NonNull Context context, @NonNull WorkerParameters params) {
            super(context, params);
            this.mContext = context;
            this.mTrackerServiceConn = new SafeServiceConnection<>(MindfulTrackerService.class, context);
            this.mVpnServiceConn = new SafeServiceConnection<>(MindfulVpnService.class, context);
        }


        @NonNull
        @Override
        public Result doWork() {
            try {
                // Register channels before starting foreground services
                NotificationHelper.registerNotificationChannels(mContext.getApplicationContext());

                HashMap<String, AppRestrictions> appRestrictions = SharedPrefsHelper.getSetAppRestrictions(mContext, null);
                HashMap<Integer, RestrictionGroup> restrictionGroups = SharedPrefsHelper.getSetRestrictionGroups(mContext, null);

                // Collect internet-blocked apps
                HashSet<String> internetBlockedApps = new HashSet<>();
                appRestrictions.forEach((packageName, restrictions) -> {
                    if (!restrictions.canAccessInternet) internetBlockedApps.add(packageName);
                });

                // Start tracker service to update app and group restrictions
                if (!appRestrictions.isEmpty() || !restrictionGroups.isEmpty()) {
                    mTrackerServiceConn.setOnConnectedCallback(service -> service.updateRestrictionData(appRestrictions, restrictionGroups));
                    mTrackerServiceConn.startAndBind(MindfulTrackerService.ACTION_START_RESTRICTION_MODE);
                }

                // Start VPN service to apply internet restrictions on specified apps
                if (!internetBlockedApps.isEmpty() && MindfulVpnService.prepare(mContext.getApplicationContext()) == null) {
                    mVpnServiceConn.setOnConnectedCallback(service -> service.updateBlockedApps(internetBlockedApps));
                    mVpnServiceConn.startAndBind(MindfulVpnService.ACTION_START_SERVICE_VPN);
                }

                // Fetch and apply bedtime settings if enabled
                BedtimeSettings bedtimeSettings = SharedPrefsHelper.getSetBedtimeSettings(mContext, null);
                if (bedtimeSettings.isScheduleOn) {
                    AlarmTasksSchedulingHelper.scheduleBedtimeRoutineTasks(mContext, bedtimeSettings);
                }

                // Reschedule midnight reset task
                AlarmTasksSchedulingHelper.scheduleMidnightResetTask(mContext, false);

                return Result.success();

            } catch (Exception e) {
                Log.e(TAG, "Error during BootWorker execution", e);
                return Result.failure();
            } finally {
                // Ensure service connections are unbound after execution
                mTrackerServiceConn.unBindService();
                mVpnServiceConn.unBindService();
            }
        }

        @Override
        public void onStopped() {
            super.onStopped();
            mTrackerServiceConn.unBindService();
            mVpnServiceConn.unBindService();
        }
    }
}
