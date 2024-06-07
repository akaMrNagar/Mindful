package com.akamrnagar.mindful.utils;

import android.content.pm.ApplicationInfo;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.drawable.Drawable;
import android.util.Base64;
import android.util.Log;

import androidx.annotation.NonNull;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.ByteArrayOutputStream;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;

public class Utils {
    private static final String TAG = "Mindful.Utils";

    private static final int SYSTEM_APP_MASK = ApplicationInfo.FLAG_SYSTEM | ApplicationInfo.FLAG_UPDATED_SYSTEM_APP;

    /**
     * Encodes a Drawable (app icon) to a Base64 string.
     *
     * @param iconData The Drawable to encode.
     * @return The Base64 encoded string representing the app icon.
     */
    private static String encodeToBase64(@NonNull Drawable iconData) {
        ByteArrayOutputStream byteArrayOS = new ByteArrayOutputStream();
        final Bitmap image = Bitmap.createBitmap(
                iconData.getIntrinsicWidth(),
                iconData.getIntrinsicHeight(),
                Bitmap.Config.ARGB_8888);

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
//            JSONObject jsonObject = new JSONObject(jsonString);
//
//            for (Iterator<String> it = jsonObject.keys(); it.hasNext(); ) {
//                set.add(it.next());
//            }
        } catch (JSONException e) {
            Log.e(TAG, "jsonStrToLockedAppsSet: Error deserializing JSON to locked apps hashset ", e);
        }
        return set;
    }

    public static String parseHostNameFromUrl(String url) {
        URI uri;

        try {
            uri = new URI(url);
        } catch (URISyntaxException e) {
            e.printStackTrace();
            return url;
        }

        String hostName = uri.getHost();

        // If null, then hostname = the original url ?
        if (hostName == null) {
            hostName = url;
        }

        hostName = hostName.replace("https://", "").replace("http://", "").replace("www.", "");


        if (hostName.contains("www.")) {
            hostName = hostName.substring(4);
        }

        // Fuck you websites that use mobile prefix and break my hashmap
        if (hostName.contains("mobile.")) {
            hostName = hostName.substring(7);
        } else if (hostName.contains("m.") && hostName.indexOf("m.") < 3) {
            // medium.com => dium.com smh todo?
            hostName = hostName.substring(2);
        }

        // Fuck you no path allowed
        if (hostName.contains("/")) {
            return hostName.substring(0, hostName.indexOf("/"));
        }

//        Log.d(TAG, "getHostName: url++ = " + hostName);
        return hostName;

    }


}
