package com.mindful.android.receivers

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.util.Log
import androidx.annotation.WorkerThread
import com.mindful.android.helpers.storage.SharedPrefsHelper
import com.mindful.android.utils.Utils

/**
 * BroadcastReceiver to listen for app install/uninstall events.
 */

class DeviceAppsChangedReceiver(
    /**
     * Will be Invoked during installation and uninstallation of any app on device.
     * This method will be invoked on new Background Thread.
     */
    @WorkerThread
    private val onAppsChanged: (packageName: String) -> Unit,
) : BroadcastReceiver() {

    companion object {
        private const val TAG = "Mindful.DeviceAppsChangedReceiver"
    }

    fun register(context: Context) {
        try {
            Utils.safelyRegisterReceiver(
                context,
                this,
                IntentFilter(Intent.ACTION_CLOSE_SYSTEM_DIALOGS).apply {
                    addAction(Intent.ACTION_PACKAGE_ADDED)
                    addAction(Intent.ACTION_PACKAGE_REMOVED)
                    addDataScheme("package")
                },
            )
        } catch (e: Exception) {
            Log.e(TAG, "register: Failed to register receiver", e)
            SharedPrefsHelper.insertCrashLogToPrefs(context, e)
        }
    }

    fun unRegister(context: Context) {
        try {
            context.unregisterReceiver(this)
        } catch (e: Exception) {
            Log.e(TAG, "register: Failed to un-register receiver", e)
            SharedPrefsHelper.insertCrashLogToPrefs(context, e)
        }
    }

    override fun onReceive(context: Context, intent: Intent) {
        when (val action = intent.action) {
            Intent.ACTION_PACKAGE_ADDED, Intent.ACTION_PACKAGE_REMOVED -> {
                val packageName = getPackageName(intent)
                Log.d(
                    "Mindful.PackagesChangedReceiver",
                    "onReceive: App install/uninstall event received with action : $action for package: $packageName"
                )

                if (packageName.isNotBlank()) {
                    Thread { onAppsChanged.invoke(packageName) }.start()
                }
            }
        }
    }

    private fun getPackageName(intent: Intent): String {
        return intent.data?.schemeSpecificPart ?: ""
    }
}
