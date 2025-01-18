package com.mindful.android

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.content.res.Configuration
import android.net.VpnService
import androidx.activity.result.ActivityResultLauncher
import com.mindful.android.generics.SafeServiceConnection
import com.mindful.android.generics.ServiceBinder
import com.mindful.android.helpers.AlarmTasksSchedulingHelper.cancelBedtimeRoutineTasks
import com.mindful.android.helpers.AlarmTasksSchedulingHelper.cancelNotificationBatchTask
import com.mindful.android.helpers.AlarmTasksSchedulingHelper.scheduleBedtimeRoutineTasks
import com.mindful.android.helpers.AlarmTasksSchedulingHelper.scheduleNotificationBatchTask
import com.mindful.android.helpers.database.SharedPrefsHelper
import com.mindful.android.helpers.device.DeviceAppsHelper.getDeviceAppInfos
import com.mindful.android.helpers.device.NewActivitiesLaunchHelper
import com.mindful.android.helpers.device.NotificationHelper
import com.mindful.android.helpers.device.PermissionsHelper
import com.mindful.android.helpers.usages.AppsUsageHelper.getAppsUsageForInterval
import com.mindful.android.models.AppRestrictions
import com.mindful.android.models.FocusSession
import com.mindful.android.models.RestrictionGroup
import com.mindful.android.services.notification.MindfulNotificationListenerService
import com.mindful.android.services.timer.EmergencyPauseService
import com.mindful.android.services.timer.FocusSessionService
import com.mindful.android.services.tracking.MindfulTrackerService
import com.mindful.android.services.vpn.MindfulVpnService
import com.mindful.android.utils.JsonDeserializer
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
        SafeServiceConnection(FocusSessionService::class.java, context)

    private val trackerServiceConn =
        SafeServiceConnection(MindfulTrackerService::class.java, context)

    private val vpnServiceConn =
        SafeServiceConnection(MindfulVpnService::class.java, context)

    private val notificationServiceConn =
        SafeServiceConnection(MindfulNotificationListenerService::class.java, context)


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
                updateLocale(Utils.notNullStr(call.arguments()))
                result.success(true)
            }

            "updateExcludedApps" -> {
                SharedPrefsHelper.getSetExcludedApps(context, Utils.notNullStr(call.arguments()))
                result.success(true)
            }

            "setDataResetTime" -> {
                SharedPrefsHelper.getSetDataResetTimeMins(context, call.arguments() ?: 0)
                result.success(true)
            }

            "getDeviceInfo" -> {
                result.success(Utils.getDeviceInfoMap(context))
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

            "getUpComingNotifications" -> {
                result.success(SharedPrefsHelper.getSerializedNotificationsJson(context))
            }

            "getShortsScreenTimeMs" -> {
                result.success(SharedPrefsHelper.getSetShortsScreenTimeMs(context, null))
            }

            "getNativeCrashLogs" -> {
                result.success(SharedPrefsHelper.getCrashLogsArrayString(context))
            }

            "clearNativeCrashLogs" -> {
                SharedPrefsHelper.clearCrashLogs(context)
                result.success(true)
            }

            // ==============================================================================================================
            // ====================================== SERVICES =================================================================
            // ==============================================================================================================

            "updateAppRestrictions" -> {
                val appRestrictions = SharedPrefsHelper.getSetAppRestrictions(
                    context,
                    Utils.notNullStr(call.arguments())
                )
                updateTrackerServiceRestrictions(appRestrictions, null)
                result.success(true)
            }

            "updateRestrictionsGroups" -> {
                val restrictionGroups = SharedPrefsHelper.getSetRestrictionGroups(
                    context,
                    Utils.notNullStr(call.arguments())
                )
                updateTrackerServiceRestrictions(null, restrictionGroups)
                result.success(true)
            }

            "updateInternetBlockedApps" -> {
                val blockedApps =
                    JsonDeserializer.jsonStrToStringHashSet(Utils.notNullStr(call.arguments()))
                if (vpnServiceConn.service != null) {
                    vpnServiceConn.service?.updateBlockedApps(blockedApps)
                } else if (blockedApps.isNotEmpty() && getAndAskVpnPermission(false)) {
                    vpnServiceConn.setOnConnectedCallback { service: MindfulVpnService ->
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
                val bedtimeSettings = SharedPrefsHelper.getSetBedtimeSettings(
                    context,
                    Utils.notNullStr(call.arguments())
                )
                if (bedtimeSettings.isScheduleOn) {
                    scheduleBedtimeRoutineTasks(context, bedtimeSettings)
                } else {
                    cancelBedtimeRoutineTasks(context)
                    if (bedtimeSettings.shouldStartDnd) {
                        NotificationHelper.toggleDnd(context, false)
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
                val focusSession = FocusSession(Utils.notNullStr(call.arguments()))
                if (focusServiceConn.service != null) {
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
                if (focusServiceConn.service != null) {
                    focusServiceConn.service?.giveUpOrStopFocusSession(java.lang.Boolean.TRUE == call.arguments())
                    focusServiceConn.unBindService()
                }
                result.success(true)
            }

            "updateDistractingNotificationApps" -> {
                val distractingApps = SharedPrefsHelper.getSetNotificationBatchedApps(
                    context,
                    Utils.notNullStr(call.arguments())
                )
                if (notificationServiceConn.service != null) {
                    notificationServiceConn.service?.updateDistractingApps(distractingApps)
                } else if (distractingApps.isNotEmpty()) {
                    notificationServiceConn.setOnConnectedCallback { service: MindfulNotificationListenerService ->
                        service.updateDistractingApps(
                            distractingApps
                        )
                    }
                    notificationServiceConn.bindService()
                }
                result.success(true)
            }

            "updateNotificationBatchSchedules" -> {
                val todMinutes = SharedPrefsHelper.getSetNotificationBatchSchedules(
                    context,
                    Utils.notNullStr(call.arguments())
                )
                if (todMinutes.isNotEmpty()) {
                    scheduleNotificationBatchTask(context, todMinutes)
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
                        java.lang.Boolean.TRUE == call.arguments()
                    )
                )
            }

            "getAndAskAdminPermission" -> {
                result.success(
                    PermissionsHelper.getAndAskAdminPermission(
                        context,
                        java.lang.Boolean.TRUE == call.arguments()
                    )
                )
            }

            "getAndAskUsageAccessPermission" -> {
                result.success(
                    PermissionsHelper.getAndAskUsageAccessPermission(
                        context,
                        java.lang.Boolean.TRUE == call.arguments()
                    )
                )
            }

            "getAndAskIgnoreBatteryOptimizationPermission" -> {
                result.success(
                    PermissionsHelper.getAndAskIgnoreBatteryOptimizationPermission(
                        context,
                        java.lang.Boolean.TRUE == call.arguments()
                    )
                )
            }

            "getAndAskDisplayOverlayPermission" -> {
                result.success(
                    PermissionsHelper.getAndAskDisplayOverlayPermission(
                        context,
                        java.lang.Boolean.TRUE == call.arguments()
                    )
                )
            }

            "getAndAskExactAlarmPermission" -> {
                result.success(
                    PermissionsHelper.getAndAskExactAlarmPermission(
                        context,
                        java.lang.Boolean.TRUE == call.arguments()
                    )
                )
            }

            "getAndAskNotificationPermission" -> {
                result.success(
                    activity?.let {
                        return@let PermissionsHelper.getAndAskNotificationPermission(
                            it,
                            java.lang.Boolean.TRUE == call.arguments()
                        )
                    } ?: false
                )
            }

            "getAndAskDndPermission" -> {
                result.success(
                    PermissionsHelper.getAndAskDndPermission(
                        context,
                        java.lang.Boolean.TRUE == call.arguments()
                    )
                )
            }

            "getAndAskNotificationAccessPermission" -> {
                result.success(
                    PermissionsHelper.getAndAskNotificationAccessPermission(
                        context,
                        java.lang.Boolean.TRUE == call.arguments()
                    )
                )
            }

            "getAndAskVpnPermission" -> {
                result.success(getAndAskVpnPermission(java.lang.Boolean.TRUE == call.arguments()))
            }

            // ==============================================================================================================
            // ====================================== UTILS =================================================================
            // ==============================================================================================================

            "disableDeviceAdmin" -> {
                NewActivitiesLaunchHelper.disableDeviceAdmin(context)
                result.success(true)
            }

            "openAppWithPackage" -> {
                NewActivitiesLaunchHelper.openAppWithPackage(
                    context,
                    Utils.notNullStr(call.arguments())
                )
                result.success(true)
            }

            "openAppSettingsForPackage" -> {
                NewActivitiesLaunchHelper.openSettingsForPackage(
                    context,
                    Utils.notNullStr(call.arguments())
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
                NewActivitiesLaunchHelper.launchUrl(context, Utils.notNullStr(call.arguments()))
                result.success(true)
            }

            "parseHostFromUrl" -> {
                result.success(
                    if (call.arguments == null) "" else Utils.parseHostNameFromUrl(
                        call.arguments as String
                    )
                )
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
        appRestrictions: HashMap<String, AppRestrictions>?,
        restrictionGroups: HashMap<Int, RestrictionGroup>?,
    ) {
        if (trackerServiceConn.service != null) {
            trackerServiceConn.service?.getRestrictionManager?.updateRestrictions(
                appRestrictions,
                restrictionGroups
            )
        } else if (appRestrictions?.isEmpty() == false || restrictionGroups?.isEmpty() == false) {
            trackerServiceConn.setOnConnectedCallback { service: MindfulTrackerService ->
                service.getRestrictionManager.updateRestrictions(
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