package com.mindful.android.receivers

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log
import androidx.annotation.UiThread
import androidx.annotation.WorkerThread

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
