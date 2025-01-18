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
package com.mindful.android.helpers.device

import android.content.Intent
import android.content.pm.PackageManager

/**
 * ImpSystemAppsHelper provides utility methods for identifying important system applications on the device.
 * These include the default launcher and dialer apps.
 */
object ImpSystemAppsHelper {
    /**
     * Fetches a set of important system apps, including the default launcher and dialer apps.
     *
     * @param packageManager The package manager used to resolve the default apps.
     * @return A HashSet containing the package names of important system apps.
     */
    fun fetchImpApps(packageManager: PackageManager): HashSet<String> {
        val impSystemApps = HashSet<String>()

        // Get and add the package names of the default launcher and dialer app.
        val launcherAppPackage = getDefaultLauncherPackageName(packageManager)
        val callerAppPackage = getDefaultDialerPackageName(packageManager)

        if (launcherAppPackage != null) impSystemApps.add(launcherAppPackage)
        if (callerAppPackage != null) impSystemApps.add(callerAppPackage)

        return impSystemApps
    }

    /**
     * Gets the package name of the default launcher app.
     *
     * @param packageManager The package manager used for resolving the default launcher.
     * @return The package name of the default launcher app or null if not found.
     */
    private fun getDefaultLauncherPackageName(packageManager: PackageManager): String? {
        val intent = Intent(Intent.ACTION_MAIN)
        intent.addCategory(Intent.CATEGORY_HOME)
        val resolveInfo = packageManager.resolveActivity(intent, PackageManager.MATCH_DEFAULT_ONLY)
        return resolveInfo?.activityInfo?.packageName
    }

    /**
     * Gets the package name of the default dialer app.
     *
     * @param packageManager The package manager used for resolving the default dialer app.
     * @return The package name of the default dialer app or null if not found.
     */
    private fun getDefaultDialerPackageName(packageManager: PackageManager): String? {
        val intent = Intent(Intent.ACTION_DIAL)
        intent.addCategory(Intent.CATEGORY_DEFAULT)
        val resolveInfo = packageManager.resolveActivity(intent, PackageManager.MATCH_DEFAULT_ONLY)
        return resolveInfo?.activityInfo?.packageName
    }
}
