package com.mindful.android.services.accessibility

import android.content.Context
import android.util.Log
import android.view.accessibility.AccessibilityNodeInfo
import com.mindful.android.R
import com.mindful.android.helpers.device.PermissionsHelper
import com.mindful.android.models.WellBeingSettings
import com.mindful.android.utils.AppConstants.SYSTEM_SETTINGS_PACKAGE

class DeviceFeaturesManager(
    private val context: Context,
    private val blockedContentGoBack: () -> Unit,
) {

    /**
     * Checks if a blocked feature is open and applies restrictions.
     *
     * @param packageName The package name of the current app in focus.
     * @param node The root `AccessibilityNodeInfo` of the current screen.
     * @param settings The user's `WellBeingSettings`.
     */
    fun blockFeatures(
        packageName: String,
        node: AccessibilityNodeInfo,
        settings: WellBeingSettings,
    ) {

        /// Check if blocking is enabled for platforms
        val isFeatureOpen = when (packageName) {
            SYSTEM_SETTINGS_PACKAGE -> isSettingsTamperFeatureOpen(context, node)

            else -> false
        }

        if (isFeatureOpen) {
            blockedContentGoBack.invoke()
        }
    }

    companion object {
        /**
         * Checks if Device Settings features (Admin or Accessibility) are open for mindful.
         */
        private fun isSettingsTamperFeatureOpen(
            context: Context,
            node: AccessibilityNodeInfo,
        ): Boolean {
            // Check for Admin section
            val isAdminSectionOpen =
                node.findAccessibilityNodeInfosByViewId("com.android.settings:id/admin_name")
                    .firstOrNull()?.text == context.getString(R.string.app_name)


            // Check for Accessibility section
            val isAccessibilitySectionOpen =
                node.findAccessibilityNodeInfosByText(context.getString(R.string.app_name))
                    .isNotEmpty() &&
                        node.findAccessibilityNodeInfosByText(context.getString(R.string.accessibility_description))
                            .isNotEmpty()

            return (isAdminSectionOpen || isAccessibilitySectionOpen) &&
                    PermissionsHelper.getAndAskAdminPermission(context, false)
        }
    }
}