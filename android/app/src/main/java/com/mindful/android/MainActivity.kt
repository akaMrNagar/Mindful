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
package com.mindful.android

import android.content.Intent
import android.os.Bundle
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts
import com.mindful.android.helpers.AlarmTasksSchedulingHelper.scheduleMidnightResetTask
import com.mindful.android.helpers.device.NotificationHelper
import com.mindful.android.helpers.storage.SharedPrefsHelper
import com.mindful.android.utils.AppConstants
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterFragmentActivity() {
    private lateinit var fgMethodCallHandler: FgMethodCallHandler
    private lateinit var vpnPermissionLauncher: ActivityResultLauncher<Intent>

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Store uncaught exceptions
        Thread.setDefaultUncaughtExceptionHandler { _: Thread?, exception: Throwable ->
            SharedPrefsHelper.insertCrashLogToPrefs(
                this, exception
            )
        }

        // Register notification channels
        NotificationHelper.registerNotificationChannels(this)

        // Register VPN permission launcher
        vpnPermissionLauncher = registerForActivityResult(
            ActivityResultContracts.StartActivityForResult()
        ) { }

        // initialize method channel and bind to services
        fgMethodCallHandler = FgMethodCallHandler(
            context = applicationContext,
            activity = this,
            vpnPermLauncher = vpnPermissionLauncher
        )

        // Schedule midnight 12 task if already not scheduled
        scheduleMidnightResetTask(this, true)
    }


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val methodChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            AppConstants.FLUTTER_METHOD_CHANNEL_FG
        )
        methodChannel.setMethodCallHandler(fgMethodCallHandler)

        // Get and set intent data
        val intentData: MutableMap<String, Any?> = HashMap()
        intentData["route"] = intent.getStringExtra(AppConstants.INTENT_EXTRA_INITIAL_ROUTE)
        intentData["extraPackageName"] =
            intent.getStringExtra(AppConstants.INTENT_EXTRA_PACKAGE_NAME)
        intentData["extraIsSelfStart"] =
            intent.getBooleanExtra(AppConstants.INTENT_EXTRA_IS_SELF_RESTART, false)

        // Update intent data on flutter side
        methodChannel.invokeMethod("updateIntentData", intentData)
    }


    override fun onDestroy() {
        super.onDestroy()
        fgMethodCallHandler.dispose()
    }

    companion object {
        private const val TAG = "Mindful.MainActivity"
    }
}
