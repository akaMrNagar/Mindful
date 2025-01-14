/*
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

package com.mindful.android.services;

import static com.mindful.android.generics.ServiceBinder.ACTION_START_MINDFUL_SERVICE;
import static com.mindful.android.utils.AppConstants.INTENT_EXTRA_DIALOG_INFO;
import static com.mindful.android.utils.AppConstants.INTENT_EXTRA_INITIAL_ROUTE;
import static com.mindful.android.utils.AppConstants.INTENT_EXTRA_MAX_PROGRESS;
import static com.mindful.android.utils.AppConstants.INTENT_EXTRA_PACKAGE_NAME;
import static com.mindful.android.utils.AppConstants.INTENT_EXTRA_PROGRESS;

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
import com.mindful.android.helpers.NotificationHelper;
import com.mindful.android.helpers.SharedPrefsHelper;
import com.mindful.android.utils.AppConstants;
import com.mindful.android.utils.Utils;

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

    // Instance variables
    private String mPackageName = "";
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
        String action = Utils.getActionFromIntent(intent);

        if (action.equals(ACTION_START_MINDFUL_SERVICE)) {
            new Handler(Looper.getMainLooper()).post(() -> {
                try {
                    showAlertDialog(intent);
                } catch (Exception e) {
                    Log.e(TAG, "onStartCommand: Failed to start OVERLAY service for app: " + mPackageName, e);
                    SharedPrefsHelper.insertCrashLogToPrefs(this, e);
                    stopSelf();
                }
            });
            return START_STICKY;
        }

        stopSelf();
        return START_NOT_STICKY;
    }


    /**
     * Creates and displays an alert dialog showing information about the app whose timer expired.
     *
     * @throws PackageManager.NameNotFoundException if the app with the specified package name is not found.
     */
    private void showAlertDialog(@NonNull Intent intent) throws Exception {
        mPackageName = intent.getStringExtra(INTENT_EXTRA_PACKAGE_NAME);
        String mDialogInfo = intent.getStringExtra(INTENT_EXTRA_DIALOG_INFO);
        int mMaxProgress = intent.getIntExtra(INTENT_EXTRA_MAX_PROGRESS, 0);
        int mProgress = intent.getIntExtra(INTENT_EXTRA_PROGRESS, 0);
        Log.d(TAG, "showAlertDialog: Showing dialog for package: " + mPackageName + " msg: " + mDialogInfo + " used: " + mProgress + " total: " + mMaxProgress);


        // Notify, stop and return if don't have overlay permission
        if (!Settings.canDrawOverlays(this)) {
            askOverlayPermissionByNotification();
            Log.d(TAG, "showAlertDialog: Display overlay permission denied, stopping service");
            stopSelf();
            return;
        }

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
        dialogInfoTxt.setText(mDialogInfo);

        // Progress info setup
        if (mProgress > 0 && mMaxProgress > 0) {
            ProgressBar progressBar = dialogView.findViewById(R.id.overlay_dialog_progress);
            progressBar.setVisibility(View.VISIBLE);
            progressBar.setMax(mMaxProgress);
            progressBar.setProgress(mProgress, true);

            TextView limitSpentTxt = dialogView.findViewById(R.id.overlay_dialog_limit_used);
            limitSpentTxt.setVisibility(View.VISIBLE);
            limitSpentTxt.setText(getString(R.string.app_paused_dialog_progress_spent, Utils.minutesToTimeStr(mProgress / 60)));

            TextView limitLeftTxt = dialogView.findViewById(R.id.overlay_dialog_limit_total);
            limitLeftTxt.setVisibility(View.VISIBLE);
            int leftLimit = Math.max(0, (mMaxProgress - mProgress));
            limitLeftTxt.setText(getString(R.string.app_paused_dialog_progress_left, Utils.minutesToTimeStr(leftLimit > 0 ? (leftLimit / 60) : 0)));

            // If limit is remaining
            if (mProgress < mMaxProgress) {
                Button useAnywayBtn = dialogView.findViewById(R.id.overlay_dialog_button_use_anyway);
                useAnywayBtn.setVisibility(View.VISIBLE);
                useAnywayBtn.setOnClickListener(v -> onDialogButtonClick(DialogButtonType.UseAnyway));
            }
        }

        // Emergency button setup
        if (mProgress >= mMaxProgress) {
            Button emergencyBtn = dialogView.findViewById(R.id.overlay_dialog_button_emergency);
            emergencyBtn.setVisibility(View.VISIBLE);
            emergencyBtn.setOnClickListener(v -> onDialogButtonClick(DialogButtonType.Emergency));
        }

        // Close app button setup
        Button closeAppBtn = dialogView.findViewById(R.id.overlay_dialog_button_close);
        closeAppBtn.setOnClickListener(v -> onDialogButtonClick(DialogButtonType.CloseApp));

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
        Log.d(TAG, "showAlertDialog: OVERLAY service started successfully");

        /// Schedule auto dialog close timer
        if (mAutoCloseTimer == null) {
            mAutoCloseTimer = new Timer();
            mAutoCloseTimer.schedule(new TimerTask() {
                @Override
                public void run() {
                    goToHome();
                    if (mAlertDialog != null) mAlertDialog.dismiss();
                    stopSelf();
                }
            }, 60 * 1000);
        }
    }

    /**
     * Displays a notification that prompts the user to enable overlay permission.
     */
    private void askOverlayPermissionByNotification() {
        NotificationManager notificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
        Intent permissionIntent = new Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION);
        permissionIntent.setData(Uri.parse("package:" + getPackageName()));
        PendingIntent pendingIntent = PendingIntent.getActivity(this.getApplicationContext(), 0, permissionIntent, PendingIntent.FLAG_IMMUTABLE);
        String msg = getString(R.string.overlay_permission_denied_notification_info);

        notificationManager.notify(
                AppConstants.OVERLAY_SERVICE_NOTIFICATION_ID,
                new NotificationCompat.Builder(this, NotificationHelper.NOTIFICATION_CRITICAL_CHANNEL_ID)
                        .setSmallIcon(R.drawable.ic_notification)
                        .setAutoCancel(true)
                        .setContentTitle(getString(R.string.overlay_permission_denied_notification_title))
                        .setContentText(msg)
                        .setContentIntent(pendingIntent)
                        .setStyle(new NotificationCompat.BigTextStyle().bigText(msg))
                        .build()
        );
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
            Intent appIntent = new Intent(getApplicationContext(), MainActivity.class);
            appIntent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            appIntent.setData(Uri.parse(appIntent.toUri(Intent.URI_INTENT_SCHEME)));
            appIntent.putExtra(INTENT_EXTRA_PACKAGE_NAME, mPackageName);
            appIntent.putExtra(INTENT_EXTRA_INITIAL_ROUTE, "/appDashboardScreen");
            startActivity(appIntent);
        }

        stopSelf();
    }

    /**
     * Navigates the user to the home screen.
     */
    private void goToHome() {
        try {
            Intent intent = new Intent(Intent.ACTION_MAIN);
            intent.addCategory(Intent.CATEGORY_HOME);
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            startActivity(intent);
        } catch (Exception ignored) {
        }
    }


    @Override
    public void onDestroy() {
        super.onDestroy();
        if (mAutoCloseTimer != null) {
            mAutoCloseTimer.cancel();
            mAutoCloseTimer = null;
        }
        Log.d(TAG, "onDestroy: OVERLAY service destroyed successfully");
    }

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }
}
