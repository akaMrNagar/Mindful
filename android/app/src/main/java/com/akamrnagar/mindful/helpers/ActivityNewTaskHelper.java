package com.akamrnagar.mindful.helpers;

import android.content.ActivityNotFoundException;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.provider.Settings;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.akamrnagar.mindful.services.MindfulAccessibilityService;

public class ActivityNewTaskHelper {

    private static final String TAG = "Mindful.ActivityNewTaskHelper";

    public static void openMindfulAccessibilitySection(@NonNull Context context) {
        if (!ServicesHelper.isServiceRunning(context, MindfulAccessibilityService.class.getName())) {
            context.startActivity(new Intent(Settings.ACTION_ACCESSIBILITY_SETTINGS));
            Toast.makeText(context, "Please enable Mindful accessibility service", Toast.LENGTH_LONG).show();
        }
    }

    public static void openDoNotDisturbAccessSection(@NonNull Context context) {
        Intent intent = new Intent(Settings.ACTION_NOTIFICATION_POLICY_ACCESS_SETTINGS);
        context.startActivity(intent);
        Toast.makeText(context, "Please allow do not disturb access to Mindful", Toast.LENGTH_LONG).show();
    }

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

    public static void openAppSettingsForPackage(@NonNull Context context, @Nullable String appPackage) {
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
            Toast.makeText(context, "Package not found, unable to launch app settings", Toast.LENGTH_SHORT).show();
        }

    }

    public static void openDeviceDndSettings(@NonNull Context context) {
        try {
            context.startActivity(new Intent("android.settings.ZEN_MODE_SETTINGS"));
        } catch (ActivityNotFoundException e) {
            Log.e(TAG, "openDeviceDndSettings: Unable to open device DND settings", e);
            Toast.makeText(context, "Unable to open DND settings", Toast.LENGTH_SHORT).show();
        }

    }

}
