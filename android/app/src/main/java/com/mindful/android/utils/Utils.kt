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
package com.mindful.android.utils

import android.annotation.SuppressLint
import android.app.ActivityManager
import android.content.BroadcastReceiver
import android.content.Context
import android.content.IntentFilter
import android.os.Build
import android.os.VibrationEffect
import android.os.Vibrator
import android.os.VibratorManager
import android.util.Log
import java.net.URI

/**
 * A utility class containing static helper methods for various common tasks such as
 * checking if a service is running, encoding images, parsing JSON strings, and manipulating URLs.
 */
object Utils {
    private const val TAG = "Mindful.Utils"

    /**
     * Checks if a service with the given class name is currently running.
     *
     * @param context          The application context.
     * @param serviceClass The class of the service  (e.g., MindfulAppsTrackerService.class)).
     * @return True if the service is running, false otherwise.
     */
    fun isServiceRunning(context: Context, serviceClass: Class<*>): Boolean {
        val activityManager = context.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
        for (serviceInfo in activityManager.getRunningServices(Int.MAX_VALUE)) {
            if (serviceInfo.service.className == serviceClass.name) {
                return true
            }
        }

        return false
    }

    @SuppressLint("UnspecifiedRegisterReceiverFlag")
    fun safelyRegisterReceiver(
        context: Context,
        receiver: BroadcastReceiver,
        intentFilter: IntentFilter,
        exported: Boolean = false,
    ) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            val flag = if (exported) Context.RECEIVER_EXPORTED
            else Context.RECEIVER_NOT_EXPORTED
            context.registerReceiver(receiver, intentFilter, flag)
        } else {
            context.registerReceiver(receiver, intentFilter)
        }
    }

    fun vibrateDevice(context: Context, durationMs: Long) {
        val vibrator: Vibrator = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            val vibratorManager =
                context.getSystemService(Context.VIBRATOR_MANAGER_SERVICE) as VibratorManager
            vibratorManager.defaultVibrator
        } else {
            context.getSystemService(Context.VIBRATOR_SERVICE) as Vibrator
        }

        vibrator.cancel()

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            vibrator.vibrate(
                VibrationEffect.createOneShot(
                    durationMs,
                    VibrationEffect.DEFAULT_AMPLITUDE
                )
            )
        } else {
            vibrator.vibrate(durationMs)
        }
    }


    /**
     * Ensures the given URL uses the HTTPS protocol.
     *
     *
     * If the URL starts with "https://", it is returned unchanged. If it starts with
     * "http://", the protocol is changed to "https://". If no protocol is present,
     * "https://" is added.
     *
     * @param url The URL to validate (must not be null).
     * @return A URL that starts with "https://".
     */
    fun validateHttpsProtocol(url: String): String {
        return if (url.startsWith("https://")) url else if (url.startsWith("http://")) url.replace(
            "http://",
            "https://"
        ) else ("https://$url")
    }

    /**
     * Parses the host name from a URL string.
     *
     * @param url The URL string to parse.
     * @return The host name extracted from the URL.
     */
    fun parseHostNameFromUrl(url: String): String? {
        // First try using URI class for proper URL parsing
        runCatching { URI(url).host }
            .onSuccess { host ->
                host?.let { originalHost ->
                    return when {
                        originalHost.startsWith("mobile.") -> originalHost.substring(7)
                        originalHost.startsWith("m.") -> originalHost.substring(2)
                        else -> originalHost
                    }
                }
            }
            .onFailure { e ->
                Log.w(
                    TAG,
                    "parseHostNameFromUrl: Cannot parse url using URI method, trying fallback",
                    e
                )
            }

        // Fallback manual parsing
        return buildString {
            // Remove common prefixes
            append(url.removePrefix("https://").removePrefix("http://").removePrefix("www."))

            // Handle mobile prefixes
            when {
                startsWith("mobile.") -> delete(0, 7)
                startsWith("m.") -> delete(0, 2)
            }

            // Trim everything after first slash
            val slashIndex = indexOf('/')
            if (slashIndex > 0) setLength(slashIndex)
        }.takeIf { it.isNotEmpty() }
    }
}
