package com.akamrnagar.mindful.helpers;

import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.akamrnagar.mindful.utils.AppConstants;

import java.util.HashSet;

public class ImpSystemAppsHelper {
    public static HashSet<String> impSystemApps;

        public static void init(@NonNull Context context, @Nullable PackageManager packageManager) {
        impSystemApps = new HashSet<>();
        impSystemApps.add(AppConstants.MY_APP_PACKAGE);

        if (packageManager == null) {
            packageManager = context.getPackageManager();
        }

        @Nullable
        String launcher = getDefaultLauncherPackageName(context, packageManager);
        @Nullable
        String caller = getDefaultCallerPackageName(context, packageManager);

        if (launcher != null) impSystemApps.add(launcher);
        if (caller != null) impSystemApps.add(caller);
    }

    @Nullable
    private static String getDefaultLauncherPackageName(@NonNull Context context, @NonNull PackageManager packageManager) {
        Intent intent = new Intent(Intent.ACTION_MAIN);
        intent.addCategory(Intent.CATEGORY_HOME);
        ResolveInfo resolveInfo = packageManager.resolveActivity(intent, PackageManager.MATCH_DEFAULT_ONLY);

        if (resolveInfo != null && resolveInfo.activityInfo != null) {
            return resolveInfo.activityInfo.packageName;
        } else {
            return null;
        }
    }


    @Nullable
    private static String getDefaultCallerPackageName(@NonNull Context context, @NonNull PackageManager packageManager) {
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
