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

package com.mindful.android.utils;

import android.app.ActivityManager;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.drawable.BitmapDrawable;
import android.graphics.drawable.Drawable;
import android.os.Build;
import android.util.Base64;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import org.jetbrains.annotations.Contract;

import java.io.ByteArrayOutputStream;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

/**
 * A utility class containing static helper methods for various common tasks such as
 * checking if a service is running, encoding images, parsing JSON strings, and manipulating URLs.
 */
public class Utils {
    private static final String TAG = "Mindful.Utils";

    /**
     * Checks if a service with the given class name is currently running.
     *
     * @param context          The application context.
     * @param serviceClassName The name of the service class (e.g., MindfulAppsTrackerService.class.getName()).
     * @return True if the service is running, false otherwise.
     */
    public static boolean isServiceRunning(@NonNull Context context, String serviceClassName) {
        ActivityManager activityManager = (ActivityManager) context.getSystemService(Context.ACTIVITY_SERVICE);
        for (ActivityManager.RunningServiceInfo serviceInfo : activityManager.getRunningServices(Integer.MAX_VALUE)) {
            if (serviceInfo.service.getClassName().equals(serviceClassName)) {
                return true;
            }
        }

        return false;
    }

    /**
     * Resolve the device information and  returns it
     *
     * @return Map<String, String> containing Manufacturer, Model, Android Version, SDK Version and Mindful version.
     */
    @NonNull
    public static Map<String, String> getDeviceInfoMap(@NonNull Context context) {
        HashMap<String, String> infoMap = new HashMap<>();
        String appVersion = "Unknown";

        try {
            PackageManager packageManager = context.getPackageManager();
            String packageName = context.getPackageName();
            PackageInfo packageInfo = packageManager.getPackageInfo(packageName, 0);

            appVersion = packageName.contains(".debug")
                    ? "v" + packageInfo.versionName + "-debug+" + packageInfo.versionCode
                    : "v" + packageInfo.versionName + "+" + packageInfo.versionCode;
        } catch (PackageManager.NameNotFoundException e) {
            Log.e(TAG, "getDeviceInfoMap: Error in fetching app version", e);
        }


        infoMap.put("manufacturer", Build.MANUFACTURER);
        infoMap.put("model", Build.MODEL);
        infoMap.put("androidVersion", Build.VERSION.RELEASE);
        infoMap.put("sdkVersion", String.valueOf(Build.VERSION.SDK_INT));
        infoMap.put("mindfulVersion", appVersion);


        return infoMap;
    }


    /**
     * Encodes a Drawable (app icon) to a Base64 string.
     *
     * @param iconData The Drawable to encode.
     * @return The Base64 encoded string representing the app icon.
     */
    private static String encodeToBase64(@NonNull Drawable iconData) {
        ByteArrayOutputStream byteArrayOS = new ByteArrayOutputStream();
        final Bitmap image = Bitmap.createBitmap(iconData.getIntrinsicWidth(), iconData.getIntrinsicHeight(), Bitmap.Config.ARGB_8888);

        final Canvas canvas = new Canvas(image);
        iconData.setBounds(0, 0, canvas.getWidth(), canvas.getHeight());
        iconData.draw(canvas);
        image.compress(Bitmap.CompressFormat.PNG, 100, byteArrayOS);
        return Base64.encodeToString(byteArrayOS.toByteArray(), Base64.NO_WRAP);
    }

    /**
     * Encodes and returns the Base64 representation of an app icon.
     *
     * @param icon The app icon as a Drawable.
     * @return The Base64 encoded string of the app icon.
     */
    public static String getEncodedAppIcon(Drawable icon) {
        String appIcon = "";
        try {
            appIcon = encodeToBase64(icon);
        } catch (Exception e) {
            Log.e(TAG, "getEncodedAppIcon: Cannot parse app icon from memory", e);
        }
        return appIcon;
    }

    /**
     * Converts the drawable to bitmap.
     *
     * @param drawable The Drawable which will be converted.
     * @return Bitmap The converted bitmap.
     */
    public static Bitmap drawableToBitmap(Drawable drawable) {
        if (drawable instanceof BitmapDrawable) {
            return ((BitmapDrawable) drawable).getBitmap();
        }

        Bitmap bitmap = Bitmap.createBitmap(drawable.getIntrinsicWidth(), drawable.getIntrinsicHeight(), Bitmap.Config.ARGB_8888);
        Canvas canvas = new Canvas(bitmap);
        drawable.setBounds(0, 0, canvas.getWidth(), canvas.getHeight());
        drawable.draw(canvas);

        return bitmap;
    }


    /**
     * Returns an empty string if the provided string is null.
     *
     * @param nullableString The string to check.
     * @return The original string if it's not null, otherwise an empty string.
     */
    @NonNull
    public static String notNullStr(@Nullable String nullableString) {
        if (nullableString != null) return nullableString;
        else return "";
    }

    /**
     * Null safe method that returns an empty string if the provided Intent is null or Intent's Action is null.
     *
     * @param intent The nullable Intent to check.
     * @return The action string if it's not null, otherwise an empty string.
     */
    @NonNull
    public static String getActionFromIntent(@Nullable Intent intent) {
        return intent == null ? "" : notNullStr(intent.getAction());
    }

