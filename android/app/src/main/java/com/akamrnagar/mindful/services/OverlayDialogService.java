package com.akamrnagar.mindful.services;


import static com.akamrnagar.mindful.utils.AppConstants.BEDTIME_APP_PAUSE_MESSAGE;
import static com.akamrnagar.mindful.utils.AppConstants.INTENT_EXTRA_IS_THIS_BEDTIME;
import static com.akamrnagar.mindful.utils.AppConstants.INTENT_EXTRA_PACKAGE_NAME;
import static com.akamrnagar.mindful.utils.AppConstants.TIMER_APP_PAUSE_MESSAGE;

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

import com.akamrnagar.mindful.MainActivity;
import com.akamrnagar.mindful.R;
import com.akamrnagar.mindful.helpers.NotificationHelper;

/**
 * Display a dialog informing user about the app whose timer ran out.
 */
public class OverlayDialogService extends Service {

    private static final String TAG = "Mindful.OverlayDialogService";
    private static final int SERVICE_ID = 303;

    private String mPackageName;
    private boolean mIsThisBedtime = false;

    @Override
    public int onStartCommand(@NonNull Intent intent, int flags, int startId) {
        mPackageName = intent.getStringExtra(INTENT_EXTRA_PACKAGE_NAME);
        mIsThisBedtime = intent.getBooleanExtra(INTENT_EXTRA_IS_THIS_BEDTIME, false);

        if (mPackageName == null) {
            stopSelf();
            return START_NOT_STICKY;
        }


        if (!Settings.canDrawOverlays(this)) {
            NotificationManager notificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
            Intent permissionIntent = new Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION);
            permissionIntent.setData(android.net.Uri.parse("package:" + getPackageName()));
            PendingIntent pendingIntent = PendingIntent.getActivity(this, 0, permissionIntent, PendingIntent.FLAG_IMMUTABLE);
            String msg = "Please grant display overlay permission to Mindful by clicking on the notification. On the next screen, find Mindful in the list of apps and click on allow.";
            notificationManager.notify(
                    SERVICE_ID,
                    new NotificationCompat.Builder(this, NotificationHelper.NOTIFICATION_IMPORTANT_CHANNEL_ID)
                            .setSmallIcon(R.mipmap.ic_launcher)
                            .setAutoCancel(true)
                            .setContentTitle("Permission denied")
                            .setContentText(msg)
                            .setContentIntent(pendingIntent)
                            .setStyle(new NotificationCompat.BigTextStyle().bigText(msg))
                            .build()
            );
            Log.d(TAG, "onStartCommand: Display over other apps permission not allowed");
            stopSelf();
            return START_NOT_STICKY;
        }


        try {
            showAlertDialog();
        } catch (Exception e) {
            Log.e(TAG, "onStartCommand: Error starting overlay dialog service for app: " + mPackageName, e);
            stopSelf();
        }


        Log.d(TAG, "onStartCommand: Started overlay dialog service");
        return START_STICKY;
    }

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

    private AlertDialog createDialog() throws PackageManager.NameNotFoundException {
        PackageManager packageManager = getPackageManager();
        ApplicationInfo info = packageManager.getApplicationInfo(mPackageName, PackageManager.GET_META_DATA);

        String appName = info.loadLabel(packageManager).toString();
        Drawable icon = packageManager.getApplicationIcon(info);


        // FIXME : Fix deprecated warnings
        int sysTheme = AlertDialog.THEME_DEVICE_DEFAULT_DARK;
        if ((getResources().getConfiguration().uiMode & Configuration.UI_MODE_NIGHT_MASK) == Configuration.UI_MODE_NIGHT_NO) {
            sysTheme = AlertDialog.THEME_DEVICE_DEFAULT_LIGHT;
        }

        return new AlertDialog.Builder(this, sysTheme)
                .setTitle(appName)
                .setMessage(mIsThisBedtime ? BEDTIME_APP_PAUSE_MESSAGE : TIMER_APP_PAUSE_MESSAGE)
                .setIcon(icon)
                .setCancelable(false)
                .setNegativeButton("Emergency", this::onClickEmergency)
                .setPositiveButton("Close", this::onClickClose)
                .setOnDismissListener(this::onDialogDismiss)
                .create();
    }

    private void onClickEmergency(DialogInterface dialog, int which) {
        Intent appIntent = new Intent(getBaseContext(), MainActivity.class);
        appIntent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        appIntent.setData(Uri.parse(appIntent.toUri(Intent.URI_INTENT_SCHEME)));
        appIntent.putExtra("appPackage", mPackageName);
        startActivity(appIntent);
    }

    private void onClickClose(DialogInterface dialog, int which) {
        goToHome();
    }

    private void goToHome() {
        Intent intent = new Intent(Intent.ACTION_MAIN);
        intent.addCategory(Intent.CATEGORY_HOME);
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        startActivity(intent);
    }

    public void onDialogDismiss(DialogInterface dialog) {
        stopSelf();
    }


    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }
}
