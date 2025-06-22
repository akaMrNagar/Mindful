package com.mindful.android.receivers

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.util.Log
import com.mindful.android.helpers.storage.SharedPrefsHelper
import com.mindful.android.utils.Utils
import com.mindful.android.services.accessibility.MindfulAccessibilityService.Companion.ACTION_PERFORM_HOME_PRESS
import com.mindful.android.services.accessibility.MindfulAccessibilityService.Companion.ACTION_PERFORM_BACK_PRESS

class GeneralReceiver(
    private val goHomeWithToast: (() -> Unit)? = null,
    private val goBackWithToast: (() -> Unit)? = null,
    ) : BroadcastReceiver() {

    private val TAG = "Mindful.GeneralReceiver"

    fun register(context: Context) {
        try {
            Utils.safelyRegisterReceiver(
                context,
                this,
                IntentFilter().apply {
                    addAction(ACTION_PERFORM_HOME_PRESS)
                    addAction(ACTION_PERFORM_BACK_PRESS)
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

    override fun onReceive(context: Context?, intent: Intent?) {
        intent?.let {
            when (it.action) {
                ACTION_PERFORM_HOME_PRESS -> goHomeWithToast?.invoke()
                ACTION_PERFORM_BACK_PRESS -> goBackWithToast?.invoke()
                else -> return
            }
        }
    }
}
