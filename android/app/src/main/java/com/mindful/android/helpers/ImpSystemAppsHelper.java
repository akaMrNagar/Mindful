package com.mindful.android.helpers;

import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.util.HashSet;

/**
 * ImpSystemAppsHelper provides utility methods for identifying important system applications on the device.
 * These include the default launcher and dialer apps.
 */
public class ImpSystemAppsHelper {

    /**
     * Fetches a set of important system apps, including the default launcher and dialer apps.
     *
     * @param packageManager The package manager used to resolve the default apps.
     * @return A HashSet containing the package names of important system apps.
     */
    @NonNull
    public static HashSet<String> fetchImpApps( @NonNull PackageManager packageManager) {
        HashSet<String> impSystemApps = new HashSet<>();

        // Get and add the package names of the default launcher and dialer app.
        @Nullable
        String launcher = getDefaultLauncherPackageName(packageManager);
        @Nullable
        String caller = getDefaultDialerPackageName(packageManager);

        if (launcher != null) impSystemApps.add(launcher);
        if (caller != null) impSystemApps.add(caller);

        return impSystemApps;
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
