package com.mindful.android.services.accessibility

import android.content.Context
import android.content.Intent
import android.util.Log
import androidx.annotation.WorkerThread
import com.mindful.android.AppConstants.SYSTEM_UI_PACKAGE
import com.mindful.android.helpers.storage.SharedPrefsHelper


class TrackingManager(
    private val context: Context,
) {

    companion object {
        const val ACTION_ACCESSIBILITY_ACTIVE = "com.mindful.android.action.accessibilityActive"
        const val ACTION_ACCESSIBILITY_INACTIVE = "com.mindful.android.action.accessibilityInactive"
        const val ACTION_NEW_WEB_EVENT = "com.mindful.android.action.newWebEvent"
        const val ACTION_NEW_APP_LAUNCHED = "com.mindful.android.action.newAppLaunched"
        const val EXTRA_PACKAGE_NAME: String = "com.mindful.android.extra.packageName"
        const val EXTRA_HOST_NAME: String = "com.mindful.android.extra.hostName"
    }

    private var lastActiveApp: String = ""

    @WorkerThread
    fun onNewEvent(packageName: String) {
        if (lastActiveApp != packageName && packageName != SYSTEM_UI_PACKAGE) {
            lastActiveApp = packageName
            broadcastEvent(ACTION_NEW_APP_LAUNCHED, Pair(EXTRA_PACKAGE_NAME, packageName))
        }
    }

    @WorkerThread
    fun onNewWebEvent(host: String) = broadcastEvent(ACTION_NEW_WEB_EVENT, Pair(EXTRA_HOST_NAME, host))

    // Called when accessibility service is stopped
    fun startManualTracking() = broadcastEvent(ACTION_ACCESSIBILITY_INACTIVE)

    // Called when accessibility service is started
    fun stopManualTracking() = broadcastEvent(ACTION_ACCESSIBILITY_ACTIVE)


    private fun broadcastEvent(action: String, extraData: Pair<String, String>? = null) {
        try {
            val intent = Intent(action).apply {
                setPackage(context.packageName)
                extraData?.let { putExtra(it.first, it.second) }
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
