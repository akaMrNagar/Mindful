package com.akamrnagar.mindful.services;

import static com.akamrnagar.mindful.receivers.DeviceLockUnlockReceiver.INTENT_EXTRA_PACKAGE_NAME;

import android.app.AlertDialog;
import android.app.Service;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.content.res.Configuration;
import android.graphics.drawable.Drawable;
import android.net.Uri;
import android.os.Build;
import android.os.Handler;
import android.os.IBinder;
import android.os.Looper;
import android.util.Log;
import android.view.WindowManager;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.akamrnagar.mindful.MainActivity;

import java.util.Objects;

/**
 * Display a dialog informing user about the app whose timer ran out.
 */
public class OverlayDialogService extends Service {

    public static final String TAG = "Mindful.OverlayDialogService";
    private static String packageName;

    @Override
    public int onStartCommand(@NonNull Intent intent, int flags, int startId) {
        packageName = intent.getStringExtra(INTENT_EXTRA_PACKAGE_NAME);
        Log.d(TAG, "onStartCommand: Started overlay dialog service");

        if (packageName == null) {
            stopSelf();
            return START_NOT_STICKY;
        }


        try {
            showAlertDialog();
        } catch (Exception e) {
            Log.e(TAG, "onStartCommand: Error starting overlay dialog service for app: " + packageName, e);
            stopSelf();
        }


        return START_STICKY;
    }

    private void showAlertDialog() throws PackageManager.NameNotFoundException {
        AlertDialog alertDialog = createDialog();
        new Handler(Looper.getMainLooper()).post(new Runnable() {
            @Override
            public void run() {

                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                    Objects.requireNonNull(alertDialog.getWindow()).setType(WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY);
                } else {
                    Objects.requireNonNull(alertDialog.getWindow()).setType(WindowManager.LayoutParams.TYPE_PHONE);
                }

                alertDialog.show();
                goToHome();
            }
        });

    }

    private AlertDialog createDialog() throws PackageManager.NameNotFoundException {
        PackageManager packageManager = getPackageManager();
        ApplicationInfo info = packageManager.getApplicationInfo(packageName, PackageManager.GET_META_DATA);

        String appName = info.loadLabel(packageManager).toString();
        Drawable icon = packageManager.getApplicationIcon(info);


        // FIXME : Fix deprecated warnings
        int sysTheme = AlertDialog.THEME_DEVICE_DEFAULT_DARK;
        if ((getResources().getConfiguration().uiMode & Configuration.UI_MODE_NIGHT_MASK) == Configuration.UI_MODE_NIGHT_NO) {
            sysTheme = AlertDialog.THEME_DEVICE_DEFAULT_LIGHT;
        }

        return new AlertDialog.Builder(this, sysTheme)
                .setTitle("App Locked")
                .setMessage(appName + "'s timer ran out.\n\nEmbrace this pause to supercharge your productivity. Stay mindful, stay focused.")
                .setIcon(icon)
                .setCancelable(false)
                .setNeutralButton("Settings", this::onClickSettings)
                .setPositiveButton("Ok", this::onClickOk)
                .setOnDismissListener(this::onDialogDismiss)
                .create();
    }

    private void onClickSettings(DialogInterface dialog, int which) {
        Intent appIntent = new Intent(getBaseContext(), MainActivity.class);
        appIntent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        appIntent.setData(Uri.parse(appIntent.toUri(Intent.URI_INTENT_SCHEME)));
        appIntent.putExtra("route", "/externalAppDashboard");
        appIntent.putExtra("appPackage", packageName);

        startActivity(appIntent);
    }

    private void onClickOk(DialogInterface dialog, int which) {
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
