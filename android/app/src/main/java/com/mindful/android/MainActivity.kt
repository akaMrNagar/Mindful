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
package com.mindful.android

import android.content.Intent
import android.content.res.Configuration
import android.net.VpnService
import android.os.Bundle
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts
import com.mindful.android.generics.SafeServiceConnection
import com.mindful.android.generics.ServiceBinder
import com.mindful.android.helpers.AlarmTasksSchedulingHelper.cancelBedtimeRoutineTasks
import com.mindful.android.helpers.AlarmTasksSchedulingHelper.cancelNotificationBatchTask
import com.mindful.android.helpers.AlarmTasksSchedulingHelper.scheduleBedtimeRoutineTasks
import com.mindful.android.helpers.AlarmTasksSchedulingHelper.scheduleMidnightResetTask
import com.mindful.android.helpers.AlarmTasksSchedulingHelper.scheduleNotificationBatchTask
import com.mindful.android.helpers.AppsUsageHelper.getAppsUsageForInterval
import com.mindful.android.helpers.DeviceAppsHelper.getDeviceAppInfos
import com.mindful.android.helpers.NewActivitiesLaunchHelper
import com.mindful.android.helpers.NotificationHelper
import com.mindful.android.helpers.PermissionsHelper
import com.mindful.android.helpers.SharedPrefsHelper
import com.mindful.android.models.AppRestrictions
import com.mindful.android.models.FocusSession
import com.mindful.android.models.RestrictionGroup
import com.mindful.android.services.timer.EmergencyPauseService
import com.mindful.android.services.timer.FocusSessionService
import com.mindful.android.services.notification.MindfulNotificationListenerService
import com.mindful.android.services.tracking.MindfulTrackerService
import com.mindful.android.services.vpn.MindfulVpnService
import com.mindful.android.utils.AppConstants
import com.mindful.android.utils.JsonDeserializer
import com.mindful.android.utils.Utils
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import java.util.Locale

class MainActivity : FlutterFragmentActivity(), MethodCallHandler {
    private lateinit var mTrackerServiceConn: SafeServiceConnection<MindfulTrackerService>
    private lateinit var mVpnServiceConn: SafeServiceConnection<MindfulVpnService>
    private lateinit var mNotificationServiceConn: SafeServiceConnection<MindfulNotificationListenerService>
    private lateinit var mFocusServiceConn: SafeServiceConnection<FocusSessionService>

    private lateinit var vpnPermissionLauncher: ActivityResultLauncher<Intent>

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Store uncaught exceptions
        Thread.setDefaultUncaughtExceptionHandler { _: Thread?, exception: Throwable ->
            SharedPrefsHelper.insertCrashLogToPrefs(
                this, exception
            )
        }

        // Register notification channels
        NotificationHelper.registerNotificationChannels(this)

        // Register VPN permission launcher
        vpnPermissionLauncher = registerForActivityResult(
            ActivityResultContracts.StartActivityForResult()
        ) { }

        // Schedule midnight 12 task if already not scheduled
        scheduleMidnightResetTask(this, true)

        // Initialize service connections
        mTrackerServiceConn = SafeServiceConnection(MindfulTrackerService::class.java, this)
        mNotificationServiceConn = SafeServiceConnection(
            MindfulNotificationListenerService::class.java, this
        )
        mVpnServiceConn = SafeServiceConnection(MindfulVpnService::class.java, this)
        mFocusServiceConn = SafeServiceConnection(FocusSessionService::class.java, this)

