package com.mindful.android.services.tracking

import android.util.Log
import com.mindful.android.models.RestrictionState
import com.mindful.android.utils.CountDownExecutor
import java.util.Date
import java.util.concurrent.TimeUnit

class ReminderManager(
    private val overlayManager: OverlayManager,
    private val onNewAppLaunched: (packageName: String) -> Unit,
) {
    private val TAG = "Mindful.ReminderManager"
    private val reminderTriggers: HashSet<Int> = HashSet(0)
    private var onGoingTimer: CountDownExecutor? = null

    fun cancelReminders() {
        onGoingTimer?.cancel()
        reminderTriggers.clear()
        Log.d(TAG, "cancelReminders: All reminders cancelled")
    }

    private fun addNewReminder(futureMinutes: Int) {
        reminderTriggers.add(futureMinutes)
        Log.d(TAG, "addNewReminder: New reminder added $futureMinutes")
    }

    fun scheduleReminders(
        packageName: String,
        state: RestrictionState,
    ) {
        // If it is a timer restricted state
        if (state.usedScreenTime > 0
            && state.totalScreenTimer > 0
            && ((state.totalScreenTimer - state.usedScreenTime) > 120)
        ) {
            reminderTriggers.add(1)
        }


        // Set timer for expiration
        val executor = CountDownExecutor(
            duration = state.expirationFutureMs,
            interval = 60 * 1000L,
            timeUnit = TimeUnit.MILLISECONDS,
            onTick = { elapsedMs ->
                val spentMins = (elapsedMs / 60000).toInt()

                Log.d(
                    TAG,
                    "onTick: $spentMins Minute ticked with reminders: $reminderTriggers"
                )


                if (reminderTriggers.contains(spentMins)) {
                    reminderTriggers.remove(spentMins)
                    overlayManager.showOverlay(
                        packageName = packageName,
                        restrictionState = state.copy(
                            usedScreenTime = state.usedScreenTime + (spentMins * 60)
                        ),
                        addReminderDelay = { delayMin -> addNewReminder(delayMin + spentMins) }
                    )
                }
            },

            onFinish = {
                Log.d(TAG, "onFinish: Timer finished for $packageName")
                // Recalculate restriction state
                onNewAppLaunched.invoke(packageName)
            }
        )
        executor.start()
        onGoingTimer = executor


        Log.d(
            TAG,
            "scheduleReminders: Timer scheduled for $packageName till  ${Date(System.currentTimeMillis() + state.expirationFutureMs)} "
        )
    }
}