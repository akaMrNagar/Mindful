package com.akamrnagar.mindful.services;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.Service;
import android.app.usage.UsageStatsManager;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.SharedPreferences;
import android.os.Build;
import android.os.IBinder;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;
import androidx.core.app.NotificationCompat;

import com.akamrnagar.mindful.helpers.ScreenUsageHelper;
import com.akamrnagar.mindful.utils.AppConstants;
import com.akamrnagar.mindful.utils.Utils;

import java.util.Calendar;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Objects;
import java.util.Timer;
import java.util.TimerTask;

public class MindfulAppsTrackerService extends Service {
    private LockUnlockReceiver lockUnlockReceiver;

    public MindfulAppsTrackerService() {
    }

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP_MR1)
    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        SharedPreferences preferences = getSharedPreferences(AppConstants.PREFS_FLUTTER, Context.MODE_PRIVATE);
        String jsonString = preferences.getString(AppConstants.PREF_APP_TIMERS, "");

        if (!jsonString.isEmpty()) {
            HashMap<String, Long> appTimers = Utils.deserializeMap(jsonString);

            if (!appTimers.isEmpty()) {
                // Register receiver for screen lock/unlock events
                lockUnlockReceiver = new LockUnlockReceiver(appTimers, getApplicationContext());
                IntentFilter filter = new IntentFilter();
                filter.addAction(Intent.ACTION_USER_PRESENT);
                filter.addAction(Intent.ACTION_SCREEN_OFF);
                getApplicationContext().registerReceiver(lockUnlockReceiver, filter);

                // start foreground service and create notification
                startForeGround();
                return START_STICKY;
            }
        }

        stopSelf();
        return super.onStartCommand(intent, flags, startId);
    }

    @Override
    public void onDestroy() {
        Log.e(AppConstants.LOG_TAG, "OnDestroy() called");
        if (lockUnlockReceiver != null) {
            lockUnlockReceiver.onDestroy();
            getApplicationContext().unregisterReceiver(lockUnlockReceiver);
        }
        super.onDestroy();
    }

    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    private void startForeGround() {
        // creating notification
        String CHANNEL_ID = "Service Channel";
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            NotificationChannel channel = new NotificationChannel(CHANNEL_ID, CHANNEL_ID, NotificationManager.IMPORTANCE_LOW);
            getSystemService(NotificationManager.class).createNotificationChannel(channel);
            Notification.Builder notification = new Notification.Builder(this, CHANNEL_ID).setContentTitle("Focus Lock").setContentText("Background service is running");

            startForeground(0003, notification.build());
        } else {
            NotificationCompat.Builder notification = new NotificationCompat.Builder(this, CHANNEL_ID).setContentTitle("Focus Lock").setContentText("Background service is running").setAutoCancel(true);

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                notification.setPriority(NotificationManager.IMPORTANCE_LOW);
            }
            startForeground(003, notification.build());
        }
    }

    private static class LockUnlockReceiver extends BroadcastReceiver {

        private final Context context;
        private final UsageStatsManager usageStatsManager;

        // Map of app having timer and their time limit in seconds
        private final HashMap<String, Long> appsTimerMap;
        private long todayMidnightTimeMs;
        private Timer refreshTimer = new Timer();
        private Timer appTrackerTimer = new Timer();

        // List of apps whose screen time exceeded the limit and they need to be locked
        private HashSet<String> purgedApps = new HashSet<>(1);


        @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP_MR1)
        public LockUnlockReceiver(@NonNull HashMap<String, Long> appsTimer, @NonNull Context context) {
            this.appsTimerMap = appsTimer;
            this.context = context;
            usageStatsManager = (UsageStatsManager) context.getSystemService(Context.USAGE_STATS_SERVICE);
            onDeviceUnlocked();
        }


        @Override
        public void onReceive(Context context, @NonNull Intent intent) {
            if (Objects.equals(intent.getAction(), Intent.ACTION_SCREEN_OFF)) {
                Log.e(AppConstants.LOG_TAG, "User locked the device and screen is off");
                onDeviceLocked();

            } else if (Objects.equals(intent.getAction(), Intent.ACTION_USER_PRESENT)) {
                Log.e(AppConstants.LOG_TAG, "User unlocked the device");
                onDeviceUnlocked();
            }
        }


        // will be called when the user unlocks the device
        private void onDeviceUnlocked() {
            refreshTimer = new Timer();
            appTrackerTimer = new Timer();


            Calendar cal = Calendar.getInstance();
            cal.set(Calendar.HOUR_OF_DAY, 0);
            cal.set(Calendar.MINUTE, 0);
            cal.set(Calendar.SECOND, 0);
            todayMidnightTimeMs = cal.getTimeInMillis();

            // Repeated timer for every 5 minutes
            refreshTimer.scheduleAtFixedRate(new TimerTask() {
                ///TODO: Change the period of timer to 1 minute instead of 5 seconds before release build
                @Override
                public void run() {
                    everyFiveMinuteTask();
                }
            }, 0, 5 * 1000);

            // Repeated timer for every second to track opened app
            appTrackerTimer.scheduleAtFixedRate(new TimerTask() {
                @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP_MR1)
                @Override
                public void run() {
                    everySecondTask();
                }
            }, 0, 1000);
        }


        // will be called when the user locks the device
        private void onDeviceLocked() {
            // release resources held by service
            if (refreshTimer != null) {
                refreshTimer.purge();
                refreshTimer.cancel();
                refreshTimer = null;
            }

            if (appTrackerTimer != null) {
                appTrackerTimer.purge();
                appTrackerTimer.cancel();
                appTrackerTimer = null;
            }

        }

        private void onDestroy() {
            // purge and cancel all timer tasks
            onDeviceLocked();

        }

        // Repeated timer for every 5 minutes
        private void everyFiveMinuteTask() {
            Log.v(AppConstants.LOG_TAG, "...................................................... refreshing purged apps list");

            /// Map of package and their screen time in seconds
            Map<String, Long> usageTodayTillNow = ScreenUsageHelper.generateUsageTodayTillNow(usageStatsManager, todayMidnightTimeMs, appsTimerMap.keySet());


            for (Map.Entry<String, Long> entry : usageTodayTillNow.entrySet()) {
                if (appsTimerMap.containsKey(entry.getKey())) {
                    long limit = appsTimerMap.getOrDefault(entry.getKey(), 0L);
                    long usedTime = entry.getValue();

                    if (usedTime > limit) {
                        /// screen time exceeded the limit so it needs to be purged
                        if (!purgedApps.contains(entry.getKey())) {
                            Log.v(AppConstants.LOG_TAG, "App exceeded the time limit: " + entry.getKey() + "time: " + usedTime / 60000);
                            purgedApps.add(entry.getKey());
                            if (Objects.equals(ScreenUsageHelper.getLastActiveApp(usageStatsManager, 3 * 60 * 60), entry.getKey())) {
                                openTLEDialog(entry.getKey());
                            }
                        }
                    }
                }
            }
        }


        int counter = 0;

        // Repeated timer for every second to track opened app
        private void everySecondTask() {
            if (purgedApps.isEmpty()) return;
            Log.e(AppConstants.LOG_TAG, "iteration: " + (counter++));

            String currentlyActiveApp = ScreenUsageHelper.getLastActiveApp(usageStatsManager, 1);
            if (purgedApps.contains(currentlyActiveApp)) {
                Log.e(AppConstants.LOG_TAG, "...........................Purged app " + currentlyActiveApp + " is opened ............................................");
                openTLEDialog(currentlyActiveApp);
            }
        }

        private void openTLEDialog(String appPackage) {
            if (!Utils.isServiceRunning(context, OverlayDialogService.class.getName())) {
                Intent intent = new Intent(context, OverlayDialogService.class);
                intent.putExtra("appPackage", appPackage);
                context.startService(intent);
            }
        }
    }
}