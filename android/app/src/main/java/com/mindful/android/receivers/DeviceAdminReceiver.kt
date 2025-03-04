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

import android.app.admin.DeviceAdminReceiver
import android.content.Context
import android.content.Intent
import android.widget.Toast
import com.mindful.android.services.accessibility.MindfulAccessibilityService
import com.mindful.android.services.accessibility.MindfulAccessibilityService.Companion.ACTION_TAMPER_PROTECTION_CHANGED
import com.mindful.android.utils.Utils

/**
 * A DeviceAdminReceiver for handling device administration events for the Mindful app.
 */
class DeviceAdminReceiver : DeviceAdminReceiver() {
    override fun onEnabled(context: Context, intent: Intent) {
        Toast.makeText(context, "Tamper protection enabled", Toast.LENGTH_LONG).show()
        refreshWellbeingSettings(context)
        super.onEnabled(context, intent)
    }

    override fun onDisabled(context: Context, intent: Intent) {
        Toast.makeText(context, "Tamper protection disabled", Toast.LENGTH_LONG).show()
        refreshWellbeingSettings(context)
        super.onDisabled(context, intent)
    }

    private fun refreshWellbeingSettings(context: Context) {
        if (Utils.isServiceRunning(context, MindfulAccessibilityService::class.java)) {
            val serviceIntent = Intent(
                context.applicationContext,
                MindfulAccessibilityService::class.java
            ).setAction(ACTION_TAMPER_PROTECTION_CHANGED)

            context.startService(serviceIntent)
        }
    }
}

