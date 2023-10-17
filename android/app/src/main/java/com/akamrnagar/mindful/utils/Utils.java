package com.akamrnagar.mindful.utils;

import android.app.ActivityManager;
import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.drawable.Drawable;
import android.util.Base64;

import androidx.annotation.NonNull;

import com.akamrnagar.mindful.services.MindfulAppsTrackerService;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.ByteArrayOutputStream;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;

import io.flutter.Log;

public class Utils {

    private static final int SYSTEM_APP_MASK = ApplicationInfo.FLAG_SYSTEM | ApplicationInfo.FLAG_UPDATED_SYSTEM_APP;

    public static boolean isSystemApp(@NonNull PackageInfo packageInfo) {
        return (packageInfo.applicationInfo.flags & SYSTEM_APP_MASK) != 0;
    }

    public static boolean isSystemApp(Context context, String packageName) {
        PackageManager packageManager = context.getPackageManager();

        PackageInfo info = null;
        try {
            info = packageManager.getPackageInfo(packageName, PackageManager.GET_META_DATA);
        } catch (PackageManager.NameNotFoundException e) {
            throw new RuntimeException(e);
        }

        return isSystemApp(info);
    }

    private static String encodeToBase64(Drawable iconData) {
        ByteArrayOutputStream byteArrayOS = new ByteArrayOutputStream();
        Bitmap image = getBitmapFromDrawable(iconData);
        image.compress(Bitmap.CompressFormat.PNG, 100, byteArrayOS);
        return Base64.encodeToString(byteArrayOS.toByteArray(), Base64.NO_WRAP);
    }

    private static Bitmap getBitmapFromDrawable(@NonNull Drawable drawable) {
        final Bitmap bmp = Bitmap.createBitmap(
                drawable.getIntrinsicWidth(),
                drawable.getIntrinsicHeight(),
                Bitmap.Config.ARGB_8888);

        final Canvas canvas = new Canvas(bmp);
        drawable.setBounds(0, 0, canvas.getWidth(), canvas.getHeight());
        drawable.draw(canvas);

        return bmp;
    }

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
     * @param context
     * @param serviceClassName ex: MindfulAppsTrackerService.class.getName()
     * @return is the given service running
     */
    public static boolean isServiceRunning(@NonNull Context context, String serviceClassName) {
        boolean isServiceRunning = false;

        ActivityManager activityManager = (ActivityManager) context.getSystemService(Context.ACTIVITY_SERVICE);
        for (ActivityManager.RunningServiceInfo serviceInfo : activityManager.getRunningServices(Integer.MAX_VALUE)) {
            if (serviceInfo.service.getClassName().equals(serviceClassName)) {
                return true;
            }
        }
        return isServiceRunning;
    }

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
