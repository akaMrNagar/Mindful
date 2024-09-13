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

import com.mindful.android.helpers.AlarmTasksSchedulingHelper;
import com.mindful.android.helpers.SharedPrefsHelper;
import com.mindful.android.services.MindfulAccessibilityService;
import com.mindful.android.services.MindfulTrackerService;
import com.mindful.android.utils.AppConstants;
import com.mindful.android.utils.Utils;

public class MidnightResetReceiver extends BroadcastReceiver {

    private static final String TAG = "Mindful.MidnightResetReceiver";
    public static final String ACTION_START_MIDNIGHT_RESET = "com.mindful.android.StartMidnightReset";
    public static final String ACTION_MIDNIGHT_SERVICE_RESET = "com.mindful.android.MidnightResetReceiver.MIDNIGHT_SERVICE_RESET";


    @Override
    public void onReceive(Context context, @NonNull Intent intent) {
        if (ACTION_START_MIDNIGHT_RESET.equals(intent.getAction())) {

            // Reset emergency passes count to default value
            SharedPrefsHelper.storeEmergencyPassesCount(context, AppConstants.DEFAULT_EMERGENCY_PASSES_COUNT);

            // Let tracking service know about midnight reset
            if (Utils.isServiceRunning(context, MindfulTrackerService.class.getName())) {
                Intent serviceIntent = new Intent(context, MindfulTrackerService.class).setAction(ACTION_MIDNIGHT_SERVICE_RESET);
                context.startService(serviceIntent);
            }

            // Let accessibility service know about midnight reset
            if (Utils.isServiceRunning(context, MindfulAccessibilityService.class.getName())) {
                Intent serviceIntent = new Intent(context, MindfulAccessibilityService.class).setAction(ACTION_MIDNIGHT_SERVICE_RESET);
                context.startService(serviceIntent);
            } else {
                // Else at least reset short content screen time
                SharedPrefsHelper.storeShortsScreenTimeMs(context, 0);
            }

            Log.d(TAG, "onReceive: Midnight reset task completed successfully");

            // Schedule task for next day
            AlarmTasksSchedulingHelper.scheduleMidnightResetTask(context, false);
        }
    }
}