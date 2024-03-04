package com.akamrnagar.mindful.utils;

import android.content.pm.ApplicationInfo;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.drawable.Drawable;
import android.util.Base64;

import androidx.annotation.NonNull;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.ByteArrayOutputStream;
import java.util.HashMap;
import java.util.Iterator;

import io.flutter.Log;

public class Utils {

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
            Log.e(AppConstants.ERROR_TAG, "Cannot parse app icon: " + e.getMessage());
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
    public static HashMap<String, Long> deserializeMap(String jsonString) {
        HashMap<String, Long> map = new HashMap<>();
        try {
            JSONObject jsonObject = new JSONObject(jsonString);

            for (Iterator<String> it = jsonObject.keys(); it.hasNext(); ) {
                String key = it.next();
                Long value = jsonObject.getLong(key);
                map.put(key, value);
            }
        } catch (JSONException e) {
            Log.e(AppConstants.ERROR_TAG, "Error deserializing JSON to a map: " + e.getMessage());
        }
        return map;
    }


}
