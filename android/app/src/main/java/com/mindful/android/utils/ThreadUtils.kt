package com.mindful.android.utils

import android.os.Handler
import android.os.Looper
import androidx.annotation.AnyThread

object ThreadUtils {

    /**
     * This method ensures that the block runs on the main looper thread.
     */
    @AnyThread
    fun runOnMainThread(block: () -> Unit) {
        Handler(Looper.getMainLooper()).post {
            block()
        }
    }

    /**
     * This method ensures that the block runs on the main looper thread.
     * With the specified delay in Milliseconds
     */
    @AnyThread
    fun runOnMainThread(delayMs: Long, block: () -> Unit) {
        Handler(Looper.getMainLooper()).postDelayed(block, delayMs)
    }
}