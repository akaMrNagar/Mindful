package com.mindful.android.services.wellbeing

import android.accessibilityservice.AccessibilityService
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Build
import android.util.Log
import android.view.accessibility.AccessibilityEvent
import android.view.accessibility.AccessibilityNodeInfo
import android.widget.Toast
import com.mindful.android.helpers.storage.SharedPrefsHelper
import com.mindful.android.services.accessibility.TrackingManager.Companion.ACTION_ACCESSIBILITY_ACTIVE
import com.mindful.android.services.accessibility.TrackingManager.Companion.ACTION_ACCESSIBILITY_INACTIVE
import com.mindful.android.services.accessibility.TrackingManager.Companion.ACTION_NEW_APP_LAUNCHED
import com.mindful.android.utils.ThreadUtils
import com.mindful.android.utils.Utils
import java.util.concurrent.ExecutorService
import java.util.concurrent.Executors

class WellbeingService : AccessibilityService() {
    companion object {
        private const val TAG = "Mindful.WellbeingService"
    }

    private val executorService: ExecutorService = Executors.newFixedThreadPool(4)
    private val wellbeingReceiver: WellbeingReceiver = WellbeingReceiver()
    private val wellbeingModules = listOf<IWellbeingModule>()

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        return super.onStartCommand(intent, flags, startId)
    }

    override fun onCreate() {
        super.onCreate()
        runCatching {
            wellbeingReceiver.register(this)
            wellbeingModules.forEach { it.onCreate(this) }
        }.getOrElse { onError(it) }
    }

    override fun onServiceConnected() {
        super.onServiceConnected()
        runCatching {
            wellbeingModules.forEach { it.onConnected(this) }
        }.getOrElse { onError(it) }
    }

    override fun onAccessibilityEvent(event: AccessibilityEvent?) {
        if (event == null || executorService.isShutdown) return

        // Process event in background
        runCatching {
            executorService.submit {
                // Clone event and nodes for processing
                val eventClone =
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) AccessibilityEvent(event)
                    else AccessibilityEvent.obtain(event)

                val eventNodeClone = event.source?.let {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) AccessibilityNodeInfo(it)
                    else AccessibilityNodeInfo.obtain(it)
                }

                val rootNodeClone = rootInActiveWindow?.let {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) AccessibilityNodeInfo(it)
                    else AccessibilityNodeInfo.obtain(it)
                }

                wellbeingModules.forEach {
                    it.onAccessibilityEvent(
                        context = this,
                        event = eventClone,
                        eventNode = eventNodeClone,
                        rootNode = rootNodeClone,
                    )
                }
            }
        }.getOrElse { onError(it) }
    }

    override fun onInterrupt() {
        runCatching {
            wellbeingModules.forEach { it.onInterrupt(this) }
        }.getOrElse { onError(it) }
    }


    override fun onDestroy() {
        super.onDestroy()
        runCatching {
            wellbeingReceiver.unRegister(this)
            executorService.shutdown()
            wellbeingModules.forEach { it.onDestroy(this) }
        }.getOrElse { onError(it) }
    }

    private fun performAction(
        globalAction: Int? = null,
        toastMsg: String? = null,
    ) {
        runCatching {
            // Perform global action
            globalAction?.let { performGlobalAction(it) }

            // Show toast on main thread
            toastMsg?.let {
                ThreadUtils.runOnMainThread {
                    Toast.makeText(
                        this,
                        it,
                        Toast.LENGTH_LONG,
                    ).show()
                }
            }
        }.getOrElse { onError(it) }
    }

    private fun onError(throwable: Throwable) {
        // TODO : Implement logging anc crashlytics
    }


    inner class WellbeingReceiver : BroadcastReceiver() {
        private val TAG = "Mindful.WellbeingService.WellbeingReceiver"


        fun register(context: Context) {
            try {
                Utils.safelyRegisterReceiver(
                    context,
                    this,
                    IntentFilter().apply {
                        addAction(ACTION_ACCESSIBILITY_ACTIVE)
                        addAction(ACTION_ACCESSIBILITY_INACTIVE)
                        addAction(ACTION_NEW_APP_LAUNCHED)
                    },
                )
            } catch (e: Exception) {
                Log.e(TAG, "register: Failed to register receiver", e)
                SharedPrefsHelper.insertCrashLogToPrefs(context, e)
            }
        }

        fun unRegister(context: Context) {
            try {
                context.unregisterReceiver(this)
            } catch (e: Exception) {
                Log.e(TAG, "register: Failed to un-register receiver", e)
                SharedPrefsHelper.insertCrashLogToPrefs(context, e)
            }
        }

        override fun onReceive(context: Context?, intent: Intent?) {

            // Handle broadcasted  events
            executorService.submit {
                when (intent?.action) {

                    else -> return@submit
                }
            }
        }

    }
}