package com.mindful.android.services.tracking

import android.app.Service.USAGE_STATS_SERVICE
import android.app.usage.UsageStatsManager
import android.content.Context
import android.util.Log
import com.mindful.android.R
import com.mindful.android.helpers.usages.ScreenUsageHelper
import com.mindful.android.models.AppRestrictions
import com.mindful.android.models.RestrictionGroup
import com.mindful.android.models.RestrictionState
import com.mindful.android.enums.RestrictionType
import com.mindful.android.utils.Utils

class RestrictionManager(
    private val context: Context,
    private val stopIfNoUsage: () -> Unit,
    private val usageStatsManager: UsageStatsManager = context.getSystemService(USAGE_STATS_SERVICE) as UsageStatsManager,
) {
    private val TAG = "Mindful.RestrictionManager"

    val isIdle: Boolean
        get() = focusedApps.isEmpty()
                && bedtimeApps.isEmpty()
                && appsRestrictions.isEmpty()
                && restrictionGroups.isEmpty()

    // Restrictions
    private var appsRestrictions = HashMap<String, AppRestrictions>()
    private var restrictionGroups = HashMap<Int, RestrictionGroup>()

    // Focus
    private var focusedApps = setOf<String>()
    private var bedtimeApps = setOf<String>()

    //  Cache
    private val appsLaunchCount = HashMap<String, Int>(0)
    val getAppsLaunchCount: HashMap<String, Int> get() = appsLaunchCount

    private val alreadyRestrictedApps = HashMap<String, RestrictionState>(0)
    private val alreadyRestrictedGroups = HashMap<Int, RestrictionState>(0)

    fun resetCache() {
        alreadyRestrictedApps.clear()
        alreadyRestrictedGroups.clear()
    }

    fun updateRestrictions(
        appsRestrictionsMap: HashMap<String, AppRestrictions>?,
        restrictionGroupsMap: HashMap<Int, RestrictionGroup>?,
    ) {
        appsRestrictionsMap?.let {
            appsRestrictions = it
            alreadyRestrictedApps.clear()
            Log.d(TAG, "updateRestrictions: Apps restrictions updated")
        }

        restrictionGroupsMap?.let {
            restrictionGroups = it
            alreadyRestrictedGroups.clear()
            Log.d(TAG, "updateRestrictions: Restriction groups updated")
        }
        stopIfNoUsage.invoke()
    }

    fun updateFocusedApps(apps: HashSet<String>?) {
        focusedApps = apps ?: setOf()
        if(apps == null) stopIfNoUsage.invoke()
        Log.d(TAG, "updateFocusedApps: Focus apps updated: $focusedApps")
    }

    fun updateBedtimeApps(apps: HashSet<String>?) {
        bedtimeApps = apps ?: setOf()
        if(apps == null) stopIfNoUsage.invoke()
        Log.d(TAG, "updateBedtimeApps: Bedtime apps updated: $bedtimeApps")
    }


    // returns nearest time stamp for rechecking
    fun isAppRestricted(packageName: String): RestrictionState? {
        // If already restricted by focus or bedtime or cached
        val alreadyRestrictedState = evaluateIfAlreadyRestricted(packageName)
        if (alreadyRestrictedState != null) {
            return alreadyRestrictedState
        }

        // If no restrictions
        val restriction = appsRestrictions[packageName] ?: return null

        // Increment and Check app launch count
        val launchCount = appsLaunchCount.getOrDefault(packageName, 0) + 1
        appsLaunchCount[packageName] = launchCount
        if ((restriction.launchLimit > 0) && (launchCount > restriction.launchLimit)) {
            val state = RestrictionState(
                message = context.getString(R.string.app_paused_reason_launch_count_out),
                type = RestrictionType.LaunchCount,
                expirationFutureMs = -1L,
            )
            alreadyRestrictedApps[packageName] = state
            return state
        }

        val futureStates: MutableSet<RestrictionState> = mutableSetOf()

        /// evaluate active periods
        evaluateActivePeriodLimit(restriction, futureStates)?.let { return it }

        /// Evaluate screen time
        evaluateScreenTimeLimit(restriction, futureStates)?.let { return it }

        /// Return the nearest expiration
        if (futureStates.isNotEmpty()) {
            val nearestFutureState = futureStates.minBy { it.expirationFutureMs }
            return nearestFutureState
        } else {
            return null
        }
    }

    private fun evaluateIfAlreadyRestricted(packageName: String): RestrictionState? {
        return when {
            focusedApps.contains(packageName) -> RestrictionState(
                message = context.getString(R.string.app_paused_reason_focus_session),
                type = RestrictionType.FocusMode,
                expirationFutureMs = -1L,
            )

            bedtimeApps.contains(packageName) -> RestrictionState(
                message = context.getString(R.string.app_paused_reason_bedtime),
                type = RestrictionType.BedtimeMode,
                expirationFutureMs = -1L,
            )

            alreadyRestrictedApps.containsKey(packageName) -> alreadyRestrictedApps[packageName]
            else -> null
        }
    }


    private fun evaluateActivePeriodLimit(
        restriction: AppRestrictions,
        futureState: MutableSet<RestrictionState>,
    ): RestrictionState? {

        /// Check app's active period
        if (restriction.periodDurationInMins > 0) {
            val periodEndTimeMinutes =
                restriction.activePeriodStart + restriction.periodDurationInMins

            val state = RestrictionState(
                message = context.getString(R.string.app_paused_reason_active_period_over),
                type = RestrictionType.ActivePeriod,
                expirationFutureMs = -1L,
            )

            /// Outside active period
            if (Utils.isTimeOutsideTODs(restriction.activePeriodStart, periodEndTimeMinutes)) {
                Log.d(TAG, "evaluateActivePeriodLimit: App's active period is over")
                return state
            }
            /// Launched between active period calculate expiration time
            else {
                val willOverInMs = Utils.todDifferenceFromNow(periodEndTimeMinutes)
                futureState.add(state.copy(expirationFutureMs = willOverInMs))
            }
        }


        /// Check group's active period
        restrictionGroups[restriction.associatedGroupId]?.let {
            if (it.periodDurationInMins > 0) {
                val periodEndTimeMinutes =
                    it.activePeriodStart + it.periodDurationInMins

                val state = RestrictionState(
                    message = context.getString(R.string.app_paused_reason_active_period_over),
                    type = RestrictionType.ActivePeriod,
                    expirationFutureMs = -1L,
                )
                /// Outside active period
                if (Utils.isTimeOutsideTODs(it.activePeriodStart, periodEndTimeMinutes)) {
                    Log.d(
                        TAG,
                        "evaluateActivePeriodLimit: ${it.groupName} group's active period is over"
                    )
                    return state
                }
                /// Launched between active period calculate expiration time
                else {
                    val willOverInMs = Utils.todDifferenceFromNow(periodEndTimeMinutes)
                    futureState.add(state.copy(expirationFutureMs = willOverInMs))
                }
            }
        }

        return null
    }

    private fun evaluateScreenTimeLimit(
        restriction: AppRestrictions,
        futureStates: MutableSet<RestrictionState>,
    ): RestrictionState? {
        // Usage map
        val screenUsage = ScreenUsageHelper.fetchAppUsageTodayTillNow(usageStatsManager)

        /// Check for app timer
        if (restriction.timerSec > 0) {
            val screenTimeSec: Long = screenUsage[restriction.appPackage] ?: 0

            /// App timer ran out
            if (screenTimeSec >= restriction.timerSec) {
                Log.d(TAG, "evaluateScreenTimeLimit: App's timer is over")
                val state = RestrictionState(
                    message = context.getString(R.string.app_paused_reason_app_timer_out),
                    type = RestrictionType.Timer,
                    expirationFutureMs = -1L,
                    usedScreenTime = screenTimeSec,
                    totalScreenTimer = restriction.timerSec.toLong(),
                )

                alreadyRestrictedApps[restriction.appPackage] = state
                return state
            } else {
                /// App timer left so add expiration timestamp
                val leftAppLimitMs = (restriction.timerSec - screenTimeSec) * 1000L
                futureStates.add(
                    RestrictionState(
                        message = context.getString(R.string.app_paused_reason_app_timer_left),
                        type = RestrictionType.Timer,
                        expirationFutureMs = leftAppLimitMs,
                        usedScreenTime = screenTimeSec,
                        totalScreenTimer = restriction.timerSec.toLong(),
                    )
                )
            }
        }


        /// Check group's timer ran out
        restrictionGroups[restriction.associatedGroupId]?.let { group ->
            // If group is already restricted
            if (alreadyRestrictedGroups.containsKey(group.id)) {
                return alreadyRestrictedGroups[group.id]
            }

            if (group.timerSec > 0) {
                val groupScreenTimeSec = group.distractingApps.sumOf { screenUsage[it] ?: 0 }

                /// group timer ran out
                if (groupScreenTimeSec >= group.timerSec) {
                    Log.d(TAG, "evaluateScreenTimeLimit: App's timer is over")
                    val state = RestrictionState(
                        message = context.getString(
                            R.string.app_paused_reason_group_timer_out,
                            group.groupName
                        ),
                        type = RestrictionType.Timer,
                        expirationFutureMs = -1L,
                        usedScreenTime = groupScreenTimeSec,
                        totalScreenTimer = group.timerSec.toLong(),
                    )

                    alreadyRestrictedGroups[group.id] = state
                    return state
                } else {
                    /// group timer left so add expiration timestamp
                    val leftAppLimitMs = (group.timerSec - groupScreenTimeSec) * 1000L
                    futureStates.add(
                        RestrictionState(
                            message = context.getString(
                                R.string.app_paused_reason_group_timer_left,
                                group.groupName
                            ),
                            type = RestrictionType.Timer,
                            expirationFutureMs = leftAppLimitMs,
                            usedScreenTime = groupScreenTimeSec,
                            totalScreenTimer = group.timerSec.toLong(),
                        )
                    )
                }
            }
        }

        return null
    }
}
