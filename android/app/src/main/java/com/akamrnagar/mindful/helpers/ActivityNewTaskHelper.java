package com.akamrnagar.mindful.helpers;

import android.app.admin.DevicePolicyManager;
import android.content.ActivityNotFoundException;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Build;
import android.provider.Settings;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.akamrnagar.mindful.R;
import com.akamrnagar.mindful.services.MindfulAccessibilityService;

public class ActivityNewTaskHelper {

    private static final String TAG = "Mindful.ActivityNewTaskHelper";

    public static void launchUrl(@NonNull Context context, @NonNull String url) {
        try {
            Intent urlIntent = new Intent(Intent.ACTION_VIEW).setData(Uri.parse(url));
            context.startActivity(urlIntent);
        } catch (Exception e) {
            Log.e(TAG, "launchUrl: Unable to launch url: " + url, e);
            Toast.makeText(context, "Invalid url", Toast.LENGTH_SHORT).show();
        }

    }

    // SECTION: For MINDFUL app ====================================================================
    public static void openMindfulAccessibilitySection(@NonNull Context context) {
        if (!ServicesHelper.isServiceRunning(context, MindfulAccessibilityService.class.getName())) {
            context.startActivity(new Intent(Settings.ACTION_ACCESSIBILITY_SETTINGS));
            Toast.makeText(context, "Please enable Mindful accessibility service", Toast.LENGTH_LONG).show();
        }
    }

    public static void openMindfulDeviceAdminSection(@NonNull Context context, ComponentName componentName) {
        try {
            Intent intent = new Intent(DevicePolicyManager.ACTION_ADD_DEVICE_ADMIN);
            intent.putExtra(DevicePolicyManager.EXTRA_DEVICE_ADMIN, componentName);
            intent.putExtra(DevicePolicyManager.EXTRA_ADD_EXPLANATION, R.string.admin_description);
            context.startActivity(intent);
        } catch (ActivityNotFoundException e) {
            Log.e(TAG, "openDeviceAdminSettings: Unable to open device ADMIN settings", e);
            Toast.makeText(context, "Unable to open ADMIN settings", Toast.LENGTH_SHORT).show();
        }

    }

    public static void openMindfulNotificationSection(@NonNull Context context) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            Intent intent = new Intent();
            intent.setAction(Settings.ACTION_APP_NOTIFICATION_SETTINGS);
            intent.putExtra(Settings.EXTRA_APP_PACKAGE, context.getPackageName());
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            context.startActivity(intent);

        } else {
            openSettingsForPackage(context, context.getPackageName());
        }
        Toast.makeText(context, "Please enable notification", Toast.LENGTH_LONG).show();
    }

    // SECTION: For device setting sections or pages app ===========================================
    public static void openDeviceUsageAccessSection(@NonNull Context context) {
        Intent intent = new Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS);
        context.startActivity(intent);
        Toast.makeText(context, "Please allow usage access to Mindful", Toast.LENGTH_LONG).show();
    }

    public static void openDeviceDoNotDisturbAccessSection(@NonNull Context context) {
        Intent intent = new Intent(Settings.ACTION_NOTIFICATION_POLICY_ACCESS_SETTINGS);
        context.startActivity(intent);
        Toast.makeText(context, "Please allow do not disturb access to Mindful", Toast.LENGTH_LONG).show();
    }

    public static void openDeviceDndSettings(@NonNull Context context) {
        try {
            context.startActivity(new Intent("android.settings.ZEN_MODE_SETTINGS"));
        } catch (ActivityNotFoundException e) {
            Log.e(TAG, "openDeviceDndSettings: Unable to open device DND settings", e);
            Toast.makeText(context, "Unable to open DND settings", Toast.LENGTH_SHORT).show();
        }
    }

    // SECTION: For different app packages =========================================================
    public static void openAppWithPackage(@NonNull Context context, @Nullable String appPackage) {
        if (appPackage == null || appPackage.isEmpty()) {
            Toast.makeText(context, "Package not found, unable to launch app", Toast.LENGTH_SHORT).show();
            return;
        }

        try {
            Intent appIntent = context.getPackageManager().getLaunchIntentForPackage(appPackage);

            if (appIntent != null) {
                context.startActivity(appIntent);
            }
        } catch (ActivityNotFoundException e) {
            Log.e(TAG, "openAppWithPackage: Unable to launch app : " + appPackage, e);
            Toast.makeText(context, "Package not found, unable to launch app", Toast.LENGTH_SHORT).show();
        }

    }

    public static void openSettingsForPackage(@NonNull Context context, @Nullable String appPackage) {
        if (appPackage == null || appPackage.isEmpty()) {
            Toast.makeText(context, "Package not found, unable to launch app settings", Toast.LENGTH_SHORT).show();
            return;
        }

        try {
            if (context.getPackageManager().getLaunchIntentForPackage(appPackage) != null) {
                Intent intent = new Intent(android.provider.Settings.ACTION_APPLICATION_DETAILS_SETTINGS);
                intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                intent.setData(Uri.parse("package:" + appPackage));
                context.startActivity(intent);
            }

        } catch (ActivityNotFoundException e) {
            Log.e(TAG, "openAppSettingsForPackage: Unable to launch app settings for " + appPackage, e);
            Toast.makeText(context, "Unable to launch app settings", Toast.LENGTH_SHORT).show();
        }
    }


}
