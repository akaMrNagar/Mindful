package com.mindful.android.utils

import android.os.Handler
import android.os.Looper

class Debouncer(
    private val delayMillis: Long = 300L,
) {
    private val handler = Handler(Looper.myLooper() ?: Looper.getMainLooper())
    private var runnable: Runnable? = null

    fun submit(action: () -> Unit) {
        // Cancel
        runnable?.let { handler.removeCallbacks(it) }

        // Create
        runnable = Runnable { action() }

        // Post
        runnable?.let {
            handler.postDelayed(it, delayMillis)
        }
    }
}