        /// Bind to Services if they are already running
        mTrackerServiceConn.bindService()
        mVpnServiceConn.bindService()
        mNotificationServiceConn.bindService()
        mFocusServiceConn.bindService()
    }

    private fun updateLocale(languageCode: String) {
        if (languageCode.isNotEmpty()) {
            val newLocale = Locale(languageCode)
            Locale.setDefault(newLocale)
            val config = Configuration()
            config.setLocale(newLocale)
            resources.updateConfiguration(config, resources.displayMetrics)
        }
    }


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val mMethodChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            AppConstants.FLUTTER_METHOD_CHANNEL
        )
        mMethodChannel.setMethodCallHandler(this)

        // Get and set intent data
        val intentData: MutableMap<String, Any?> = HashMap()
        intentData["route"] = intent.getStringExtra(AppConstants.INTENT_EXTRA_INITIAL_ROUTE)
        intentData["extraPackageName"] =
            intent.getStringExtra(AppConstants.INTENT_EXTRA_PACKAGE_NAME)
        intentData["extraIsSelfStart"] =
            intent.getBooleanExtra(AppConstants.INTENT_EXTRA_IS_SELF_RESTART, false)

        // Update intent data on flutter side
        mMethodChannel.invokeMethod("updateIntentData", intentData)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "updateLocale" -> {
                updateLocale(Utils.notNullStr(call.arguments()))
                result.success(true)
            }

            "updateExcludedApps" -> {
                SharedPrefsHelper.getSetExcludedApps(this, Utils.notNullStr(call.arguments()))
                result.success(true)
            }

            "setDataResetTime" -> {
                SharedPrefsHelper.getSetDataResetTimeMins(
                    this,
                    if (call.arguments<Any?>() == null) 0 else call.arguments()
                )
                result.success(true)
            }

            "getDeviceInfoMap" -> {
                result.success(Utils.getDeviceInfoMap(this))
            }

            "getDeviceAppsInfo" -> {
                getDeviceAppInfos(
                    context = this,
                    onSuccess = { data -> result.success(data) }
                )
            }

            "getAppsUsageForInterval" -> {
                getAppsUsageForInterval(
                    context = this,
                    startMsEpoch = call.argument("startDateTime"),
                    endMsEpoch = call.argument("endDateTime"),
                    onSuccess = { data -> result.success(data) }
                )
            }

            "getUpComingNotifications" -> {
                result.success(SharedPrefsHelper.getSerializedNotificationsJson(this))
            }

            "getShortsScreenTimeMs" -> {
                result.success(SharedPrefsHelper.getSetShortsScreenTimeMs(this, null))
            }

            "getNativeCrashLogs" -> {
                result.success(SharedPrefsHelper.getCrashLogsArrayString(this))
            }

            "clearNativeCrashLogs" -> {
                SharedPrefsHelper.clearCrashLogs(this)
                result.success(true)
            }

            "updateAppRestrictions" -> {
                val appRestrictions = SharedPrefsHelper.getSetAppRestrictions(
                    this,
                    Utils.notNullStr(call.arguments())
                )
                updateTrackerServiceRestrictions(appRestrictions, null)
                result.success(true)
            }

            "updateRestrictionsGroups" -> {
                val restrictionGroups = SharedPrefsHelper.getSetRestrictionGroups(
                    this,
                    Utils.notNullStr(call.arguments())
                )
                updateTrackerServiceRestrictions(null, restrictionGroups)
                result.success(true)
            }

            "updateInternetBlockedApps" -> {
                val blockedApps =
                    JsonDeserializer.jsonStrToStringHashSet(Utils.notNullStr(call.arguments()))
                if (mVpnServiceConn.service != null) {
                    mVpnServiceConn.service?.updateBlockedApps(blockedApps)
                } else if (blockedApps.isNotEmpty() && getAndAskVpnPermission(false)) {
                    mVpnServiceConn.setOnConnectedCallback { service: MindfulVpnService ->
                        service.updateBlockedApps(
                            blockedApps
                        )
                    }
                    mVpnServiceConn.startAndBind()
                }
                result.success(true)
            }

            "updateWellBeingSettings" -> {
                // NOTE: Only updating shared prefs because accessibility service have onSharedPrefsChange listener registered which will eventually reload needed data
                SharedPrefsHelper.getSetWellBeingSettings(this, Utils.notNullStr(call.arguments()))
                result.success(true)
            }

            "updateBedtimeSchedule" -> {
                val bedtimeSettings = SharedPrefsHelper.getSetBedtimeSettings(
                    this,
                    Utils.notNullStr(call.arguments())
                )
                if (bedtimeSettings.isScheduleOn) {
                    scheduleBedtimeRoutineTasks(this, bedtimeSettings)
                } else {
                    cancelBedtimeRoutineTasks(this)
                    if (bedtimeSettings.shouldStartDnd) {
                        NotificationHelper.toggleDnd(this, false)
                    }
                }
                result.success(true)
            }

            "activeEmergencyPause" -> {
                if (!Utils.isServiceRunning(this, EmergencyPauseService::class.java)
                    && Utils.isServiceRunning(this, MindfulTrackerService::class.java)
                ) {
                    startService(
                        Intent(applicationContext, EmergencyPauseService::class.java).setAction(
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
                if (mFocusServiceConn.service != null) {
                    mFocusServiceConn.service?.updateFocusSession(focusSession)
                } else {
                    mFocusServiceConn.setOnConnectedCallback { service: FocusSessionService ->
                        service.startFocusSession(
                            focusSession
                        )
                    }
                    mFocusServiceConn.startAndBind()
                }
                result.success(true)
            }

            "giveUpOrFinishFocusSession" -> {
                if (mFocusServiceConn.service != null) {
                    mFocusServiceConn.service?.giveUpOrStopFocusSession(java.lang.Boolean.TRUE == call.arguments())
                    mFocusServiceConn.unBindService()
                }
                result.success(true)
            }

            "updateDistractingNotificationApps" -> {
                val distractingApps = SharedPrefsHelper.getSetNotificationBatchedApps(
                    this,
                    Utils.notNullStr(call.arguments())
                )
                if (mNotificationServiceConn.service != null) {
                    mNotificationServiceConn.service?.updateDistractingApps(distractingApps)
                } else if (distractingApps.isNotEmpty()) {
                    mNotificationServiceConn.setOnConnectedCallback { service: MindfulNotificationListenerService ->
                        service.updateDistractingApps(
                            distractingApps
                        )
                    }
                    mNotificationServiceConn.bindService()
                }
                result.success(true)
            }

            "updateNotificationBatchSchedules" -> {
                val todMinutes = SharedPrefsHelper.getSetNotificationBatchSchedules(
                    this,
                    Utils.notNullStr(call.arguments())
                )
                if (todMinutes.isNotEmpty()) {
                    scheduleNotificationBatchTask(this, todMinutes)
                } else {
                    cancelNotificationBatchTask(this)
                }
                result.success(true)
            }

            "getAndAskAccessibilityPermission" -> {
                result.success(
                    PermissionsHelper.getAndAskAccessibilityPermission(
                        this,
                        java.lang.Boolean.TRUE == call.arguments()
                    )
                )
            }

            "getAndAskAdminPermission" -> {
                result.success(
                    PermissionsHelper.getAndAskAdminPermission(
                        this,
                        java.lang.Boolean.TRUE == call.arguments()
                    )
                )
            }

            "getAndAskUsageAccessPermission" -> {
                result.success(
                    PermissionsHelper.getAndAskUsageAccessPermission(
                        this,
                        java.lang.Boolean.TRUE == call.arguments()
                    )
                )
            }

            "getAndAskIgnoreBatteryOptimizationPermission" -> {
                result.success(
                    PermissionsHelper.getAndAskIgnoreBatteryOptimizationPermission(
                        this,
                        java.lang.Boolean.TRUE == call.arguments()
                    )
                )
            }

            "getAndAskDisplayOverlayPermission" -> {
                result.success(
                    PermissionsHelper.getAndAskDisplayOverlayPermission(
                        this,
                        java.lang.Boolean.TRUE == call.arguments()
                    )
                )
            }

            "getAndAskExactAlarmPermission" -> {
                result.success(
                    PermissionsHelper.getAndAskExactAlarmPermission(
                        this,
                        java.lang.Boolean.TRUE == call.arguments()
                    )
                )
            }

            "getAndAskNotificationPermission" -> {
                result.success(
                    PermissionsHelper.getAndAskNotificationPermission(
                        this,
                        this,
                        java.lang.Boolean.TRUE == call.arguments()
                    )
                )
            }

            "getAndAskDndPermission" -> {
                result.success(
                    PermissionsHelper.getAndAskDndPermission(
                        this,
                        java.lang.Boolean.TRUE == call.arguments()
                    )
                )
            }

            "getAndAskNotificationAccessPermission" -> {
                result.success(
                    PermissionsHelper.getAndAskNotificationAccessPermission(
                        this,
                        java.lang.Boolean.TRUE == call.arguments()
                    )
                )
            }

            "getAndAskVpnPermission" -> {
                result.success(getAndAskVpnPermission(java.lang.Boolean.TRUE == call.arguments()))
            }

            "disableDeviceAdmin" -> {
                NewActivitiesLaunchHelper.disableDeviceAdmin(this)
                result.success(true)
            }

            "openAppWithPackage" -> {
                NewActivitiesLaunchHelper.openAppWithPackage(
                    this,
                    Utils.notNullStr(call.arguments())
                )
                result.success(true)
            }

            "openAppSettingsForPackage" -> {
                NewActivitiesLaunchHelper.openSettingsForPackage(
                    this,
                    Utils.notNullStr(call.arguments())
                )
                result.success(true)
            }

            "openDeviceDndSettings" -> {
                NewActivitiesLaunchHelper.openDeviceDndSettings(this)
                result.success(true)
            }

            "openAutoStartSettings" -> {
                result.success(NewActivitiesLaunchHelper.openAutoStartSettings(this))
            }

            "restartApp" -> {
                NewActivitiesLaunchHelper.restartMindful(this)
                result.success(true)
            }

            "launchUrl" -> {
                NewActivitiesLaunchHelper.launchUrl(this, Utils.notNullStr(call.arguments()))
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
        if (mTrackerServiceConn.service != null) {
            mTrackerServiceConn.service?.getRestrictionManager?.updateRestrictions(
                appRestrictions,
                restrictionGroups
            )
        } else if (appRestrictions?.isEmpty() == false || restrictionGroups?.isEmpty() == false) {
            mTrackerServiceConn.setOnConnectedCallback { service: MindfulTrackerService ->
                service.getRestrictionManager.updateRestrictions(
                    appRestrictions,
                    restrictionGroups
                )
            }
            mTrackerServiceConn.startAndBind()
        }
    }

    /**
     * Checks if the Create VPN permission is granted and optionally asks for it if not granted.
     *
     * @param askPermissionToo Whether to prompt the user to enable Create VPN permission if not granted.
     * @return True if Create VPN permission is granted, false otherwise.
     */
    private fun getAndAskVpnPermission(askPermissionToo: Boolean): Boolean {
        val intent = VpnService.prepare(this)
        if (askPermissionToo && intent != null) {
            vpnPermissionLauncher.launch(intent)
        }
        return intent == null
    }

    override fun onDestroy() {
        super.onDestroy()

        // Unbind services
        mTrackerServiceConn.unBindService()
        mNotificationServiceConn.unBindService()
        mVpnServiceConn.unBindService()
        mFocusServiceConn.unBindService()
    }

    companion object {
        private const val TAG = "Mindful.MainActivity"
    }
}
