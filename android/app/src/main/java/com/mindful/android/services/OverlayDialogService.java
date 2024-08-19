package com.mindful.android.services;

import static com.mindful.android.utils.AppConstants.BEDTIME_APP_PAUSE_MESSAGE;
import static com.mindful.android.utils.AppConstants.FOCUS_SESSION_APP_PAUSE_MESSAGE;
import static com.mindful.android.utils.AppConstants.TIMER_APP_PAUSE_MESSAGE;

import android.app.AlertDialog;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Service;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.content.res.Configuration;
import android.graphics.drawable.Drawable;
import android.net.Uri;
import android.os.Build;
import android.os.IBinder;
import android.provider.Settings;
import android.util.Log;
import android.view.WindowManager;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.app.NotificationCompat;

import com.mindful.android.MainActivity;
import com.mindful.android.R;
import com.mindful.android.enums.DialogType;
import com.mindful.android.helpers.NotificationHelper;
import com.mindful.android.utils.AppConstants;

/**
 * Service that displays an overlay dialog informing the user about the app whose timer ran out.
 */
public class OverlayDialogService extends Service {

    private static final String TAG = "Mindful.OverlayDialogService";
    public static final String INTENT_EXTRA_PACKAGE_NAME = "launchedAppPackageName";
    public static final String INTENT_EXTRA_DIALOG_TYPE = "overlayDialogType";

    private String mPackageName;
    private DialogType mDialogType = DialogType.TimerOut;

    @Override
    public int onStartCommand(@NonNull Intent intent, int flags, int startId) {
        mPackageName = intent.getStringExtra(INTENT_EXTRA_PACKAGE_NAME);
        mDialogType = DialogType.fromInteger(intent.getIntExtra(INTENT_EXTRA_DIALOG_TYPE, mDialogType.toInteger()));

        if (mPackageName == null) {
            stopSelf();
            return START_NOT_STICKY;
        }

        // Check if the app has permission to draw overlays
        if (!Settings.canDrawOverlays(this)) {
            notifyOverlayPermission();
            Log.d(TAG, "onStartCommand: Display over other apps permission not allowed");
            stopSelf();
            return START_NOT_STICKY;
        }

        // Show the overlay dialog
        try {
            showAlertDialog();
        } catch (Exception e) {
            Log.e(TAG, "onStartCommand: Error starting overlay dialog service for app: " + mPackageName, e);
            stopSelf();
        }

        Log.d(TAG, "onStartCommand: Started overlay dialog service");
        return START_STICKY;
    }

    /**
     * Displays a notification prompting the user to grant overlay permission.
     */
    private void notifyOverlayPermission() {
        NotificationManager notificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
        Intent permissionIntent = new Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION);
        permissionIntent.setData(Uri.parse("package:" + getPackageName()));
        PendingIntent pendingIntent = PendingIntent.getActivity(this, 0, permissionIntent, PendingIntent.FLAG_IMMUTABLE);
        String msg = "Please grant display overlay permission to Mindful by clicking on the notification. On the next screen, find Mindful in the list of apps and click on allow.";
        notificationManager.notify(
                AppConstants.OVERLAY_SERVICE_NOTIFICATION_ID,
                new NotificationCompat.Builder(this, NotificationHelper.NOTIFICATION_CRITICAL_CHANNEL_ID)
                        .setSmallIcon(R.drawable.ic_notification)
                        .setAutoCancel(true)
                        .setContentTitle("Permission denied")
                        .setContentText(msg)
                        .setContentIntent(pendingIntent)
                        .setStyle(new NotificationCompat.BigTextStyle().bigText(msg))
                        .build()
        );
    }

    /**
     * Shows an alert dialog with information about the app whose timer has expired.
     *
     * @throws PackageManager.NameNotFoundException if the app with the specified package name is not found.
     */
    private void showAlertDialog() throws PackageManager.NameNotFoundException {
        AlertDialog alertDialog = createDialog();
        if (alertDialog.getWindow() == null) return;

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            alertDialog.getWindow().setType(WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY);
        } else {
            alertDialog.getWindow().setType(WindowManager.LayoutParams.TYPE_PHONE);
        }

        // Close app and go to home page
        goToHome();
        alertDialog.show();
    }

    /**
     * Creates an alert dialog with the app's name and icon, and custom messages.
     *
     * @return The created AlertDialog.
     * @throws PackageManager.NameNotFoundException if the app with the specified package name is not found.
     */
    private AlertDialog createDialog() throws PackageManager.NameNotFoundException {
        PackageManager packageManager = getPackageManager();
        ApplicationInfo info = packageManager.getApplicationInfo(mPackageName, PackageManager.GET_META_DATA);

        String appName = info.loadLabel(packageManager).toString();
        Drawable icon = packageManager.getApplicationIcon(info);

        // Determine the dialog theme based on system UI mode
        int sysTheme = AlertDialog.THEME_DEVICE_DEFAULT_DARK;
        if ((getResources().getConfiguration().uiMode & Configuration.UI_MODE_NIGHT_MASK) == Configuration.UI_MODE_NIGHT_NO) {
            sysTheme = AlertDialog.THEME_DEVICE_DEFAULT_LIGHT;
        }

        String dialogMsg = TIMER_APP_PAUSE_MESSAGE;
        switch (mDialogType) {
            case TimerOut:
                dialogMsg = TIMER_APP_PAUSE_MESSAGE;
                break;
            case FocusSession:
                dialogMsg = FOCUS_SESSION_APP_PAUSE_MESSAGE;
                break;
            case BedtimeRoutine:
                dialogMsg = BEDTIME_APP_PAUSE_MESSAGE;
                break;
        }

        return new AlertDialog.Builder(this, sysTheme)
                .setTitle(appName)
                .setMessage(dialogMsg)
                .setIcon(icon)
                .setCancelable(false)
                .setNegativeButton("Emergency", this::onClickEmergency)
                .setPositiveButton("Close", this::onClickClose)
                .setOnDismissListener(this::onDialogDismiss)
                .create();
    }

    /**
     * Handles the "Emergency" button click by opening the MainActivity with the app's package name.
     *
     * @param dialog The dialog where the button was clicked.
     * @param which  The button that was clicked.
     */
    private void onClickEmergency(DialogInterface dialog, int which) {
        Intent appIntent = new Intent(getBaseContext(), MainActivity.class);
        appIntent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        appIntent.setData(Uri.parse(appIntent.toUri(Intent.URI_INTENT_SCHEME)));
        appIntent.putExtra("appPackage", mPackageName);
        startActivity(appIntent);
    }

    /**
     * Handles the "Close" button click by sending the user to the home screen.
     *
     * @param dialog The dialog where the button was clicked.
     * @param which  The button that was clicked.
     */
    private void onClickClose(DialogInterface dialog, int which) {
        goToHome();
    }

    /**
     * Navigates to the home screen.
     */
    private void goToHome() {
        Intent intent = new Intent(Intent.ACTION_MAIN);
        intent.addCategory(Intent.CATEGORY_HOME);
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        startActivity(intent);
    }

    /**
     * Stops the service when the dialog is dismissed.
     *
     * @param dialog The dialog that was dismissed.
     */
    public void onDialogDismiss(DialogInterface dialog) {
        stopSelf();
    }

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }
}
