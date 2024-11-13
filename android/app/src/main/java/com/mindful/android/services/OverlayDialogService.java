/*
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

package com.mindful.android.services;

import android.app.AlertDialog;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.graphics.drawable.Drawable;
import android.net.Uri;
import android.os.Build;
import android.os.Handler;
import android.os.IBinder;
import android.os.Looper;
import android.provider.Settings;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.ProgressBar;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.app.NotificationCompat;

import com.mindful.android.MainActivity;
import com.mindful.android.R;
import com.mindful.android.enums.PurgeType;
import com.mindful.android.helpers.NotificationHelper;
import com.mindful.android.utils.AppConstants;
import com.mindful.android.utils.Utils;

import org.jetbrains.annotations.Contract;

import java.util.Timer;
import java.util.TimerTask;

/**
 * Service that manages and displays an overlay dialog to inform the user about
 * a specific app whose usage timer has expired. The overlay provides options
 * for the user to close the app, use it temporarily, or initiate an emergency mode.
 */
public class OverlayDialogService extends Service {

    /**
     * Enum defining the types of dialog buttons and actions.
     */
    private enum DialogButtonType {
        Emergency,
        UseAnyway,
        CloseApp,
    }

    // Class constants
    private static final String TAG = "Mindful.OverlayDialogService";
    public static final String INTENT_EXTRA_PACKAGE_NAME = "launchedAppPackageName";
    public static final String INTENT_EXTRA_PURGE_TYPE = "overlayPurgeDialogType";
    public static final String INTENT_EXTRA_GROUP_NAME = "associatedGroupName";
    public static final String INTENT_EXTRA_MAX_PROGRESS = "maxProgress";
    public static final String INTENT_EXTRA_PROGRESS = "progress";

    // Instance variables
    private String mPackageName = "";
    private String mGroupName = "";
    private PurgeType mPurgeDialogType = PurgeType.AppTimerOut;
    private int mMaxProgress = 0;
    private int mProgress = 0;
    private AlertDialog mAlertDialog;
    private Timer mAutoCloseTimer;

    /**
     * Called when the service is started. This method retrieves data from the intent,
     * validates permissions, and triggers the display of the overlay dialog.
     *
     * @param intent  The Intent supplied to startService(Intent).
     * @param flags   Additional data about the start request.
     * @param startId A unique integer representing this start request.
     * @return START_STICKY if the dialog is successfully displayed,
     * START_NOT_STICKY otherwise.
     */
    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        if (intent == null) {
            stopSelf();
            return START_NOT_STICKY;
        }

        // Extracting intent data
        mPackageName = intent.getStringExtra(INTENT_EXTRA_PACKAGE_NAME);
        mGroupName = intent.getStringExtra(INTENT_EXTRA_GROUP_NAME);
        mMaxProgress = intent.getIntExtra(INTENT_EXTRA_MAX_PROGRESS, 0);
        mProgress = intent.getIntExtra(INTENT_EXTRA_PROGRESS, 0);
        mPurgeDialogType = PurgeType.fromInteger(intent.getIntExtra(INTENT_EXTRA_PURGE_TYPE, 0));

        // Validate permissions and display the overlay
        if (mPackageName != null && Settings.canDrawOverlays(this)) {
            try {
                Log.d(TAG, "onStartCommand: Showing dialog for package: " + mPackageName + " type: " + mPurgeDialogType + " group: " + mGroupName + " used: " + mProgress + " total: " + mMaxProgress);
                showAlertDialog();
                Log.d(TAG, "onStartCommand: Overlay dialog service started successfully");
                return START_STICKY;
            } catch (Exception e) {
                Log.e(TAG, "onStartCommand: Error starting overlay dialog service for app: " + mPackageName, e);
            }
        }

        if (!Settings.canDrawOverlays(this)) {
            notifyOverlayPermission();
            Log.d(TAG, "onStartCommand: Display over other apps permission not allowed");
        }

