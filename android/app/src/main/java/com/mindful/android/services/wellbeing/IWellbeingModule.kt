package com.mindful.android.services.wellbeing

import android.content.Context
import android.view.accessibility.AccessibilityEvent
import android.view.accessibility.AccessibilityNodeInfo
import androidx.annotation.MainThread
import androidx.annotation.WorkerThread

interface IWellbeingModule {

    @MainThread
    fun onCreate(context: Context)

    @MainThread
    fun onConnected(context: Context)

    @WorkerThread
    fun onAccessibilityEvent(
        context: Context,
        event: AccessibilityEvent,
        eventNode: AccessibilityNodeInfo?,
        rootNode: AccessibilityNodeInfo?,
    )

    @MainThread
    fun onInterrupt(context: Context)

    @MainThread
    fun onDestroy(context: Context)

    @WorkerThread
    fun onMidnightReset(context: Context)
}