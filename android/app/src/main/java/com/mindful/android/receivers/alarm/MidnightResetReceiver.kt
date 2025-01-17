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
package com.mindful.android.receivers.alarm

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log
import androidx.work.ExistingWorkPolicy
import androidx.work.OneTimeWorkRequest
import androidx.work.WorkManager
import androidx.work.Worker
import androidx.work.WorkerParameters
import com.mindful.android.generics.SafeServiceConnection
import com.mindful.android.helpers.AlarmTasksSchedulingHelper.scheduleMidnightResetTask
import com.mindful.android.helpers.SharedPrefsHelper
import com.mindful.android.services.accessibility.MindfulAccessibilityService
import com.mindful.android.services.tracking.MindfulTrackerService
import com.mindful.android.utils.Utils

class MidnightResetReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        if (ACTION_START_MIDNIGHT_RESET == Utils.getActionFromIntent(intent)) {
            WorkManager.getInstance(context).enqueueUniqueWork(
                TAG, ExistingWorkPolicy.KEEP,
                OneTimeWorkRequest.Builder(MidnightResetWorker::class.java).build()
            )
        }
    }

    class MidnightResetWorker(
        private val context: Context,
        params: WorkerParameters
    ) : Worker(context, params) {
        private val mTrackerServiceConn = SafeServiceConnection(
            MindfulTrackerService::class.java, context
        )


        override fun doWork(): Result {
            try {
                // Let tracking service know about midnight reset
                mTrackerServiceConn.setOnConnectedCallback { service: MindfulTrackerService -> service.onMidnightReset() }
                mTrackerServiceConn.bindService()

                // Let accessibility service know about midnight reset
                if (Utils.isServiceRunning(context, MindfulAccessibilityService::class.java)) {
                    val serviceIntent = Intent(
                        context.applicationContext,
                        MindfulAccessibilityService::class.java
                    ).setAction(ACTION_MIDNIGHT_ACCESSIBILITY_RESET)
                    context.startService(serviceIntent)
                } else {
                    // Else at least reset short content screen time
                    SharedPrefsHelper.getSetShortsScreenTimeMs(context, 0L)
                }

                Log.d(TAG, "doWork: Midnight reset work completed successfully")
                return Result.success()
            } catch (e: Exception) {
                Log.e(TAG, "doWork: Error during work execution", e)
                SharedPrefsHelper.insertCrashLogToPrefs(context, e)
                return Result.failure()
            } finally {
                // Unbind service and schedule task for the next day
                scheduleMidnightResetTask(context, false)
                mTrackerServiceConn.unBindService()
            }
        }
    }

    companion object {
        private const val TAG = "Mindful.MidnightResetReceiver"
        const val ACTION_START_MIDNIGHT_RESET: String = "com.mindful.android.StartMidnightReset"
        const val ACTION_MIDNIGHT_ACCESSIBILITY_RESET: String =
            "com.mindful.android.MidnightResetReceiver.MIDNIGHT_ACCESSIBILITY_RESET"
    }
}