        stopSelf();
        return START_NOT_STICKY;
    }


    /**
     * Creates and displays an alert dialog showing information about the app whose timer expired.
     *
     * @throws PackageManager.NameNotFoundException if the app with the specified package name is not found.
     */
    private void showAlertDialog() throws PackageManager.NameNotFoundException {
        PackageManager packageManager = getPackageManager();
        ApplicationInfo info = packageManager.getApplicationInfo(mPackageName, PackageManager.GET_META_DATA);

        String appName = info.loadLabel(packageManager).toString();
        Drawable appIcon = packageManager.getApplicationIcon(info);

        // Inflate the custom layout for the dialog
        LayoutInflater inflater = LayoutInflater.from(this);
        View dialogView = inflater.inflate(R.layout.overlay_dialog_layout, null);

        // App info setup
        TextView appNameTxt = dialogView.findViewById(R.id.overlay_dialog_app_name);
        ImageView appIconImg = dialogView.findViewById(R.id.overlay_dialog_app_icon);
        appNameTxt.setText(appName);
        appIconImg.setImageDrawable(appIcon);

        // Dialog message setup
        TextView dialogInfoTxt = dialogView.findViewById(R.id.overlay_dialog_info);
        dialogInfoTxt.setText(resolveDialogInfo());

        // Use anyway and emergency button
        if (mProgress > 0 && mProgress < mMaxProgress) {
            Button useAnywayBtn = dialogView.findViewById(R.id.overlay_dialog_button_use_anyway);
            useAnywayBtn.setVisibility(View.VISIBLE);
            useAnywayBtn.setOnClickListener(v -> onDialogButtonClick(DialogButtonType.UseAnyway));
        } else {
            Button emergencyBtn = dialogView.findViewById(R.id.overlay_dialog_button_emergency);
            emergencyBtn.setVisibility(View.VISIBLE);
            emergencyBtn.setOnClickListener(v -> onDialogButtonClick(DialogButtonType.Emergency));
        }

        // Close app button setup
        Button closeAppBtn = dialogView.findViewById(R.id.overlay_dialog_button_close);
        closeAppBtn.setOnClickListener(v -> onDialogButtonClick(DialogButtonType.CloseApp));

        // Setup progress information
        if (mPurgeDialogType == PurgeType.AppTimerOut || mPurgeDialogType == PurgeType.GroupTimerOut) {
            ProgressBar progressBar = dialogView.findViewById(R.id.overlay_dialog_progress);
            progressBar.setVisibility(View.VISIBLE);
            progressBar.setMax(mMaxProgress);
            progressBar.setProgress(mProgress, true);

            TextView limitSpentTxt = dialogView.findViewById(R.id.overlay_dialog_limit_used);
            limitSpentTxt.setVisibility(View.VISIBLE);
            limitSpentTxt.setText(getString(R.string.app_paused_dialog_progress_spent, Utils.formatScreenTime(mProgress / 60)));

            TextView limitLeftTxt = dialogView.findViewById(R.id.overlay_dialog_limit_total);
            limitLeftTxt.setVisibility(View.VISIBLE);
            int leftLimit = Math.max(0, (mMaxProgress - mProgress));
            limitLeftTxt.setText(getString(R.string.app_paused_dialog_progress_left, Utils.formatScreenTime(leftLimit > 0 ? (leftLimit / 60) : 0)));

        }

        // Setup and display the dialog
        mAlertDialog = new AlertDialog
                .Builder(this, R.style.TransparentAlertDialog)
                .setView(dialogView)
                .setCancelable(false)
                .create();

        if (mAlertDialog.getWindow() != null) {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                mAlertDialog.getWindow().setType(WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY);
            } else {
                mAlertDialog.getWindow().setType(WindowManager.LayoutParams.TYPE_PHONE);
            }
        }

        mAlertDialog.show();

        /// Schedule auto dialog close timer
        if (mAutoCloseTimer == null) {
            mAutoCloseTimer = new Timer();
            mAutoCloseTimer.schedule(new TimerTask() {
                @Override
                public void run() {
                    if (mAlertDialog != null) mAlertDialog.dismiss();
                    goToHome();
                    stopSelf();
                }
            }, 60 * 1000);
        }
    }

    /**
     * Displays a notification that prompts the user to enable overlay permission.
     */
    private void notifyOverlayPermission() {
        NotificationManager notificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
        Intent permissionIntent = new Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION);
        permissionIntent.setData(Uri.parse("package:" + getPackageName()));
        PendingIntent pendingIntent = PendingIntent.getActivity(this, 0, permissionIntent, PendingIntent.FLAG_IMMUTABLE);
        String msg = getString(R.string.overlay_permission_denied_notification_info);
        notificationManager.notify(AppConstants.OVERLAY_SERVICE_NOTIFICATION_ID, new NotificationCompat.Builder(this, NotificationHelper.NOTIFICATION_CRITICAL_CHANNEL_ID)
                .setSmallIcon(R.drawable.ic_notification)
                .setAutoCancel(true)
                .setContentTitle(getString(R.string.overlay_permission_denied_notification_title))
                .setContentText(msg)
                .setContentIntent(pendingIntent)
                .setStyle(new NotificationCompat.BigTextStyle().bigText(msg))
                .build());
    }

    /**
     * Handles actions based on the button clicked in the overlay dialog.
     *
     * @param buttonType The type of button clicked in the overlay dialog.
     */
    private void onDialogButtonClick(DialogButtonType buttonType) {
        if (mAlertDialog != null) mAlertDialog.dismiss();

        if (buttonType == DialogButtonType.CloseApp) {
            goToHome();
        } else if (buttonType == DialogButtonType.Emergency) {
            Intent appIntent = new Intent(getBaseContext(), MainActivity.class);
            appIntent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            appIntent.setData(Uri.parse(appIntent.toUri(Intent.URI_INTENT_SCHEME)));
            appIntent.putExtra(INTENT_EXTRA_PACKAGE_NAME, mPackageName);
            startActivity(appIntent);
        }

        stopSelf();
    }

    /**
     * Navigates the user to the home screen.
     */
    private void goToHome() {
        try {
            new Handler(Looper.getMainLooper()).post(() -> {
                Intent intent = new Intent(Intent.ACTION_MAIN);
                intent.addCategory(Intent.CATEGORY_HOME);
                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                startActivity(intent);
            });
        } catch (Exception ignored) {
        }
    }

    /**
     * Retrieves the appropriate dialog information based on the DialogType.
     *
     * @return The message to display in the dialog.
     */
    @NonNull
    @Contract(pure = true)
    private String resolveDialogInfo() {
        switch (mPurgeDialogType) {
            case FocusSession:
                return getString(R.string.app_paused_dialog_info_for_focus_session);
            case BedtimeRoutine:
                return getString(R.string.app_paused_dialog_info_for_bedtime);
            case AppLaunchLimitOut:
                return getString(R.string.app_paused_dialog_info_for_launch_count_out);
            case AppTimerOut:
                return mProgress > 0 && mProgress < mMaxProgress ?
                        getString(R.string.app_paused_dialog_info_for_app_timer_left)
                        : getString(R.string.app_paused_dialog_info_for_app_timer_out);
            case GroupTimerOut:
                return mProgress > 0 && mProgress < mMaxProgress ?
                        getString(R.string.app_paused_dialog_info_for_group_timer_left, mGroupName)
                        : getString(R.string.app_paused_dialog_info_for_group_timer_out, mGroupName);
        }
        return getString(R.string.app_paused_dialog_info_for_app_timer_out);
    }


    @Override
    public void onDestroy() {
        super.onDestroy();
        if (mAutoCloseTimer != null) {
            mAutoCloseTimer.cancel();
            mAutoCloseTimer = null;
        }
        Log.d(TAG, "onDestroy: Overlay dialog service destroyed successfully");
    }

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }
}
