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
package com.mindful.android.receivers

import android.annotation.SuppressLint
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.net.VpnService
import android.util.Log
import androidx.work.ExistingWorkPolicy
import androidx.work.OneTimeWorkRequest
import androidx.work.WorkManager
import androidx.work.Worker
import androidx.work.WorkerParameters
import com.mindful.android.generics.SafeServiceConnection
import com.mindful.android.helpers.AlarmTasksSchedulingHelper.scheduleBedtimeRoutineTasks
import com.mindful.android.helpers.AlarmTasksSchedulingHelper.scheduleMidnightResetTask
import com.mindful.android.helpers.NotificationHelper
import com.mindful.android.helpers.SharedPrefsHelper
import com.mindful.android.services.tracking.MindfulTrackerService
import com.mindful.android.services.vpn.MindfulVpnService
import com.mindful.android.utils.Utils

/**
 * BroadcastReceiver that listens for device boot and package replacement events
 * to restart required services and reschedule any pending alarms.
 */
class DeviceBootReceiver : BroadcastReceiver() {
    @SuppressLint("UnsafeProtectedBroadcastReceiver")
    override fun onReceive(context: Context, intent: Intent) {
        val action = Utils.getActionFromIntent(intent)

        when (action) {
            Intent.ACTION_BOOT_COMPLETED, Intent.ACTION_MY_PACKAGE_REPLACED -> {
                Log.d(
                    TAG,
                    "onReceive: Device reboot broadcast received, initializing necessary services and tasks."
                )

                // Queue a one-time work request to execute BootWorker tasks
                WorkManager.getInstance(context).enqueueUniqueWork(
                    TAG, ExistingWorkPolicy.KEEP,
                    OneTimeWorkRequest.Builder(BootWorker::class.java).build()
                )
            }
        }
    }

    /**
     * Worker class to perform tasks required on device boot, such as starting services
     * and rescheduling alarms for restrictions and bedtime routines.
     */
    class BootWorker(
        private val context: Context,
        params: WorkerParameters
    ) : Worker(context, params) {
        private val mTrackerServiceConn = SafeServiceConnection(
            MindfulTrackerService::class.java, context
        )
        private val mVpnServiceConn = SafeServiceConnection(
            MindfulVpnService::class.java, context
        )


        override fun doWork(): Result {
            try {
                // Register channels before starting foreground services
                NotificationHelper.registerNotificationChannels(context.applicationContext)

                // Migrate shared prefs
                SharedPrefsHelper.migrateFromOldPrefs(context)

                val appRestrictions = SharedPrefsHelper.getSetAppRestrictions(context, null)
                val restrictionGroups = SharedPrefsHelper.getSetRestrictionGroups(context, null)

                // Filter internet-blocked apps
                val internetBlockedApps = appRestrictions
                    .filter { !it.value.canAccessInternet }
                    .map { it.key }
                    .toHashSet()


                // Start tracker service to update app and group restrictions
                if (appRestrictions.isNotEmpty() || restrictionGroups.isNotEmpty()) {
                    mTrackerServiceConn.setOnConnectedCallback { service: MindfulTrackerService ->
                        service.getRestrictionManager.updateRestrictions(appRestrictions, restrictionGroups)
                    }
                    mTrackerServiceConn.startAndBind()
                }

                // Start VPN service to apply internet restrictions on specified apps
                if (internetBlockedApps.isNotEmpty() && VpnService.prepare(context.applicationContext) == null) {
                    mVpnServiceConn.setOnConnectedCallback { service: MindfulVpnService ->
                        service.updateBlockedApps(internetBlockedApps)
                    }
                    mVpnServiceConn.startAndBind()
                }

                // Fetch and apply bedtime settings if enabled
                val bedtimeSettings = SharedPrefsHelper.getSetBedtimeSettings(context, null)
                if (bedtimeSettings.isScheduleOn) {
                    scheduleBedtimeRoutineTasks(context, bedtimeSettings)
                }

                // Reschedule midnight reset task
                scheduleMidnightResetTask(context, false)

                return Result.success()
            } catch (e: Exception) {
                Log.e(TAG, "Error during BootWorker execution", e)
                SharedPrefsHelper.insertCrashLogToPrefs(context, e)
                return Result.failure()
            } finally {
                // Ensure service connections are unbound after execution
                mTrackerServiceConn.unBindService()
                mVpnServiceConn.unBindService()
            }
        }

        override fun onStopped() {
            super.onStopped()
            mTrackerServiceConn.unBindService()
            mVpnServiceConn.unBindService()
        }
    }

    companion object {
        private const val TAG = "Mindful.DeviceBootReceiver"
    }
}
