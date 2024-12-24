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

package com.mindful.android.receivers.alarm;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.work.ExistingWorkPolicy;
import androidx.work.OneTimeWorkRequest;
import androidx.work.WorkManager;
import androidx.work.Worker;
import androidx.work.WorkerParameters;

import com.mindful.android.generics.SafeServiceConnection;
import com.mindful.android.helpers.AlarmTasksSchedulingHelper;
import com.mindful.android.helpers.SharedPrefsHelper;
import com.mindful.android.services.MindfulAccessibilityService;
import com.mindful.android.services.MindfulTrackerService;
import com.mindful.android.utils.Utils;

public class MidnightResetReceiver extends BroadcastReceiver {

    private static final String TAG = "Mindful.MidnightResetReceiver";
    public static final String ACTION_START_MIDNIGHT_RESET = "com.mindful.android.StartMidnightReset";
    public static final String ACTION_MIDNIGHT_ACCESSIBILITY_RESET = "com.mindful.android.MidnightResetReceiver.MIDNIGHT_ACCESSIBILITY_RESET";


    @Override
    public void onReceive(Context context, Intent intent) {
        if (ACTION_START_MIDNIGHT_RESET.equals(Utils.getActionFromIntent(intent))) {
            WorkManager.getInstance(context).enqueueUniqueWork(TAG, ExistingWorkPolicy.KEEP, new OneTimeWorkRequest.Builder(MidnightResetWorker.class).build());
        }
    }

    public static class MidnightResetWorker extends Worker {
        private final Context mContext;
        private final SafeServiceConnection<MindfulTrackerService> mTrackerServiceConn;

        public MidnightResetWorker(@NonNull Context context, @NonNull WorkerParameters params) {
            super(context, params);
            this.mContext = context;
            this.mTrackerServiceConn = new SafeServiceConnection<>(MindfulTrackerService.class, context);
        }


        @NonNull
        @Override
        public Result doWork() {
            try {
                // Let tracking service know about midnight reset
                mTrackerServiceConn.setOnConnectedCallback(MindfulTrackerService::midnightServiceReset);
                mTrackerServiceConn.bindService();

                // Let accessibility service know about midnight reset
                if (Utils.isServiceRunning(mContext, MindfulAccessibilityService.class.getName())) {
                    Intent serviceIntent = new Intent(mContext.getApplicationContext(), MindfulAccessibilityService.class).setAction(ACTION_MIDNIGHT_ACCESSIBILITY_RESET);
                    mContext.startService(serviceIntent);
                } else {
                    // Else at least reset short content screen time
                    SharedPrefsHelper.getSetShortsScreenTimeMs(mContext, 0L);
                }

                Log.d(TAG, "doWork: Midnight reset work completed successfully");
                return Result.success();
            } catch (Exception e) {
                Log.e(TAG, "doWork: Error during work execution", e);
                SharedPrefsHelper.insertCrashLogToPrefs(mContext, e);
                return Result.failure();
            } finally {
                // Unbind service and schedule task for the next day
                AlarmTasksSchedulingHelper.scheduleMidnightResetTask(mContext, false);
                mTrackerServiceConn.unBindService();
            }
        }
    }
}