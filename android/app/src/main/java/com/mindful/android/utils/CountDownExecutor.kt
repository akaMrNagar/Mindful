package com.mindful.android.utils

import java.util.concurrent.Executors
import java.util.concurrent.ScheduledExecutorService
import java.util.concurrent.TimeUnit

class CountDownExecutor(
    private val duration: Long,
    private val interval: Long,
    private val timeUnit: TimeUnit,
    private val onTick: ((Long) -> Unit)? = null,
    private val onFinish: (() -> Unit)? = null,
    private val initialDelay: Long = 0L,
) {
    private var timerExecutor: ScheduledExecutorService? = null
    private var elapsedTime: Long = 0L

    fun start() {
        // Cancel previous executor and reset
        cancel()

        // Schedule new executor
        timerExecutor = Executors.newScheduledThreadPool(1)
        timerExecutor?.scheduleWithFixedDelay(
            {
                if (elapsedTime < duration) {
                    onTick?.invoke(elapsedTime)
                } else {
                    onFinish?.invoke()
                    cancel()
                }
                elapsedTime += interval
            },
            initialDelay, interval, timeUnit,
        )
    }

    fun cancel() {
        timerExecutor?.shutdownNow()
        timerExecutor = null
        elapsedTime = 0L
    }

}