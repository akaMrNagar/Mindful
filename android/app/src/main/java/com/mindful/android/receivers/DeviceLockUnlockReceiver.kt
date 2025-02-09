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

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log
import androidx.annotation.MainThread
import androidx.annotation.WorkerThread
import com.mindful.android.utils.Utils

/**
 * BroadcastReceiver that monitors device lock/unlock events and tracks app launches while the device is unlocked.
 */
class DeviceLockUnlockReceiver(
    @MainThread
    private val onDeviceLockChanged: (isUnLocked: Boolean) -> Unit,
) : BroadcastReceiver() {
    companion object {
        private const val TAG = "Mindful.DeviceLockUnlockReceiver"
    }

    override fun onReceive(context: Context, intent: Intent) {
        when (intent.action) {
            Intent.ACTION_USER_PRESENT -> {
                onDeviceLockChanged.invoke(true)
                Log.d(TAG, "onDeviceUnlocked: User UNLOCKED the device and device is ACTIVE")
            }

            Intent.ACTION_SCREEN_OFF -> {
                onDeviceLockChanged.invoke(false)
                Log.d(TAG, "onDeviceLocked: User LOCKED the device and device is INACTIVE")
            }
        }
    }
}
