package com.mindful.android.services.accessibility

import android.content.Context
import android.content.Intent
import android.util.Log
import androidx.annotation.WorkerThread
import com.mindful.android.helpers.storage.SharedPrefsHelper
import com.mindful.android.utils.AppConstants
import java.lang.Exception


class TrackingManager(
    private val context: Context,
) {

    companion object {
        const val ACTION_START_MANUAL_TRACKING = "com.mindful.android.startManualTracking"
        const val ACTION_STOP_MANUAL_TRACKING = "com.mindful.android.stopManualTracking"
        const val ACTION_NEW_APP_LAUNCHED = "com.mindful.android.newAppLaunched"
    }

    private var lastActiveApp: String = ""
    private val ignoredPackages: Set<String> = setOf(
        context.packageName,
        "com.android.systemui",
    )

    @WorkerThread
    fun onNewEvent(packageName: String) {
        if (lastActiveApp != packageName) {
            lastActiveApp = packageName

            // only send broadcast if packages are not ignored
            if (!ignoredPackages.contains(packageName)) {
                broadcastEvent(ACTION_NEW_APP_LAUNCHED)
            }
        }
    }


    // Called when accessibility service is stopped
    fun startManualTracking() = broadcastEvent(ACTION_START_MANUAL_TRACKING)

    // Called when accessibility service is started
    fun stopManualTracking() = broadcastEvent(ACTION_STOP_MANUAL_TRACKING)


    private fun broadcastEvent(action: String) {
        try {
            val intent = Intent(action).apply {
                setPackage(context.packageName)
                putExtra(AppConstants.INTENT_EXTRA_PACKAGE_NAME, lastActiveApp)
            }
            context.sendBroadcast(intent)
        } catch (e: Exception) {
            Log.e(
                "Mindful.Accessibility.TrackingManager",
                "broadcastEvent: Failed to send broadcast for action:$action and package: $lastActiveApp",
                e
            )
            SharedPrefsHelper.insertCrashLogToPrefs(context, e)
        }
    }
}