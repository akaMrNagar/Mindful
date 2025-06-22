package com.mindful.android

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.content.res.Configuration
import android.net.VpnService
import androidx.activity.result.ActivityResultLauncher
import com.mindful.android.enums.DndWakeLock
import com.mindful.android.generics.SafeServiceConnection
import com.mindful.android.generics.ServiceBinder
import com.mindful.android.helpers.AlarmTasksSchedulingHelper.cancelBedtimeRoutineTasks
import com.mindful.android.helpers.AlarmTasksSchedulingHelper.cancelNotificationBatchTask
import com.mindful.android.helpers.AlarmTasksSchedulingHelper.scheduleBedtimeRoutineTasks
import com.mindful.android.helpers.AlarmTasksSchedulingHelper.scheduleNotificationBatchTask
import com.mindful.android.helpers.device.DeviceAppsHelper.getDeviceAppInfos
import com.mindful.android.helpers.device.NewActivitiesLaunchHelper
import com.mindful.android.helpers.device.NotificationHelper
import com.mindful.android.helpers.device.PermissionsHelper
import com.mindful.android.helpers.storage.SharedPrefsHelper
import com.mindful.android.helpers.usages.AppsUsageHelper.getAppsUsageForInterval
import com.mindful.android.models.TimeTracker
import com.mindful.android.models.WebRestriction
import com.mindful.android.models.AppRestriction
import com.mindful.android.models.BedtimeSchedule
import com.mindful.android.models.FocusSession
import com.mindful.android.models.Notification
import com.mindful.android.models.NotificationSettings
import com.mindful.android.models.RestrictionGroup
import com.mindful.android.services.notification.MindfulNotificationListenerService
import com.mindful.android.services.timer.EmergencyPauseService
import com.mindful.android.services.timer.FocusSessionService
import com.mindful.android.services.tracking.MindfulTrackerService
import com.mindful.android.services.vpn.MindfulVpnService
import com.mindful.android.utils.AppUtils
import com.mindful.android.utils.JsonUtils
import com.mindful.android.utils.Utils
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import java.util.Locale