    /**
     * Formats the total screen usage time into a human-readable string.
     * Example: 2:43:59
     *
     * @param totalSeconds The total screen usage time in seconds.
     * @return A string representing the formatted screen usage time.
     */
    @NonNull
    @Contract(pure = true)
    public static String secondsToTimeStr(long totalSeconds) {
        int leftHours = (int) (totalSeconds / 3600);
        int leftMinutes = (int) ((totalSeconds % 3600) / 60);
        int leftSeconds = (int) (totalSeconds % 60);

        StringBuilder timeStr = new StringBuilder();

        if (leftHours > 0) {
            timeStr.append(String.format(Locale.ENGLISH, "%02d", leftHours)).append("h ");
        }

        timeStr.append(String.format(Locale.ENGLISH, "%02d", leftMinutes)).append("m ");
        timeStr.append(String.format(Locale.ENGLISH, "%02d", leftSeconds)).append("s");

        return timeStr.toString();
    }

    /**
     * Create a calender instance from the Time Of Day total minutes.
     *
     * @param totalMinutes The total minutes from Time Of Day dart object.
     * @return Calender representing the time of day for today.
     */
    @NonNull
    @Contract(pure = true)
    public static Calendar todToTodayCal(int totalMinutes) {
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.HOUR_OF_DAY, totalMinutes / 60);
        cal.set(Calendar.MINUTE, totalMinutes % 60);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);

        return cal;
    }

    /**
     * Calculated the difference between time now and future tod minutes.
     *
     * @param totalMinutes The total minutes from Time Of Day dart object.
     * @return The different in MS. If the difference is negative then return 0
     */
    public static long todDifferenceFromNow(int totalMinutes) {
        long diff = System.currentTimeMillis() - todToTodayCal(totalMinutes).getTimeInMillis();
        return diff > 0 ? diff : 0;
    }

    /**
     * Checks if current system time is outside the star and end Time Of Day for today
     *
     * @param startTod The start TOD in minutes
     * @param endTod   The end TOD in minutes
     * @return Boolean indicating if now is outside startTod and endTod
     */
    public static boolean isTimeOutsideTODs(int startTod, int endTod) {
        long now = System.currentTimeMillis();
        return !(todToTodayCal(startTod).getTimeInMillis() < now && now < todToTodayCal(endTod).getTimeInMillis());
    }


    /**
     * Formats the total screen usage time into a human-readable string.
     * Example: 12h 45m
     *
     * @param totalMinutes The total screen usage time in minutes.
     * @return A string representing the formatted screen usage time.
     */
    @NonNull
    @Contract(pure = true)
    public static String minutesToTimeStr(int totalMinutes) {
        totalMinutes = Math.abs(totalMinutes);

        return totalMinutes > 60
                ? totalMinutes % 60 == 0
                ? totalMinutes / 60 + "h"
                : totalMinutes / 60 + "h " + totalMinutes % 60 + "m"
                : totalMinutes + "m";
    }


    /**
     * Formats the total data usage into a human-readable string.
     * Example: 12.35 GB
     *
     * @param totalMBs The total data usage in megabytes (MB).
     * @return A string representing the formatted data usage.
     */
    @NonNull
    @Contract(pure = true)
    public static String formatDataMBs(int totalMBs) {
        totalMBs = Math.abs(totalMBs);

        if (totalMBs >= 1024) {
            float GBs = totalMBs / 1024f;
            String formattedGBs = String.format(Locale.getDefault(), "%.2f", GBs);
            return formattedGBs + " GB";
        } else {
            return totalMBs + " MB";
        }
    }


    /**
     * Ensures the given URL uses the HTTPS protocol.
     *
     * <p>If the URL starts with "https://", it is returned unchanged. If it starts with
     * "http://", the protocol is changed to "https://". If no protocol is present,
     * "https://" is added.</p>
     *
     * @param url The URL to validate (must not be null).
     * @return A URL that starts with "https://".
     */
    public static String validateHttpsProtocol(@NonNull String url) {
        return url.startsWith("https://") ? url :
                url.startsWith("http://") ?
                        url.replace("http://", "https://") : ("https://" + url);
    }

    /**
     * Parses the host name from a URL string.
     *
     * @param url The URL string to parse.
     * @return The host name extracted from the URL.
     */
    @NonNull
    public static String parseHostNameFromUrl(String url) {
        URI uri;
        String hostName = null;

        try {
            uri = new URI(url);
            hostName = uri.getHost();
        } catch (URISyntaxException e) {
            Log.w(TAG, "parseHostNameFromUrl: Cannot parse url using URI method, trying different method", e);
        }

        if (hostName != null) return hostName;

        // If host name is still null then reassign with url
        hostName = url;

        // Remove prefix from url
        hostName = hostName.replace("https://", "").replace("http://", "").replace("www.", "");

        // Some websites use mobile. OR m. prefix
        if (hostName.contains("mobile.")) {
            hostName = hostName.substring(7);
        } else if (hostName.contains("m.") && hostName.indexOf("m.") < 3) {
            hostName = hostName.substring(2);
        }

        // If the url still contains / then remove it
        if (hostName.contains("/")) {
            return hostName.substring(0, hostName.indexOf("/"));
        }

        return hostName;
    }
}
