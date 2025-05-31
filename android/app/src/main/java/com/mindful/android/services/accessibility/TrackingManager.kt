package com.mindful.android.services.accessibility

import android.content.Context
import android.content.Intent
import android.util.Log
import androidx.annotation.WorkerThread
import com.mindful.android.AppConstants
import com.mindful.android.helpers.storage.SharedPrefsHelper
import com.mindful.android.utils.executors.Throttler


class TrackingManager(
    private val context: Context,
) {

    companion object {
        const val ACTION_START_MANUAL_TRACKING = "com.mindful.android.action.startManualTracking"
        const val ACTION_STOP_MANUAL_TRACKING = "com.mindful.android.action.stopManualTracking"
        const val ACTION_NEW_APP_LAUNCHED = "com.mindful.android.action.newAppLaunched"
        const val EXTRA_PACKAGE_NAME: String = "com.mindful.android.extra.packageName"
    }

    private val throttler = Throttler(100L)
    private var lastActiveApp: String = ""

    @WorkerThread
    fun onNewEvent(packageName: String) {
        if (lastActiveApp != packageName) {
            lastActiveApp = packageName
            if (packageName == AppConstants.SYSTEM_UI_PACKAGE) return

            throttler.submit { broadcastEvent(ACTION_NEW_APP_LAUNCHED, packageName) }
        }
    }


    // Called when accessibility service is stopped
    fun startManualTracking() = broadcastEvent(ACTION_START_MANUAL_TRACKING)

    // Called when accessibility service is started
    fun stopManualTracking() = broadcastEvent(ACTION_STOP_MANUAL_TRACKING)


    private fun broadcastEvent(action: String, extraPackage: String? = null) {
        try {
            val intent = Intent(action).apply {
                setPackage(context.packageName)
                extraPackage?.let { putExtra(EXTRA_PACKAGE_NAME, it) }
            }
            context.sendBroadcast(intent)
        } catch (e: Exception) {
            Log.e(
                "Mindful.Accessibility.TrackingManager",
                "broadcastEvent: Failed to send broadcast for action:$action",
                e
            )
            SharedPrefsHelper.insertCrashLogToPrefs(context, e)
        }
    }
}