class FgMethodCallHandler(
    private val context: Context,
    private val activity: Activity? = null,
    private val vpnPermLauncher: ActivityResultLauncher<Intent>? = null,
) : MethodCallHandler {

    private val focusServiceConn =
        SafeServiceConnection(
            context = context,
            serviceClass = FocusSessionService::class.java
        )

    private val trackerServiceConn =
        SafeServiceConnection(
            context = context,
            serviceClass = MindfulTrackerService::class.java
        )

    private val vpnServiceConn =
        SafeServiceConnection(
            context = context,
            serviceClass = MindfulVpnService::class.java
        )

    private val notificationServiceConn =
        SafeServiceConnection(
            context = context,
            serviceClass = MindfulNotificationListenerService::class.java
        )


    init {
        // Bind to Services if they are already running
        trackerServiceConn.bindService()
        vpnServiceConn.bindService()
        notificationServiceConn.bindService()
        focusServiceConn.bindService()
    }


    fun dispose() {
        // Unbind all services
        trackerServiceConn.unBindService()
        vpnServiceConn.unBindService()
        notificationServiceConn.unBindService()
        focusServiceConn.unBindService()
    }

    private fun updateLocale(languageCode: String) {
        if (languageCode.isNotEmpty()) {
            val newLocale = Locale(languageCode)
            Locale.setDefault(newLocale)
            val config = Configuration()
            config.setLocale(newLocale)
            context.resources.updateConfiguration(config, context.resources.displayMetrics)
        }
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            // ==============================================================================================================
            // ====================================== SYSTEM =================================================================
            // ==============================================================================================================

            "updateLocale" -> {
                updateLocale(call.arguments() ?: "en")
                result.success(true)
            }

            "updateExcludedApps" -> {
                SharedPrefsHelper.getSetExcludedApps(context, call.arguments() ?: "")
                result.success(true)
            }

            "getDeviceInfo" -> {
                result.success(AppUtils.getDeviceInfoMap(context))
            }

            "getDeviceAppsInfo" -> {
                getDeviceAppInfos(
                    context = context,
                    onSuccess = { data -> result.success(data) }
                )
            }

            "getAppsUsageForInterval" -> {
                getAppsUsageForInterval(
                    context = context,
                    startMsEpoch = call.argument("startDateTime"),
                    endMsEpoch = call.argument("endDateTime"),
                    onSuccess = { data -> result.success(data) }
                )
            }

            "getWebTimeSpent" -> {
                val timeTrackers = trackerServiceConn.service?.getRestrictionManager?.getWebTimeTrackers
                    ?: mapOf<String, TimeTracker>()
                val host = call.arguments() ?: ""
                val timetracker = timeTrackers.getOrDefault(host, TimeTracker())
                result.success(
                    timetracker.timeSpent
                )
            }

            "getAppsLaunchCount" -> {
                result.success(
                    trackerServiceConn.service?.getRestrictionManager?.getAppsLaunchCount
                        ?: mapOf<String, Int>()
                )
            }

            "getWebLaunchCount" -> {
                result.success(
                    trackerServiceConn.service?.getRestrictionManager?.getWebLaunchCount
                        ?: mapOf<String, Int>()
                )
            }

            "getShortsScreenTimeMs" -> {
                result.success(SharedPrefsHelper.getSetShortsScreenTimeMs(context, null))
            }

            "getNativeCrashLogs" -> {
                result.success(SharedPrefsHelper.getCrashLogsArrayJsonString(context))
            }

            "clearNativeCrashLogs" -> {
                SharedPrefsHelper.clearCrashLogs(context)
                result.success(true)
            }

            // ==============================================================================================================
            // ====================================== SERVICES =================================================================
            // ==============================================================================================================
            "updateWebRestrictions" -> {
                val webRestrictions = JsonUtils.parseWebRestrictionsMap(
                    call.arguments() ?: ""
                )
                updateTrackerServiceRestrictions(webRestrictions, null, null)
                result.success(true)
            }

            "updateAppRestrictions" -> {
                val appRestrictions = JsonUtils.parseAppRestrictionsMap(
                    call.arguments() ?: ""
                )
                updateTrackerServiceRestrictions(null, appRestrictions, null)
                result.success(true)
            }

            "updateRestrictionsGroups" -> {
                val restrictionGroups = JsonUtils.parseRestrictionGroupsMap(
                    call.arguments() ?: ""
                )
                updateTrackerServiceRestrictions(null, null, restrictionGroups)
                result.success(true)
            }

            "updateInternetBlockedApps" -> {
                val blockedApps =
                    JsonUtils.parseStringSet(call.arguments() ?: "")
                if (vpnServiceConn.isActive) {
                    vpnServiceConn.service?.updateBlockedApps(blockedApps)
                } else if (blockedApps.isNotEmpty() && getAndAskVpnPermission(false)) {
                    vpnServiceConn.setOnConnectedCallback { service ->
                        service.updateBlockedApps(
                            blockedApps
                        )
                    }
                    vpnServiceConn.startAndBind()
                }
                result.success(true)
            }

            "updateWellBeingSettings" -> {
                // NOTE: Only updating shared prefs because accessibility service have onSharedPrefsChange listener registered which will eventually reload needed data
                SharedPrefsHelper.getSetWellBeingSettings(
                    context,
                    call.arguments() ?: ""
                )
                result.success(true)
            }

            "updateBedtimeSchedule" -> {
                val jsonBedtimeSettings = call.arguments() ?: ""
                val bedtimeSettings = BedtimeSchedule.fromJson(jsonBedtimeSettings)
                if (bedtimeSettings.isScheduleOn) {
                    scheduleBedtimeRoutineTasks(context, jsonBedtimeSettings)
                } else {
                    cancelBedtimeRoutineTasks(context)
                    if (bedtimeSettings.shouldStartDnd) {
                        NotificationHelper.toggleDnd(context, DndWakeLock.BEDTIME_MODE, false)
                    }
                }
                result.success(true)
            }

            "activeEmergencyPause" -> {
                if (!Utils.isServiceRunning(context, EmergencyPauseService::class.java)
                    && Utils.isServiceRunning(context, MindfulTrackerService::class.java)
                ) {
                    context.startService(
                        Intent(context, EmergencyPauseService::class.java).setAction(
                            ServiceBinder.ACTION_START_MINDFUL_SERVICE
                        )
                    )
                    result.success(true)
                } else {
                    result.success(false)
                }
            }

            "updateFocusSession" -> {
                val focusSession = FocusSession.fromJson(call.arguments() ?: "")
                if (focusServiceConn.isActive) {
                    focusServiceConn.service?.updateFocusSession(focusSession)
                } else {
                    focusServiceConn.setOnConnectedCallback { service: FocusSessionService ->
                        service.startFocusSession(
                            focusSession
                        )
                    }
                    focusServiceConn.startAndBind()
                }
                result.success(true)
            }

            "giveUpOrFinishFocusSession" -> {
                if (focusServiceConn.isActive) {
                    focusServiceConn.service?.giveUpOrStopFocusSession(call.arguments() ?: false)
                    focusServiceConn.unBindService()
                }
                result.success(true)
            }

            "updateNotificationSettings" -> {
                val settingsJson = call.arguments() ?: ""
                val settings = NotificationSettings.fromJson(settingsJson)

                /// Update service
                if (notificationServiceConn.isActive) {
                    notificationServiceConn.service?.updateNotificationSettings(settings)
                } else if (settings.batchedApps.isNotEmpty() || settings.storeNonBatchedToo) {
                    notificationServiceConn.setOnConnectedCallback { service: MindfulNotificationListenerService ->
                        service.updateNotificationSettings(settings)
                    }
                    notificationServiceConn.bindService()
                }

                /// Schedule batches
                if (settings.schedules.isNotEmpty()) {
                    scheduleNotificationBatchTask(context, settingsJson)
                } else {
                    cancelNotificationBatchTask(context)
                }

                result.success(true)
            }

            // ==============================================================================================================
            // ===================================== PERMISSIONS ============================================================
            // ==============================================================================================================

            "getAndAskAccessibilityPermission" -> {
                result.success(
                    PermissionsHelper.getAndAskAccessibilityPermission(
                        context,
                        call.arguments() ?: false
                    )
                )
            }

            "getAndAskAdminPermission" -> {
                result.success(
                    PermissionsHelper.getAndAskAdminPermission(
                        context,
                        call.arguments() ?: false
                    )
                )
            }

            "getAndAskUsageAccessPermission" -> {
                result.success(
                    PermissionsHelper.getAndAskUsageAccessPermission(
                        context,
                        call.arguments() ?: false
                    )
                )
            }

            "getAndAskIgnoreBatteryOptimizationPermission" -> {
                result.success(
                    PermissionsHelper.getAndAskIgnoreBatteryOptimizationPermission(
                        context,
                        call.arguments() ?: false
                    )
                )
            }

            "getAndAskDisplayOverlayPermission" -> {
                result.success(
                    PermissionsHelper.getAndAskDisplayOverlayPermission(
                        context,
                        call.arguments() ?: false
                    )
                )
            }

            "getAndAskExactAlarmPermission" -> {
                result.success(
                    PermissionsHelper.getAndAskExactAlarmPermission(
                        context,
                        call.arguments() ?: false
                    )
                )
            }

            "getAndAskNotificationPermission" -> {
                result.success(
                    activity?.let {
                        return@let PermissionsHelper.getAndAskNotificationPermission(
                            it,
                            call.arguments() ?: false
                        )
                    } ?: false
                )
            }

            "getAndAskDndPermission" -> {
                result.success(
                    PermissionsHelper.getAndAskDndPermission(
                        context,
                        call.arguments() ?: false
                    )
                )
            }

            "getAndAskNotificationAccessPermission" -> {
                result.success(
                    PermissionsHelper.getAndAskNotificationAccessPermission(
                        context,
                        call.arguments() ?: false
                    )
                )
            }

            "getAndAskVpnPermission" -> {
                result.success(getAndAskVpnPermission(call.arguments() ?: false))
            }

            // ==============================================================================================================
            // ====================================== UTILS =================================================================
            // ==============================================================================================================

            "disableDeviceAdmin" -> {
                NewActivitiesLaunchHelper.disableDeviceAdmin(context)
                result.success(true)
            }

            "promptForQuickTile" -> {
                NewActivitiesLaunchHelper.promptForQuickFocusTile(context, result)
            }

            "openAppWithPackage" -> {
                NewActivitiesLaunchHelper.openAppWithPackage(
                    context,
                    call.arguments() ?: ""
                )
                result.success(true)
            }

            "openAppWithNotificationThread" -> {
                val notification = Notification.fromJson(call.arguments() ?: "")
                NewActivitiesLaunchHelper.openAppWithNotificationThread(
                    context = context,
                    notification = notification,
                    pendingIntent = notificationServiceConn.service?.getPendingIntentForKey(
                        notification.key
                    ),
                )
                result.success(true)
            }

            "openAppSettingsForPackage" -> {
                NewActivitiesLaunchHelper.openSettingsForPackage(
                    context,
                    call.arguments() ?: ""
                )
                result.success(true)
            }

            "openDeviceDndSettings" -> {
                NewActivitiesLaunchHelper.openDeviceDndSettings(context)
                result.success(true)
            }

            "openAutoStartSettings" -> {
                result.success(NewActivitiesLaunchHelper.openAutoStartSettings(context))
            }

            "restartApp" -> {
                activity?.let {
                    NewActivitiesLaunchHelper.restartMindful(it)
                }
                result.success(true)
            }

            "launchUrl" -> {
                NewActivitiesLaunchHelper.launchUrl(context, call.arguments() ?: "")
                result.success(true)
            }

            "parseHostFromUrl" -> {
                result.success(Utils.parseHostNameFromUrl(call.arguments() ?: "") ?: "")
            }

            else -> result.notImplemented()
        }
    }


    /**
     * Updates app and group restrictions in the tracker service.
     * If the service is connected, sends updates directly; otherwise,
     * sets a callback to update once the connection is established and starts the service.
     *
     * @param appRestrictions   a map of app package names to their respective restrictions,
     * or null if only group restrictions are being updated.
     * @param restrictionGroups a map of restriction group IDs to their respective restrictions,
     * or null if only app-specific restrictions are being updated.
     */
    private fun updateTrackerServiceRestrictions(
        webRestrictions: HashMap<String, WebRestriction>?,
        appRestrictions: HashMap<String, AppRestriction>?,
        restrictionGroups: HashMap<Int, RestrictionGroup>?,
    ) {
        if (trackerServiceConn.isActive) {
            trackerServiceConn.service?.getRestrictionManager?.updateRestrictions(
                webRestrictions,
                appRestrictions,
                restrictionGroups
            )
        } else if (appRestrictions?.isNotEmpty() == true || restrictionGroups?.isNotEmpty() == true) {
            trackerServiceConn.setOnConnectedCallback { service ->
                service.getRestrictionManager.updateRestrictions(
                    webRestrictions,
                    appRestrictions,
                    restrictionGroups
                )
            }
            trackerServiceConn.startAndBind()
        }
    }

    /**
     * Checks if the Create VPN permission is granted and optionally asks for it if not granted.
     *
     * @param askPermissionToo Whether to prompt the user to enable Create VPN permission if not granted.
     * @return True if Create VPN permission is granted, false otherwise.
     */
    private fun getAndAskVpnPermission(askPermissionToo: Boolean): Boolean {
        val intent = VpnService.prepare(context)
        if (askPermissionToo && intent != null) {
            vpnPermLauncher?.launch(intent)
        }
        return intent == null
    }

}
