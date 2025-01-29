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

import android.app.ActivityManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.os.Build
import android.util.Base64
import android.util.Log
import com.mindful.android.MainActivity
import org.jetbrains.annotations.Contract
import java.io.ByteArrayOutputStream
import java.net.URI
import java.net.URISyntaxException
import java.time.DayOfWeek
import java.util.Calendar
import java.util.Locale
import kotlin.math.abs

/**
 * A utility class containing static helper methods for various common tasks such as
 * checking if a service is running, encoding images, parsing JSON strings, and manipulating URLs.
 */
object Utils {
    private const val TAG = "Mindful.Utils"

    fun getPendingIntentForMindful(
        context: Context,
        initialRoute: String? = null,
        putExtraToIntent: ((intent: Intent) -> Unit)? = null,
    ): PendingIntent {
        val appIntent = Intent(context.applicationContext, MainActivity::class.java)
        appIntent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK)

        // put extra to intent
        initialRoute?.let { appIntent.putExtra(AppConstants.INTENT_EXTRA_INITIAL_ROUTE, it) }
        putExtraToIntent?.invoke(appIntent)

        return PendingIntent.getActivity(
            context.applicationContext,
            0,
            appIntent,
            PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
        )
    }

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

    /**
     * Get the current app version.
     *
     * @param context The context from which the method is called
     * @return The app version as a string
     */
    fun getAppVersion(context: Context): String {
        try {
            val packageManager = context.packageManager
            val packageName = context.packageName
            val packageInfo = packageManager.getPackageInfo(packageName, 0)

            return if (packageName.contains(".debug")
            ) "v" + packageInfo.versionName + "-debug+" + packageInfo.versionCode
            else "v" + packageInfo.versionName + "+" + packageInfo.versionCode
        } catch (e: Exception) {
            return "unknown"
        }
    }

    /**
     * Resolve the device information and  returns it
     *
     * @return Map containing Manufacturer, Model, Android Version, SDK Version and Mindful version.
     */
    fun getDeviceInfoMap(context: Context): Map<String, Any> {
        val infoMap = HashMap<String, Any>()
        infoMap["manufacturer"] = Build.MANUFACTURER
        infoMap["model"] = Build.MODEL
        infoMap["androidVersion"] = Build.VERSION.RELEASE
        infoMap["sdkVersion"] = Build.VERSION.SDK_INT
        infoMap["mindfulVersion"] = getAppVersion(context)
        return infoMap
    }


    /**
     * Encodes a Drawable (app icon) to a Base64 string.
     *
     * @param iconData The Drawable to encode.
     * @return The Base64 encoded string representing the app icon.
     */
    private fun encodeToBase64(iconData: Drawable): String {
        val byteArrayOS = ByteArrayOutputStream()
        val image = Bitmap.createBitmap(
            iconData.intrinsicWidth,
            iconData.intrinsicHeight,
            Bitmap.Config.ARGB_8888
        )

        val canvas = Canvas(image)
        iconData.setBounds(0, 0, canvas.width, canvas.height)
        iconData.draw(canvas)
        image.compress(Bitmap.CompressFormat.PNG, 100, byteArrayOS)
        return Base64.encodeToString(byteArrayOS.toByteArray(), Base64.NO_WRAP)
    }

    /**
     * Encodes and returns the Base64 representation of an app icon.
     *
     * @param icon The app icon as a Drawable.
     * @return The Base64 encoded string of the app icon.
     */
    fun getEncodedAppIcon(icon: Drawable): String {
        var appIcon = ""
        try {
            appIcon = encodeToBase64(icon)
        } catch (e: Exception) {
            Log.e(TAG, "getEncodedAppIcon: Cannot parse app icon from memory", e)
        }
        return appIcon
    }

    /**
     * Converts the drawable to bitmap.
     *
     * @param drawable The Drawable which will be converted.
     * @return Bitmap The converted bitmap.
     */
    fun drawableToBitmap(drawable: Drawable): Bitmap {
        if (drawable is BitmapDrawable) {
            return drawable.bitmap
        }

        val bitmap = Bitmap.createBitmap(
            drawable.intrinsicWidth,
            drawable.intrinsicHeight,
            Bitmap.Config.ARGB_8888
        )
        val canvas = Canvas(bitmap)
        drawable.setBounds(0, 0, canvas.width, canvas.height)
        drawable.draw(canvas)

        return bitmap
    }

    /**
     * Formats the total screen usage time into a human-readable string.
     * Example: 02h 43m 09s
     *
     * @param totalSeconds The total screen usage time in seconds.
     * @return A string representing the formatted screen usage time.
     */
    @Contract(pure = true)
    fun secondsToTimeStr(totalSeconds: Int): String {
        val leftHours = (totalSeconds / 3600)
        val leftMinutes = ((totalSeconds % 3600) / 60)
        val leftSeconds = (totalSeconds % 60)

        val timeStr = StringBuilder()

        if (leftHours > 0) {
            timeStr.append(String.format(Locale.ENGLISH, "%02d", leftHours)).append("h ")
        }

        timeStr.append(String.format(Locale.ENGLISH, "%02d", leftMinutes)).append("m ")
        timeStr.append(String.format(Locale.ENGLISH, "%02d", leftSeconds)).append("s")

        return timeStr.toString()
    }

    /**
     * Returns the current day of the week as a zero-based index, where Monday is 0 and Sunday is 6.
     *
     * The `Calendar.DAY_OF_WEEK` values range from `1` (Sunday) to `7` (Saturday).
     * This method shifts the values so that:
     * - Monday → `0`
     * - Tuesday → `1`
     * - Wednesday → `2`
     * - Thursday → `3`
     * - Friday → `4`
     * - Saturday → `5`
     * - Sunday → `6`
     *
     * @return An integer representing the day of the week with Monday as index `0` and Sunday as index `6`.
     */
    @Contract(pure = true)
    fun zeroIndexedDayOfWeek(): Int {
        val javaDayOfWeek = Calendar.getInstance()[Calendar.DAY_OF_WEEK]
        return (javaDayOfWeek + 5) % 7
    }


    /**
     * Create a calender instance from the Time Of Day total minutes.
     * If totalMinutes is negative then the calender is adjusted to previous day
     *
     * @param totalMinutes The total minutes from Time Of Day dart object.
     * @return Calender representing the time of day for today.
     */
    @Contract(pure = true)
    fun todToTodayCal(totalMinutes: Int): Calendar {
        val cal = Calendar.getInstance()
        cal[Calendar.HOUR_OF_DAY] = 0
        cal.add(Calendar.HOUR_OF_DAY, totalMinutes / 60)
        cal[Calendar.MINUTE] = 0
        cal.add(Calendar.MINUTE, totalMinutes % 60)
        cal[Calendar.SECOND] = 0
        cal[Calendar.MILLISECOND] = 0
        return cal
    }

    /**
     * Calculated the difference between time now and future tod minutes.
     *
     * @param futureTotalMinutes The total minutes from Time Of Day dart object.
     * @return The difference in MS. If the difference is negative then return 0
     */
    fun todDifferenceFromNow(futureTotalMinutes: Int): Long {
        val diff = todToTodayCal(futureTotalMinutes).timeInMillis - System.currentTimeMillis()
        return if (diff > 0) diff else 0
    }

    /**
     * Checks if current system time is outside the star and end Time Of Day for today
     *
     * @param startTod The start TOD in minutes
     * @param endTod   The end TOD in minutes
     * @return Boolean indicating if now is outside startTod and endTod
     */
    fun isTimeOutsideTODs(startTod: Int, endTod: Int): Boolean {
        val now = System.currentTimeMillis()
        return !(todToTodayCal(startTod).timeInMillis < now && now < todToTodayCal(endTod).timeInMillis)
    }


    /**
     * Formats the total screen usage time into a human-readable string.
     * Example: 12h 5m
     *
     * @param totalMinutes The total screen usage time in minutes.
     * @return A string representing the formatted screen usage time.
     */
    @Contract(pure = true)
    fun minutesToTimeStr(totalMinutes: Int): String {
        val totalMinutesAbs = abs(totalMinutes)

        return if (totalMinutesAbs > 60
        ) if (totalMinutesAbs % 60 == 0
        ) (totalMinutesAbs / 60).toString() + "h"
        else (totalMinutesAbs / 60).toString() + "h " + totalMinutesAbs % 60 + "m"
        else totalMinutesAbs.toString() + "m"
    }


    /**
     * Formats the total data usage into a human-readable string.
     * Example: 12.35 GB
     *
     * @param totalMBs The total data usage in megabytes (MB).
     * @return A string representing the formatted data usage.
     */
    @Contract(pure = true)
    fun formatDataMBs(totalMBs: Int): String {
        val totalMBsAbs = abs(totalMBs)

        if (totalMBsAbs >= 1024) {
            val GBs = totalMBsAbs / 1024f
            val formattedGBs = String.format(Locale.getDefault(), "%.2f", GBs)
            return "$formattedGBs GB"
        } else {
            return "$totalMBsAbs MB"
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
    fun parseHostNameFromUrl(url: String): String {
        val uri: URI
        var hostName: String? = null

        try {
            uri = URI(url)
            hostName = uri.host
        } catch (e: URISyntaxException) {
            Log.w(
                TAG,
                "parseHostNameFromUrl: Cannot parse url using URI method, trying different method",
                e
            )
        }

        if (hostName != null) return hostName

        // If host name is still null then reassign with url
        hostName = url

        // Remove prefix from url
        hostName = hostName.replace("https://", "").replace("http://", "").replace("www.", "")

        // Some websites use mobile. OR m. prefix
        if (hostName.contains("mobile.")) {
            hostName = hostName.substring(7)
        } else if (hostName.contains("m.") && hostName.indexOf("m.") < 3) {
            hostName = hostName.substring(2)
        }

        // If the url still contains / then remove it
        if (hostName.contains("/")) {
            return hostName.substring(0, hostName.indexOf("/"))
        }

        return hostName
    }
}
