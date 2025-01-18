package com.mindful.android.helpers.device

import android.content.Context
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import com.mindful.android.utils.AppConstants.REMOVED_APP_NAME
import com.mindful.android.utils.AppConstants.REMOVED_PACKAGE
import com.mindful.android.utils.AppConstants.TETHERING_APP_NAME
import com.mindful.android.utils.AppConstants.TETHERING_PACKAGE
import com.mindful.android.utils.Utils

object DeviceAppsHelper {

    /**
     * Retrieves a list of installed device apps with their infos.
     *
     * @param context       The context to use for fetching app information.
     * @param onSuccess Callback which will be invoke after fetching infos.
     */
    fun getDeviceAppInfos(
        context: Context,
        onSuccess: (data: Any) -> Unit
    ) {
        Thread {
            val packageManager = context.packageManager

            // Fetch set of important apps like Dialer, Launcher etc.
            val impSystemApps = ImpSystemAppsHelper.fetchImpApps(packageManager)
            impSystemApps.add(context.packageName)


            // Fetch package info of installed apps on device
            val fetchedApps = packageManager.getInstalledPackages(PackageManager.GET_META_DATA)
            val deviceAppsMapList: MutableList<Map<String, Any>> = ArrayList()

            for (app in fetchedApps) {
                // Only include apps which are launchable
                if (packageManager.getLaunchIntentForPackage(app.packageName) != null) {
                    // Check if the app is important or default to system like dialer and launcher
                    val isSysDefault = impSystemApps.contains(app.packageName)
                    deviceAppsMapList.add(
                        getAppInfoMap(
                            name = app.applicationInfo.loadLabel(packageManager).toString(),  // name
                            packageName = app.packageName,  // package name
                            isImpSysApp = isSysDefault,  // is default app used by system like dialer or launcher
                            appIcon = Utils.getEncodedAppIcon(packageManager.getApplicationIcon(app.applicationInfo)),  // icon
                        )
                    )
                }
            }


            // Add additional apps for network usage
            deviceAppsMapList.add(
                getAppInfoMap(
                    name = TETHERING_APP_NAME,
                    packageName = TETHERING_PACKAGE,
                    isImpSysApp = true,
                    appIcon = Utils.getEncodedAppIcon(packageManager.getApplicationIcon(ApplicationInfo())),
                )
            )

            // removed apps
            deviceAppsMapList.add(
                getAppInfoMap(
                    name = REMOVED_APP_NAME,
                    packageName = REMOVED_PACKAGE,
                    isImpSysApp = true,
                    appIcon = Utils.getEncodedAppIcon(packageManager.getApplicationIcon(ApplicationInfo())),
                )
            )

            onSuccess(deviceAppsMapList)
        }.start()
    }

    private fun getAppInfoMap(
        name: String,
        packageName: String,
        isImpSysApp: Boolean,
        appIcon: String,
    ): Map<String, Any> {
        return mapOf(
            "appName" to name,
            "packageName" to packageName,
            "isImpSysApp" to isImpSysApp,
            "appIcon" to appIcon,
        );
    }
}