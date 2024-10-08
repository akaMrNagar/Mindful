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
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.ByteArrayOutputStream;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Locale;
import java.util.Map;

/**
 * A utility class containing static helper methods for various common tasks such as
 * checking if a service is running, encoding images, parsing JSON strings, and manipulating URLs.
 */
public class Utils {
    private static final String TAG = "Mindful.Utils";

    /**
     * Resolve the version string for the app
     *
     * @param context The application context.
     * @return Version string include version and build code
     */
    @NonNull
    public static String getAppVersion(@NonNull Context context) {
        try {
            PackageManager packageManager = context.getPackageManager();
            String packageName = context.getPackageName();
            PackageInfo packageInfo = packageManager.getPackageInfo(packageName, 0);

            return packageName.contains(".debug")
                    ? "DEBUG " + "v" + packageInfo.versionName + "+" + packageInfo.versionCode
                    : "v" + packageInfo.versionName + "+" + packageInfo.versionCode;
        } catch (PackageManager.NameNotFoundException e) {
            Log.e(TAG, "getAppVersion: Error in fetching app version", e);
        }
        return "v0.0.0";
    }

    /**
     * Resolve the device information and  returns it
     *
     * @return Map<String, String> containing Manufacturer, Model, Android Version and SDK Version.
     */
    @NonNull
    public static Map<String, String> getDeviceInfoMap() {
        HashMap<String, String> infoMap = new HashMap<>();

        infoMap.put("Manufacturer", Build.MANUFACTURER);
        infoMap.put("Model", Build.MODEL);
        infoMap.put("Android Version", Build.VERSION.RELEASE);
        infoMap.put("SDK Version", String.valueOf(Build.VERSION.SDK_INT));

        return infoMap;
    }

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
     * Deserializes a JSON string into a HashMap of String keys and Long values.
     *
     * @param jsonString The JSON string to deserialize.
     * @return A HashMap containing the deserialized data.
     */
    @NonNull
    public static HashMap<String, Long> jsonStrToStringLongHashMap(@NonNull String jsonString) {
        HashMap<String, Long> map = new HashMap<>();
        if (jsonString.isEmpty()) return map;

        try {
            JSONObject jsonObject = new JSONObject(jsonString);

            for (Iterator<String> it = jsonObject.keys(); it.hasNext(); ) {
                String key = it.next();
                Long value = jsonObject.getLong(key);
                map.put(key, value);
            }
        } catch (JSONException e) {
            Log.e(TAG, "jsonStrToAppTimersMap: Error deserializing JSON to timers map ", e);
        }
        return map;
    }

    /**
     * Deserializes a JSON string into a HashSet of String.
     *
     * @param jsonString The JSON string to deserialize.
     * @return A HashSet containing the deserialized data.
     */
    @NonNull
    public static HashSet<String> jsonStrToStringHashSet(@NonNull String jsonString) {
        HashSet<String> set = new HashSet<>();
        if (jsonString.isEmpty()) return set;

        try {
            JSONArray jsonArray = new JSONArray(jsonString);
            for (int i = 0; i < jsonArray.length(); i++) {
                set.add(jsonArray.getString(i));
            }
        } catch (JSONException e) {
            Log.e(TAG, "jsonStrToLockedAppsSet: Error deserializing JSON to locked apps hashset ", e);
        }
        return set;
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
     *
     * @param totalSeconds The total screen usage time in seconds.
     * @return A string representing the formatted screen usage time.
     */
    @NonNull
    @Contract(pure = true)
    public static String secondsToTimeStr(long totalSeconds) {
        int leftHours = (int) (totalSeconds / 60 / 60);
        int leftMinutes = (int) ((totalSeconds / 60) % 60);
        int leftSeconds = (int) (totalSeconds % 60);

        return
                leftHours > 0 ?
                        leftHours + ":" + leftMinutes + ":" + leftSeconds :
                        leftMinutes + ":" + leftSeconds;

    }

    /**
     * Formats the total screen usage time into a human-readable string.
     *
     * @param totalMinutes The total screen usage time in minutes.
     * @return A string representing the formatted screen usage time.
     */
    @NonNull
    @Contract(pure = true)
    public static String formatScreenTime(int totalMinutes) {
        totalMinutes = Math.abs(totalMinutes);

        return totalMinutes > 60
                ? totalMinutes % 60 == 0
                ? totalMinutes / 60 + "h"
                : totalMinutes / 60 + "h " + totalMinutes % 60 + "m"
                : totalMinutes + "m";
    }

    /**
     * Formats the total data usage into a human-readable string.
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
}
