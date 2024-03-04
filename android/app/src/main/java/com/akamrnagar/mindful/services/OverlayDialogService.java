package com.akamrnagar.mindful.services;

import android.app.AlertDialog;
import android.app.Service;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.content.res.Configuration;
import android.graphics.drawable.Drawable;
import android.net.Uri;
import android.os.Handler;
import android.os.IBinder;
import android.os.Looper;
import android.view.WindowManager;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.akamrnagar.mindful.MainActivity;

/**
 * Display a dialog informing user about the app whose timer ran out.
 */
public class OverlayDialogService extends Service {

    public static final int SERVICE_ID = 303;
    public static final String ACTION_START_SERVICE = "com.akamrnagar.mindful.Overlay.START";
    public static final String ACTION_STOP_SERVICE = "com.akamrnagar.mindful.Overlay.STOP";


    @Override
    public int onStartCommand(@NonNull Intent intent, int flags, int startId) {
        String packageName = intent.getStringExtra("appPackage");
        if (packageName != null) {
            try {
                PackageManager packageManager = getPackageManager();
                ApplicationInfo info = packageManager.getApplicationInfo(packageName, PackageManager.GET_META_DATA);

                String appName = info.loadLabel(packageManager).toString();
                Drawable icon = packageManager.getApplicationIcon(info);


                // TODO: Fix deprecated warnings
                int sysTheme = AlertDialog.THEME_DEVICE_DEFAULT_DARK;
                if ((getResources().getConfiguration().uiMode & Configuration.UI_MODE_NIGHT_MASK) == Configuration.UI_MODE_NIGHT_NO) {
                    sysTheme = AlertDialog.THEME_DEVICE_DEFAULT_LIGHT;
                }


                AlertDialog alertDialog = new AlertDialog.Builder(this, sysTheme)
                        .setTitle("App Locked")
                        .setMessage(appName + " timer ran out.\nEmbrace this pause to supercharge your productivity.Stay focused, stay motivated.")
                        .setIcon(icon)
                        .setCancelable(false)
                        .setNeutralButton("Settings", new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialog, int which) {
                                Intent appIntent = new Intent(getApplicationContext(), MainActivity.class);
                                appIntent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                                appIntent.setData(Uri.parse(appIntent.toUri(Intent.URI_INTENT_SCHEME)));
                                appIntent.putExtra("route", "/external");
                                appIntent.putExtra("appPackage", packageName);

                                try {
                                    getApplicationContext().startActivity(appIntent);
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            }
                        })
                        .setPositiveButton("Ok", new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialog, int which) {
                            }
                        }).setOnDismissListener(new DialogInterface.OnDismissListener() {
                            @Override
                            public void onDismiss(DialogInterface dialog) {
                                stopSelf();
                            }
                        })
                        .create();

                new Handler(Looper.getMainLooper()).post(new Runnable() {
                    @Override
                    public void run() {
                        alertDialog.getWindow().setType(WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY);
                        alertDialog.show();

                        Intent intent = new Intent(Intent.ACTION_MAIN);
                        intent.addCategory(Intent.CATEGORY_HOME);
                        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                        startActivity(intent);
                    }
                });

            } catch (Exception e) {
                e.printStackTrace();
                stopSelf();
            }
        } else stopSelf();

        return super.onStartCommand(intent, flags, startId);
    }

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }
}
