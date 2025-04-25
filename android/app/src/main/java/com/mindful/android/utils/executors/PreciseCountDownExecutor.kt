package com.mindful.android.utils.executors

import android.os.Handler
import android.os.HandlerThread
import android.os.SystemClock
import java.util.concurrent.TimeUnit

class PreciseCountDownExecutor(
    private val duration: Long,
    private val interval: Long,
    private val timeUnit: TimeUnit,
    private val onTick: ((Long) -> Unit)? = null,
    private val onFinish: (() -> Unit)? = null,
) {
    private var handlerThread: HandlerThread? = null
    private var handler: Handler? = null

    // Store the start time
    private var startTime: Long = 0L

    fun start() {
        // Cancel previous executor and reset
        cancel()


        handlerThread = HandlerThread("PreciseCountDownThread")
        handlerThread?.start()
        handler = Handler(handlerThread!!.looper)
        startTime = System.currentTimeMillis() // Record the start time

        scheduleNextTick()
    }

    private fun scheduleNextTick() {
        val delay = timeUnit.toMillis(interval)

        handler?.postAtTime({
            val elapsedTimeMs = System.currentTimeMillis() - startTime
            // Convert the time to same unit
            val elapsedTime = timeUnit.convert(elapsedTimeMs, TimeUnit.MILLISECONDS)

            if (elapsedTime <= duration) {
                onTick?.invoke(elapsedTime)
                scheduleNextTick() // Schedule next tick
            } else {
                onFinish?.invoke()
                cancel()
            }
        }, SystemClock.uptimeMillis() + delay) // Use uptimeMillis for scheduling
    }

    fun cancel() {
        handler?.removeCallbacksAndMessages(null)
        handlerThread?.quitSafely()
        handlerThread = null
        handler = null
    }
}