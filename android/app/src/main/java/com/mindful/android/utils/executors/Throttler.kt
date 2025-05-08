package com.mindful.android.utils.executors

import android.os.Handler
import android.os.Looper

class Throttler(
    private val delayMillis: Long = 300L,
) {
    private val handler = Handler(Looper.myLooper() ?: Looper.getMainLooper())
    private var lastExecutionTime: Long = 0

    fun submit(action: () -> Unit) {
        val currentTime = System.currentTimeMillis()

        // Execute the action immediately if enough time has passed since the last execution
        if (currentTime - lastExecutionTime >= delayMillis) {
            action()
            lastExecutionTime = currentTime
        } else {
            // If the time hasn't passed, delay the execution
            val timeRemaining = delayMillis - (currentTime - lastExecutionTime)
            handler.removeCallbacksAndMessages(null)
            handler.postDelayed({
                action()
                lastExecutionTime = System.currentTimeMillis()
            }, timeRemaining)
        }
    }
}
