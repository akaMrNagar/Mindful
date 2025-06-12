package com.mindful.android.receivers

import android.annotation.SuppressLint
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.util.Log
import com.mindful.android.helpers.storage.SharedPrefsHelper
import com.mindful.android.utils.Utils

class DeviceNavigationReceiver(
    private val onHomePress: (() -> Unit)? = null,
    private val onRecentPress: (() -> Unit)? = null,
    private val onAnyNavigation: (() -> Unit)? = null,
) : BroadcastReceiver() {
    companion object {
        private const val TAG = "Mindful.DeviceNavigationReceiver"
    }

    @SuppressLint("UnspecifiedRegisterReceiverFlag")
    fun register(context: Context) {
        try {
            Utils.safelyRegisterReceiver(
                context, this,
                IntentFilter(Intent.ACTION_CLOSE_SYSTEM_DIALOGS)
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

    override fun onReceive(context: Context?, intent: Intent?) {
        intent?.let {
            /// Return if not desired event
            if (it.action != Intent.ACTION_CLOSE_SYSTEM_DIALOGS) return

            val reason = it.extras?.getString("reason", "NULL")
            Log.d(TAG, "onReceive: Navigation event received: $reason")

            onAnyNavigation?.invoke()
            when (reason) {
                "homekey" -> onHomePress?.invoke()
                "recentapps" -> onRecentPress?.invoke()
                else -> return
            }
        }
    }
}