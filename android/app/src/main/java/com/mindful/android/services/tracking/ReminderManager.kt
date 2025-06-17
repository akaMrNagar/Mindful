package com.mindful.android.services.tracking

import android.util.Log
import com.mindful.android.enums.ReminderType
import com.mindful.android.models.RestrictionState
import com.mindful.android.utils.executors.PreciseCountDownExecutor
import java.util.Date
import java.util.concurrent.TimeUnit

class ReminderManager(
    private val overlayManager: OverlayManager,
    private val onNewAppLaunched: (packageName: String) -> Unit,
) {
    private val TAG = "Mindful.ReminderManager"
    private val triggerInterval = 10L
    private val reminderTriggers: HashSet<Int> = HashSet(0)
    private var activeTimer: PreciseCountDownExecutor? = null

    fun cancelReminders(): Boolean {
        val reminderAwaiting = activeTimer != null
        activeTimer?.cancel()
        activeTimer = null
        reminderTriggers.clear()
        Log.d(TAG, "cancelReminders: All reminders cancelled")

        /// Return true if have reminder
        return reminderAwaiting
    }

    private fun addNewReminder(futureMinutes: Int) {
        reminderTriggers.add(futureMinutes)
        Log.d(TAG, "addNewReminder: New reminder added $futureMinutes")
    }

    fun scheduleReminders(
        packageName: String,
        state: RestrictionState,
    ) {
        populateReminderTriggers(state)
        Log.d(
            TAG,
            "scheduleReminders: Used: ${state.screenTimeUsed / 60}  Limit: ${state.screenTimeLimit / 60}  Reminders: $reminderTriggers"
        )

        // Set timer for expiration
        activeTimer = PreciseCountDownExecutor(
            duration = state.timeLeftMillis,
            interval = 60000L,
            timeUnit = TimeUnit.MILLISECONDS,
            onTick = { elapsedMs ->
                val elapsedMinutes = (elapsedMs / 60000L).toInt()
                Log.d(TAG, "onTick: Ticked after $elapsedMinutes minute.")

                when (state.reminderType) {
                    ReminderType.NONE -> return@PreciseCountDownExecutor
                    ReminderType.TOAST -> onToastReminder(packageName, elapsedMinutes, state)
                    ReminderType.NOTIFICATION -> onNotificationReminder(
                        packageName,
                        elapsedMinutes,
                        state
                    )

                    ReminderType.MODAL_SHEET -> onFullScreenReminder(
                        packageName,
                        elapsedMinutes,
                        state
                    )
                }
            },

            onFinish = {
                Log.d(TAG, "onFinish: Timer finished for $packageName")
                onNewAppLaunched.invoke(packageName)
            }
        ).also { it.start() }

        Log.d(
            TAG,
            "scheduleReminders: Timer scheduled for $packageName at ${Date(System.currentTimeMillis() + state.timeLeftMillis)}"
        )
    }

    private fun onFullScreenReminder(
        packageName: String,
        elapsedMinutes: Int,
        state: RestrictionState,
    ) {
        // Add an initial reminder only at the first tick
        if (elapsedMinutes == 0 && (state.screenTimeLimit - state.screenTimeUsed) > 120) {
            addNewReminder(1)
        }

        /// Return if not the desired trigger
        if (!reminderTriggers.remove(elapsedMinutes)) return

        /// Show overlay
        val updatedState = state.copy(
            screenTimeUsed = state.screenTimeUsed + (elapsedMinutes * 60)
        )
        overlayManager.showSheetOverlay(
            packageName = packageName,
            restrictionState = updatedState,
            addReminderWithDelay = { delayMin -> addNewReminder(delayMin + elapsedMinutes) },
        )
    }

    private fun onToastReminder(
        packageName: String,
        elapsedMinutes: Int,
        state: RestrictionState,
    ) {
        /// Return if not the desired trigger
        val totalElapsedMinutes = ((state.screenTimeUsed / 60) + elapsedMinutes).toInt()
        if (!reminderTriggers.remove(totalElapsedMinutes)) return

        Log.d(TAG, "onToastReminder: Showing toast at $totalElapsedMinutes")
        overlayManager.showToastOverlay(packageName, totalElapsedMinutes)
    }

    private fun onNotificationReminder(
        packageName: String,
        elapsedMinutes: Int,
        state: RestrictionState,
    ) {
        /// Return if not the desired trigger
        val totalElapsedMinutes = ((state.screenTimeUsed / 60) + elapsedMinutes).toInt()
        if (!reminderTriggers.remove(totalElapsedMinutes)) return

        Log.d(TAG, "onNotificationReminder: Showing notification at $totalElapsedMinutes")
        overlayManager.showNotification(packageName, totalElapsedMinutes)
    }

    private fun populateReminderTriggers(state: RestrictionState) {
        reminderTriggers.clear()

        when (state.reminderType) {
            ReminderType.MODAL_SHEET -> {
                // Add the first reminder after 1 minute if > 2 mins left
                if ((state.screenTimeLimit - state.screenTimeUsed) > 120) {
                    reminderTriggers.add(1)
                }
            }

            ReminderType.TOAST,
            ReminderType.NOTIFICATION,
                -> {
                // Add all multiples of [trigger interval] minutes after current usage
                val usedMinutes = state.screenTimeUsed / 60
                val limitMinutes = state.screenTimeLimit / 60

                for (i in usedMinutes..limitMinutes) {
                    if (i % triggerInterval == 0L) {
                        reminderTriggers.add(i.toInt())
                    }
                }
            }

            ReminderType.NONE -> return
        }
    }
}