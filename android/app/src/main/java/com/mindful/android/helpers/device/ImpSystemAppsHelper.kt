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
        return HashSet<String>(3).apply {
            getDefaultLauncherPackageName(packageManager)?.let { add(it) }
            getDefaultDialerPackageName(packageManager)?.let { add(it) }
        }
    }

    /**
     * Gets the package name of the default launcher app.
     *
     * @param packageManager The package manager used for resolving the default launcher.
     * @return The package name of the default launcher app or null if not found.
     */
    private fun getDefaultLauncherPackageName(packageManager: PackageManager): String? =
        packageManager.resolveActivity(
            Intent(Intent.ACTION_MAIN).addCategory(Intent.CATEGORY_HOME),
            PackageManager.MATCH_DEFAULT_ONLY
        )?.activityInfo?.packageName

    /**
     * Gets the package name of the default dialer app.
     *
     * @param packageManager The package manager used for resolving the default dialer app.
     * @return The package name of the default dialer app or null if not found.
     */
    private fun getDefaultDialerPackageName(packageManager: PackageManager): String? =
        packageManager.resolveActivity(
            Intent(Intent.ACTION_DIAL).addCategory(Intent.CATEGORY_DEFAULT),
            PackageManager.MATCH_DEFAULT_ONLY
        )?.activityInfo?.packageName
}
