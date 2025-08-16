package com.mindful.android.services.tracking

import android.app.NotificationManager
import android.app.Service.NOTIFICATION_SERVICE
import android.content.Context
import android.content.Context.WINDOW_SERVICE
import android.content.Intent
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.provider.Settings
import android.util.Log
import android.view.Gravity
import android.view.View
import android.view.WindowManager
import android.view.animation.OvershootInterpolator
import android.widget.LinearLayout
import androidx.core.app.NotificationCompat
import androidx.core.graphics.drawable.toBitmap
import com.mindful.android.R
import com.mindful.android.helpers.device.NotificationHelper
import com.mindful.android.helpers.device.NotificationHelper.USAGE_REMINDERS_CHANNEL_ID
import com.mindful.android.helpers.storage.SharedPrefsHelper
import com.mindful.android.models.RestrictionState
import com.mindful.android.services.accessibility.MindfulAccessibilityService
import com.mindful.android.services.accessibility.MindfulAccessibilityService.Companion.ACTION_PERFORM_HOME_PRESS
import com.mindful.android.services.tracking.OverlayBuilder.getAppLabelAndIcon
import com.mindful.android.utils.AppUtils
import com.mindful.android.utils.DateTimeUtils
import com.mindful.android.utils.ThreadUtils
import com.mindful.android.utils.Utils
import java.util.concurrent.ConcurrentLinkedDeque


