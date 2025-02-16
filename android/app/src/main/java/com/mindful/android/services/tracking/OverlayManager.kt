package com.mindful.android.services.tracking

import android.content.Context
import android.content.Context.WINDOW_SERVICE
import android.os.Build
import android.provider.Settings
import android.util.Log
import android.view.Gravity
import android.view.View
import android.view.WindowManager
import android.view.animation.AlphaAnimation
import android.view.animation.Animation
import android.view.animation.OvershootInterpolator
import android.view.animation.TranslateAnimation
import android.widget.FrameLayout
import android.widget.LinearLayout
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat
import com.mindful.android.R
import com.mindful.android.helpers.device.NotificationHelper
import com.mindful.android.models.RestrictionState
import com.mindful.android.utils.ThreadUtils
import java.util.concurrent.atomic.AtomicBoolean

class OverlayManager(
    private val context: Context,
) {
    private val windowManager: WindowManager =
        context.getSystemService(WINDOW_SERVICE) as WindowManager

    private var overlay: View? = null
    private var isDismissingOverlay: Boolean = false

    init {
        fadeOutAnim.setAnimationListener(
            object : Animation.AnimationListener {
                override fun onAnimationStart(a: Animation?) {
                    isDismissingOverlay = true
                }

                override fun onAnimationRepeat(a: Animation?) {}

                override fun onAnimationEnd(a: Animation?) {
                    removeOverlay()
                    isDismissingOverlay = false
                }
            }
        )
    }

    /// Animate out the overlay
    fun dismissOverlay() {
        /// Skip if already animating to dismiss
        if (isDismissingOverlay) {
            return
        }

        ThreadUtils.runOnMainThread {
            animateOverlay(animateIn = false)
        }
    }

    /// Remove overlay after animating out
    private fun removeOverlay() {
        overlay?.let {
            windowManager.removeView(it)
            overlay = null
        }
    }


    fun showOverlay(
        packageName: String,
        restrictionState: RestrictionState,
        addReminderDelay: ((futureMinutes: Int) -> Unit)? = null,
    ) {
        Log.d(TAG, "showOverlay: Showing overlay for $packageName")

        ThreadUtils.runOnMainThread {
            // Notify, stop and return if don't have overlay permission
            if (!Settings.canDrawOverlays(context)) {
                NotificationHelper.pushAskOverlayPermissionNotification(context)
                Log.d(
                    TAG,
                    "showOverlay: Display overlay permission denied, returning"
                )
                return@runOnMainThread
            }

            // Build overlay
            overlay = OverlayBuilder.buildOverlay(
                context,
                packageName,
                restrictionState,
                ::dismissOverlay,
                addReminderDelay,
            )

            // Set up WindowManager parameters
            val layoutParams = WindowManager.LayoutParams(
                WindowManager.LayoutParams.MATCH_PARENT,
                WindowManager.LayoutParams.MATCH_PARENT,
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                    WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY
                } else {
                    WindowManager.LayoutParams.TYPE_PHONE
                },
                WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE or
                        WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS or
                        WindowManager.LayoutParams.FLAG_LAYOUT_IN_SCREEN,
                android.graphics.PixelFormat.TRANSLUCENT
            )

            // TODO: Fix the deprecated logic
            // Full screen edge to edge view
            overlay?.systemUiVisibility = View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN or
                    View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION or
                    View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY


            // Add the overlay view to the window
            layoutParams.gravity = Gravity.TOP or Gravity.START
            windowManager.addView(overlay, layoutParams)
            overlay?.rotation = 0f
            overlay?.findViewById<FrameLayout>(R.id.overlay_root)?.rotation = 0f

            // Animate the overlay
            animateOverlay(animateIn = true)
        }
    }

    private fun animateOverlay(animateIn: Boolean) {
        overlay?.let { view ->
            // Find the layers within overlay view
            val bgLayer = view.findViewById<View>(R.id.overlay_background)
            val sheetLayer = view.findViewById<LinearLayout>(R.id.overlay_sheet)

            if (animateIn) {
                bgLayer.startAnimation(fadeInAnim)
                sheetLayer.startAnimation(slideInAnim)
            } else {
                bgLayer.startAnimation(fadeOutAnim)
                sheetLayer.startAnimation(slideOutAnim)
            }
        }
    }

    companion object {
        private const val TAG = "Mindful.OverlayManager"

        private val elasticOutInterpolator = OvershootInterpolator(1.5f)

        private val fadeInAnim = AlphaAnimation(0f, 1f).apply {
            duration = 400
            fillAfter = true
        }

        private val fadeOutAnim = AlphaAnimation(1f, 0f).apply {
            duration = 400
            fillAfter = true
        }

        private val slideInAnim = TranslateAnimation(
            0f, 0f, 640f, 0f
        ).apply {
            duration = 350
            interpolator = elasticOutInterpolator
            fillAfter = true
        }

        private val slideOutAnim = TranslateAnimation(
            0f, 0f, 0f, 1280f
        ).apply {
            duration = 350
            interpolator = elasticOutInterpolator
            fillAfter = true
        }
    }
}
