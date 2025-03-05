package com.mindful.android.services.tracking

import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.drawable.Drawable
import android.view.LayoutInflater
import android.view.View
import android.widget.Button
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.ProgressBar
import android.widget.TextView
import androidx.annotation.MainThread
import com.mindful.android.R
import com.mindful.android.enums.RestrictionType
import com.mindful.android.models.RestrictionState
import com.mindful.android.utils.ThreadUtils
import com.mindful.android.utils.Utils

object OverlayBuilder {
    @MainThread
    fun buildOverlay(
        context: Context,
        packageName: String,
        state: RestrictionState,
        removeOverlay: () -> Unit,
        addReminderDelay: ((futureMinutes: Int) -> Unit)? = null,
    ): View {
        // Inflate the custom layout for the dialog
        val inflater = LayoutInflater.from(context)
        val sheetView = inflater.inflate(R.layout.overlay_sheet_layout, null)

        // Resolve app icon and label
        val (appName, appIcon) = getAppLabelAndIcon(context, packageName)

        // App infos
        val appNameTxt = sheetView.findViewById<TextView>(R.id.overlay_sheet_app_name)
        val appIconImg = sheetView.findViewById<ImageView>(R.id.overlay_sheet_app_icon)
        appNameTxt.text = appName
        appIconImg.setImageDrawable(appIcon)

        // Emergency button (Visible only if limit is exhausted)
        if (state.usedScreenTime >= state.totalScreenTimer) {
            val emergencyBtn = sheetView.findViewById<Button>(R.id.overlay_sheet_btn_emergency)
            emergencyBtn.visibility = View.VISIBLE
            emergencyBtn.setOnClickListener {
                ThreadUtils.runOnMainThread {
                    context.applicationContext.startActivity(
                        Utils.getIntentForMindfulUri(
                            context,
                            "com.mindful.android://open/appDashboard?package=$packageName"
                        )
                    )
                    removeOverlay.invoke()
                }
            }
        }

        // Limit type
        val limitType = sheetView.findViewById<TextView>(R.id.overlay_sheet_limit_type)
        limitType.text = context.getString(
            when (state.type) {
                RestrictionType.FocusMode -> R.string.app_paused_restriction_focus_mode
                RestrictionType.BedtimeMode -> R.string.app_paused_restriction_bedtime_mode
                RestrictionType.Timer -> R.string.app_paused_restriction_timer
                RestrictionType.LaunchCount -> R.string.app_paused_restriction_launch_count
                RestrictionType.ActivePeriod -> R.string.app_paused_restriction_active_period
            }
        )

        // Limit information
        val limitInfo = sheetView.findViewById<TextView>(R.id.overlay_sheet_limit_info)
        limitInfo.text = state.message

        // Limit progress, and use more layout
        if (state.totalScreenTimer > 0 && state.usedScreenTime > 0) {
            // Make limit parent container visible
            val limitContainer =
                sheetView.findViewById<LinearLayout>(R.id.overlay_sheet_limit_container)
            limitContainer.visibility = View.VISIBLE

            // calculate limit in minutes
            val usedLimitMins = (state.usedScreenTime / 60).toInt()
            val totalLimitMins = (state.totalScreenTimer / 60).toInt()
            val leftLimitMins = if (usedLimitMins < totalLimitMins) totalLimitMins - usedLimitMins
            else 0

            // Progress bar
            val progressBar = sheetView.findViewById<ProgressBar>(R.id.overlay_sheet_limit_progress)
            progressBar.max = state.totalScreenTimer.toInt()
            progressBar.setProgress(state.usedScreenTime.toInt(), true)

            // limit spent text
            val limitSpentTxt = sheetView.findViewById<TextView>(R.id.overlay_sheet_limit_spent)
            limitSpentTxt.text = Utils.minutesToTimeStr(usedLimitMins)

            // limit left text
            val limitLeftTxt = sheetView.findViewById<TextView>(R.id.overlay_sheet_limit_left)
            limitLeftTxt.text = Utils.minutesToTimeStr(leftLimitMins)

            // Wish to use more? options layout
            if (leftLimitMins > 0) {
                val useMoreOptions =
                    sheetView.findViewById<LinearLayout>(R.id.overlay_sheet_limit_options_use_more)
                useMoreOptions.visibility = View.VISIBLE

                // Iterate over reminders and the button ids map and set click listener
                // and make them visible if the left limit is more than the specified reminder time
                addReminderDelay?.let { callback ->
                    mapOf(
                        2 to R.id.overlay_sheet_reminder_option_btn_two_mins,
                        5 to R.id.overlay_sheet_reminder_option_btn_five_mins,
                        10 to R.id.overlay_sheet_reminder_option_btn_ten_mins,
                        20 to R.id.overlay_sheet_reminder_option_btn_twenty_mins
                    ).forEach { (reminder, btnId) ->
                        // Always show 2 minute option if left minutes > 0
                        if (reminder == 2 || leftLimitMins >= reminder) {
                            val button = sheetView.findViewById<Button>(btnId)
                            button.visibility = View.VISIBLE
                            button.setOnClickListener {
                                callback(reminder)
                                removeOverlay.invoke()
                            }
                        }
                    }
                }
            }
        }

        // Close app button
        val closeAppBtn = sheetView.findViewById<Button>(R.id.overlay_sheet_btn_close_app)
        closeAppBtn.text = context.getString(R.string.app_paused_overlay_button_close_app, appName)
        closeAppBtn.setOnClickListener {
            ThreadUtils.runOnMainThread {
                val homeIntent = Intent(Intent.ACTION_MAIN)
                homeIntent.addCategory(Intent.CATEGORY_HOME)
                homeIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                context.applicationContext.startActivity(homeIntent)
                removeOverlay.invoke()
            }
        }

        return sheetView
    }


    private fun getAppLabelAndIcon(
        context: Context,
        packageName: String,
    ): Pair<String, Drawable> {
        val packageManager = context.packageManager
        val info = packageManager.getApplicationInfo(packageName, PackageManager.GET_META_DATA)
        val appName = info.loadLabel(packageManager).toString()
        val appIcon = packageManager.getApplicationIcon(info)

        return appName to appIcon
    }
}