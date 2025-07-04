package com.mindful.android.services.tracking

import android.app.Service.USAGE_STATS_SERVICE
import android.app.usage.UsageStatsManager
import android.content.Context
import android.util.Log
import com.mindful.android.enums.RestrictionType
import com.mindful.android.helpers.usages.ScreenUsageHelper
import com.mindful.android.models.AppRestriction
import com.mindful.android.models.RestrictionGroup
import com.mindful.android.models.RestrictionState
import com.mindful.android.utils.DateTimeUtils

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
    private var appsRestrictions = HashMap<String, AppRestriction>()
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
        appsLaunchCount.clear()
    }

    fun updateRestrictions(
        appsRestrictionsMap: HashMap<String, AppRestriction>?,
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

    fun updateFocusedApps(apps: Set<String>?) {
        focusedApps = apps ?: emptySet()
        if (apps == null) stopIfNoUsage.invoke()
        Log.d(TAG, "updateFocusedApps: Focus apps updated: $focusedApps")
    }

    fun updateBedtimeApps(apps: Set<String>?) {
        bedtimeApps = apps ?: emptySet()
        if (apps == null) stopIfNoUsage.invoke()
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
        if ((restriction.launchLimit > 0) && (launchCount > restriction.launchLimit)) {
            return RestrictionState(type = RestrictionType.LAUNCH_COUNT).also {
                alreadyRestrictedApps[packageName] = it
            }
        }
        appsLaunchCount[packageName] = launchCount

        val futureStates: MutableSet<RestrictionState> = mutableSetOf()

        /// evaluate active periods
        evaluateActivePeriodLimit(restriction, futureStates)?.let { return it }

        /// Evaluate screen time
        evaluateScreenTimeLimit(restriction, futureStates)?.let { return it }

        /// Return the nearest expiration
        if (futureStates.isNotEmpty()) {
            val nearestFutureState = futureStates.minBy { it.timeLeftMillis }
            return nearestFutureState
        } else {
            return null
        }
    }

    private fun evaluateIfAlreadyRestricted(packageName: String): RestrictionState? {
        return when {
            focusedApps.contains(packageName) -> RestrictionState(
                type = RestrictionType.FOCUS
            )

            bedtimeApps.contains(packageName) -> RestrictionState(
                type = RestrictionType.BEDTIME,
            )

            alreadyRestrictedApps.containsKey(packageName) -> alreadyRestrictedApps[packageName]
            else -> null
        }
    }


    private fun evaluateActivePeriodLimit(
        restriction: AppRestriction,
        futureState: MutableSet<RestrictionState>,
    ): RestrictionState? {

        /// Check app's active period
        if (restriction.activePeriodStart != restriction.activePeriodEnd) {
            val state = RestrictionState(type = RestrictionType.APP_ACTIVE_PERIOD)

            /// Outside active period
            if (DateTimeUtils.isTimeOutsideTODs(
                    restriction.activePeriodStart,
                    restriction.activePeriodEnd
                )
            ) {
                Log.d(TAG, "evaluateActivePeriodLimit: App's active period is over")
                return state
            }
            /// Launched between active period calculate expiration time
            else {
                val willOverInMs = DateTimeUtils.todDifferenceFromNow(restriction.activePeriodEnd)
                futureState.add(state.copy(timeLeftMillis = willOverInMs))
            }
        }


        /// Check group's active period
        restrictionGroups[restriction.associatedGroupId]?.let {
            if (it.activePeriodStart != it.activePeriodEnd) {
                val state = RestrictionState(
                    type = RestrictionType.GROUP_ACTIVE_PERIOD,
                    groupName = it.groupName,
                )
                /// Outside active period
                if (DateTimeUtils.isTimeOutsideTODs(it.activePeriodStart, it.activePeriodEnd)) {
                    Log.d(
                        TAG,
                        "evaluateActivePeriodLimit: ${it.groupName} group's active period is over"
                    )
                    return state
                }
                /// Launched between active period calculate expiration time
                else {
                    val willOverInMs = DateTimeUtils.todDifferenceFromNow(it.activePeriodEnd)
                    futureState.add(state.copy(timeLeftMillis = willOverInMs))
                }
            }
        }

        return null
    }

    private fun evaluateScreenTimeLimit(
        restriction: AppRestriction,
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
                    type = RestrictionType.APP_TIMER,
                    screenTimeUsed = screenTimeSec,
                    screenTimeLimit = restriction.timerSec.toLong(),
                    reminderType = restriction.reminderType,
                )

                alreadyRestrictedApps[restriction.appPackage] = state
                return state
            } else {
                /// App timer left so add expiration timestamp
                val leftAppLimitMs = (restriction.timerSec - screenTimeSec) * 1000L
                futureStates.add(
                    RestrictionState(
                        type = RestrictionType.APP_TIMER,
                        timeLeftMillis = leftAppLimitMs,
                        screenTimeUsed = screenTimeSec,
                        screenTimeLimit = restriction.timerSec.toLong(),
                        reminderType = restriction.reminderType,
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
                        type = RestrictionType.GROUP_TIMER,
                        screenTimeUsed = groupScreenTimeSec,
                        screenTimeLimit = group.timerSec.toLong(),
                        reminderType = restriction.reminderType,
                        groupName = group.groupName,
                    )

                    alreadyRestrictedGroups[group.id] = state
                    return state
                } else {
                    /// group timer left so add expiration timestamp
                    val leftAppLimitMs = (group.timerSec - groupScreenTimeSec) * 1000L
                    futureStates.add(
                        RestrictionState(
                            type = RestrictionType.GROUP_TIMER,
                            timeLeftMillis = leftAppLimitMs,
                            screenTimeUsed = groupScreenTimeSec,
                            screenTimeLimit = group.timerSec.toLong(),
                            reminderType = restriction.reminderType,
                            groupName = group.groupName,
                        )
                    )
                }
            }
        }

        return null
    }
}
