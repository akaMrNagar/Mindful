package com.akamrnagar.mindful.helpers;

import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.akamrnagar.mindful.utils.AppConstants;

import java.util.HashSet;

/**
 * ImpSystemAppsHelper is a utility class responsible for identifying and managing important
 * system applications on an Android device.
 * It helps to initialize and maintain a list of system applications that are considered essential
 * for the proper functioning of the device.
 */
public class ImpSystemAppsHelper {

    /**
     * A set containing package names of important system applications.
     */
    public static HashSet<String> impSystemApps;


    /**
     * Initializes the set of important system applications.
     *
     * @param context        The Android application context.
     * @param packageManager The package manager used for resolving default apps.
     */
    public static void init(@NonNull Context context, @Nullable PackageManager packageManager) {
        impSystemApps = new HashSet<>();
        impSystemApps.add(AppConstants.MINDFUL_APP_PACKAGE);

        if (packageManager == null) {
            packageManager = context.getPackageManager();
        }

        // Get and add the package names of the default launcher and dialer app.
        @Nullable
        String launcher = getDefaultLauncherPackageName(packageManager);
        @Nullable
        String caller = getDefaultDialerPackageName(packageManager);

        if (launcher != null) impSystemApps.add(launcher);
        if (caller != null) impSystemApps.add(caller);
    }

    /**
     * Gets the package name of the default launcher app.
     *
     * @param packageManager The package manager used for resolving the default launcher.
     * @return The package name of the default launcher app or null if not found.
     */
    @Nullable
    private static String getDefaultLauncherPackageName(@NonNull PackageManager packageManager) {
        Intent intent = new Intent(Intent.ACTION_MAIN);
        intent.addCategory(Intent.CATEGORY_HOME);
        ResolveInfo resolveInfo = packageManager.resolveActivity(intent, PackageManager.MATCH_DEFAULT_ONLY);

        if (resolveInfo != null && resolveInfo.activityInfo != null) {
            return resolveInfo.activityInfo.packageName;
        } else {
            return null;
        }
    }


    /**
     * Gets the package name of the default dialer app.
     *
     * @param packageManager The package manager used for resolving the default dialer app.
     * @return The package name of the default dialer app or null if not found.
     */
    @Nullable
    private static String getDefaultDialerPackageName(@NonNull PackageManager packageManager) {
        Intent intent = new Intent(Intent.ACTION_DIAL);
        intent.addCategory(Intent.CATEGORY_DEFAULT);
        ResolveInfo resolveInfo = packageManager.resolveActivity(intent, PackageManager.MATCH_DEFAULT_ONLY);

        if (resolveInfo != null && resolveInfo.activityInfo != null) {
            return resolveInfo.activityInfo.packageName;
        } else {
            return null;
        }
    }
}