class OverlayManager(
    private val context: Context,
) {
    private var overlays: ConcurrentLinkedDeque<View> = ConcurrentLinkedDeque()
    private val windowManager: WindowManager =
        context.getSystemService(WINDOW_SERVICE) as WindowManager


    /// Animate out the overlay
    fun dismissSheetOverlay() {
        overlays.pollFirst()?.let { sheetOverlay ->
            ThreadUtils.runOnMainThread {
                // Get views
                val bg = sheetOverlay.findViewById<View>(R.id.overlay_background)
                val quote = sheetOverlay.findViewById<View>(R.id.overlay_sheet_quote_panel)
                val sheet = sheetOverlay.findViewById<LinearLayout>(R.id.overlay_sheet)

                // Animate
                bg.animate().alpha(0f).setDuration(400).start()
                quote.animate().alpha(0f).setDuration(400).start()
                sheet.animate()
                    .translationY(SLIDE_DOWN_END_Y)
                    .setInterpolator(OvershootInterpolator(1.5f))
                    .setDuration(500)
                    .withEndAction {
                        windowManager.removeView(sheetOverlay)
                    }
                    .start()
            }
        }
    }

    fun showSheetOverlay(
        packageName: String,
        restrictionState: RestrictionState,
        addReminderWithDelay: ((futureMinutes: Int) -> Unit)? = null,
    ) {
        // Return if overlay is not null
        if (overlays.isNotEmpty()) return

        ThreadUtils.runOnMainThread {
            runCatching {

                // Notify, stop and return if don't have overlay permission
                if (!haveOverlayPermission(context)) {
                    return@runOnMainThread
                }

                // Build overlay
                val sheetOverlay = OverlayBuilder.buildFullScreenOverlay(
                    context = context,
                    packageName = packageName,
                    state = restrictionState,
                    dismissOverlay = ::dismissSheetOverlay,
                    addReminderDelay = addReminderWithDelay,
                ).apply {
                    // TODO: Fix the deprecated logic
                    // Full screen edge to edge view
                    systemUiVisibility = View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN or
                            View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION or
                            View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY
                }

                Log.d(TAG, "showFullScreenOverlay: Showing full screen overlay for $packageName")
                sheetOverlay.also {
                    windowManager.addView(it, sheetLayoutParams)
                    overlays.push(it)
                    Utils.vibrateDevice(context, 50L)

                    // Get views
                    val bg = sheetOverlay.findViewById<View>(R.id.overlay_background)
                    val quote = sheetOverlay.findViewById<View>(R.id.overlay_sheet_quote_panel)
                    val sheet = sheetOverlay.findViewById<LinearLayout>(R.id.overlay_sheet)

                    // Set initial
                    bg.alpha = 0f
                    quote.alpha = 0f
                    sheet.translationY = SLIDE_UP_START_Y

                    // Animate
                    bg.animate().alpha(1f).setDuration(400).start()
                    quote.animate().alpha(1f).setDuration(400).start()
                    sheet.animate()
                        .translationY(0f)
                        .setInterpolator(OvershootInterpolator(1.5f))
                        .setDuration(500)
                        .start()
                }
            }.getOrElse {
                SharedPrefsHelper.insertCrashLogToPrefs(context, it)
            }
        }
    }


    fun showToastOverlay(
        packageName: String,
        screenTimeUsedInMins: Int,
    ) {
        ThreadUtils.runOnMainThread {
            runCatching {
                // Notify, stop and return if don't have overlay permission
                if (!haveOverlayPermission(context)) return@runOnMainThread

                // Build view
                val toastView = OverlayBuilder.buildToastOverlay(
                    context,
                    packageName,
                    screenTimeUsedInMins
                )

                Log.d(TAG, "Showing toast overlay for $packageName")
                windowManager.addView(toastView, toastLayoutParams)

                // Fade-in
                toastView.animate()
                    .alpha(1f)
                    .setDuration(500)
                    .start()

                // Fade-out and remove after delay
                Handler(Looper.getMainLooper()).let {
                    it.postDelayed({
                        toastView.animate()
                            .alpha(0f)
                            .setDuration(500)
                            .withEndAction {
                                it.postDelayed({ windowManager.removeView(toastView) }, 100L)
                            }
                            .start()
                    }, 5000)
                }
            }.getOrElse { e ->
                Log.e(TAG, "showToastOverlay: Failed to show toast overlay", e)
                SharedPrefsHelper.insertCrashLogToPrefs(context, e)
            }
        }
    }

    fun showNotification(
        packageName: String,
        screenTimeUsedInMins: Int,
    ) {
        // Get notification manager
        val notificationManager =
            context.getSystemService(NOTIFICATION_SERVICE) as NotificationManager

        // Resolve app icon and label
        val (appName, appIcon) = getAppLabelAndIcon(context, packageName)

        val msg = context.getString(
            R.string.app_screen_time_usage_info,
            DateTimeUtils.minutesToTimeStr(screenTimeUsedInMins)
        )
        notificationManager.notify(
            302,
            NotificationCompat.Builder(
                context,
                USAGE_REMINDERS_CHANNEL_ID
            )
                .setSmallIcon(R.drawable.ic_mindful_notification)
                .setLargeIcon(appIcon.toBitmap())
                .setContentTitle(appName)
                .setContentText(msg)
                .setStyle(NotificationCompat.BigTextStyle().bigText(msg))
                .setSound(null)
                .setAutoCancel(true)
                .setContentIntent(
                    AppUtils.getPendingIntentForMindfulUri(
                        context,
                        "com.mindful.android://open/appDashboard?package=$packageName"
                    )
                )
                .build()
        )

    }

    companion object {
        private const val TAG = "Mindful.OverlayManager"

        private const val SLIDE_UP_START_Y = 640f
        private const val SLIDE_DOWN_END_Y = 1280f

        private val sheetLayoutParams = WindowManager.LayoutParams(
            WindowManager.LayoutParams.MATCH_PARENT,
            WindowManager.LayoutParams.MATCH_PARENT,
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY
            } else {
                WindowManager.LayoutParams.TYPE_PHONE
            },
            WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE or
                    WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS or
                    WindowManager.LayoutParams.FLAG_LAYOUT_IN_SCREEN or
                    WindowManager.LayoutParams.FLAG_LAYOUT_INSET_DECOR,
            android.graphics.PixelFormat.TRANSLUCENT
        ).apply {
            gravity = Gravity.TOP or Gravity.CENTER_HORIZONTAL
        }

        private val toastLayoutParams = WindowManager.LayoutParams(
            WindowManager.LayoutParams.WRAP_CONTENT,
            WindowManager.LayoutParams.WRAP_CONTENT,
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY
            } else {
                WindowManager.LayoutParams.TYPE_PHONE
            },
            WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE,
            android.graphics.PixelFormat.TRANSLUCENT
        ).apply {
            gravity = Gravity.TOP or Gravity.CENTER_HORIZONTAL
            verticalMargin = 0.05f
        }


        private fun haveOverlayPermission(context: Context): Boolean {
            if (!Settings.canDrawOverlays(context)) {
                // Show notification
                NotificationHelper.pushAskOverlayPermissionNotification(context)

                // Go home if accessibility is running
                if (Utils.isServiceRunning(context, MindfulAccessibilityService::class.java)) {
                    val serviceIntent = Intent(
                        context.applicationContext,
                        MindfulAccessibilityService::class.java
                    ).setAction(ACTION_PERFORM_HOME_PRESS)

                    context.startService(serviceIntent)
                }

                Log.d(
                    TAG,
                    "checkOverlayPermission: Display overlay permission denied, returning"
                )
                return false
            } else {
                return true
            }
        }
    }
}
