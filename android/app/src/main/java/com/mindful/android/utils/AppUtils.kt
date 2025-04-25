package com.mindful.android.utils

import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.drawable.Drawable
import android.net.Uri
import android.os.Build
import android.util.Base64
import android.util.Log
import java.io.ByteArrayOutputStream

object AppUtils {

    /**
     * Creates a intent for Mindful with the provided URI.
     *
     * @param context          The application context.
     * @param uriString          The string representation of URI.
     * @return The pending intent.
     */
    fun getIntentForMindfulUri(
        context: Context,
        uriString: String = "com.mindful.android://open/home",
    ): Intent {
        val appIntent = Intent(
            Intent.ACTION_VIEW,
            Uri.parse(uriString)
        ).apply {
            `package` = context.packageName
            addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        }

        return appIntent
    }

    /**
     * Creates a pending intent for Mindful with the provided URI.
     *
     * @param context          The application context.
     * @param uriString          The string representation of URI.
     * @return The pending intent.
     */
    fun getPendingIntentForMindfulUri(
        context: Context,
        uriString: String = "com.mindful.android://open/home",
    ): PendingIntent {

        return PendingIntent.getActivity(
            context.applicationContext,
            0,
            getIntentForMindfulUri(context, uriString),
            PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
        )
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
            Log.e("Mindful.AppUtils", "getEncodedAppIcon: Cannot parse app icon from memory", e)
        }
        return appIcon
    }
}