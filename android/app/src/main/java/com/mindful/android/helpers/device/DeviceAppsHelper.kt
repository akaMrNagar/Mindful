package com.mindful.android.helpers.device

import android.content.Context
import android.content.Intent
import android.content.pm.ApplicationInfo
import com.mindful.android.AppConstants
import com.mindful.android.AppConstants.REMOVED_APP_NAME
import com.mindful.android.AppConstants.REMOVED_PACKAGE
import com.mindful.android.AppConstants.TETHERING_APP_NAME
import com.mindful.android.AppConstants.TETHERING_PACKAGE
import com.mindful.android.utils.AppUtils

object DeviceAppsHelper {

    /**
     * Retrieves a list of installed device apps with their infos.
     *
     * @param context       The context to use for fetching app information.
     * @param onSuccess Callback which will be invoke after fetching infos.
     */
    fun getDeviceAppInfos(
        context: Context,
        onSuccess: (data: Any) -> Unit,
    ) {
        Thread {
            val packageManager = context.packageManager

            // Fetch set of important apps like Dialer, Launcher etc.
            val impSystemApps = ImpSystemAppsHelper.fetchImpApps(packageManager)
            impSystemApps.add(context.packageName)
            impSystemApps.add(AppConstants.SETTINGS_PACKAGE)

            // Fetch set of all launchable apps
            val launchableApps = packageManager.queryIntentActivities(
                Intent(Intent.ACTION_MAIN).addCategory(Intent.CATEGORY_LAUNCHER),
                0
            )


            val deviceAppsMapList: MutableList<Map<String, Any>> = launchableApps
                .map { appInfo ->
                    getAppInfoMap(
                        name = appInfo.loadLabel(packageManager).toString(),
                        packageName = appInfo.activityInfo.packageName,
                        isImpSysApp = impSystemApps.contains(appInfo.activityInfo.packageName),
                        appIcon = AppUtils.getEncodedAppIcon(
                            packageManager.getApplicationIcon(
                                appInfo.activityInfo.applicationInfo
                            )
                        ),
                    )
                }.toMutableList()


            // Get placeholder icon
            val placeholderIcon = AppUtils.getEncodedAppIcon(
                packageManager.getApplicationIcon(
                    ApplicationInfo()
                )
            )

            // Add additional apps for network usage
            deviceAppsMapList.add(
                getAppInfoMap(
                    name = TETHERING_APP_NAME,
                    packageName = TETHERING_PACKAGE,
                    isImpSysApp = true,
                    appIcon = placeholderIcon,
                )
            )

            // removed apps
            deviceAppsMapList.add(
                getAppInfoMap(
                    name = REMOVED_APP_NAME,
                    packageName = REMOVED_PACKAGE,
                    isImpSysApp = true,
                    appIcon = placeholderIcon,
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