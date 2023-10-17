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

/**
 * This service tracks the usage of apps installed on user device and enforces usage limits.
 */
public class MindfulAppsTrackerService extends Service {
    private LockUnlockReceiver lockUnlockReceiver;

    public MindfulAppsTrackerService() {
    }

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP_MR1)
    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {

        /// Load app timers map from shared prefs
        SharedPreferences preferences = getSharedPreferences(AppConstants.PREFS_FLUTTER_PREFIX, Context.MODE_PRIVATE);
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
        Log.d(AppConstants.DEBUG_TAG, "OnDestroy() called");
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


    //TODO: Probably move the notification builder to somewhere else

    /**
     * Start foreground service and creates notification
     */
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
        private Timer everySecondTimer = new Timer();
        private Timer everyMinuteTimer = new Timer();
        private long todayMidnightTimeMs;

        /**
         * Map of app package and their timer in seconds set by the user
         */
        private final HashMap<String, Long> appsTimerMap;


        /**
         * List of app packages whose timer ran out or whose screen time exceeded the daily limit
         */
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
                Log.d(AppConstants.DEBUG_TAG, "User locked the device and screen is off");
                onDeviceLocked();

            } else if (Objects.equals(intent.getAction(), Intent.ACTION_USER_PRESENT)) {
                Log.d(AppConstants.DEBUG_TAG, "User unlocked the device");
                onDeviceUnlocked();
            }
        }


        /**
         * This method is called everytime the device is unlocked
         */
        private void onDeviceUnlocked() {
            everyMinuteTimer = new Timer();
            everySecondTimer = new Timer();


            Calendar cal = Calendar.getInstance();
            cal.set(Calendar.HOUR_OF_DAY, 0);
            cal.set(Calendar.MINUTE, 0);
            cal.set(Calendar.SECOND, 0);
            todayMidnightTimeMs = cal.getTimeInMillis();

            everyMinuteTimer.scheduleAtFixedRate(new TimerTask() {
                ///TODO: Change the period of timer to 1 minute instead of 5 seconds before release build
                @Override
                public void run() {
                    everyMinuteTask();
                }
            }, 0, 5 * 1000);

            everySecondTimer.scheduleAtFixedRate(new TimerTask() {
                @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP_MR1)
                @Override
                public void run() {
                    everySecondTask();
                }
            }, 0, 1000);
        }


        /**
         * This method is called everytime the device is locked or screen is turned off
         */
        private void onDeviceLocked() {
            // release resources held by service
            if (everyMinuteTimer != null) {
                everyMinuteTimer.purge();
                everyMinuteTimer.cancel();
                everyMinuteTimer = null;
            }

            if (everySecondTimer != null) {
                everySecondTimer.purge();
                everySecondTimer.cancel();
                everySecondTimer = null;
            }

        }

        /**
         * Manually created onDestroy() method to release resources because no override found in BroadcastReceiver class
         */
        private void onDestroy() {
            // purge and cancel all timer tasks
            onDeviceLocked();

        }

        /**
         * This method will be called every minute and it is responsible for adding apps to purged list,
         * when their screen time exceeds the daily timer. It also takes care if the app is running now.
         */
        private void everyMinuteTask() {
            Log.d(AppConstants.DEBUG_TAG, "...................................................... refreshing purged apps list");

            /// Map of package and their screen time in seconds
            Map<String, Long> usageTodayTillNow = ScreenUsageHelper.generateUsageTodayTillNow(usageStatsManager, todayMidnightTimeMs, appsTimerMap.keySet());


            for (Map.Entry<String, Long> entry : usageTodayTillNow.entrySet()) {
                if (appsTimerMap.containsKey(entry.getKey())) {
                    long limit = appsTimerMap.getOrDefault(entry.getKey(), 0L);
                    long usedTime = entry.getValue();

                    if (usedTime > limit) {
                        /// screen time exceeded the limit so it needs to be purged
                        if (!purgedApps.contains(entry.getKey())) {
                            Log.d(AppConstants.DEBUG_TAG, "App exceeded the time limit: " + entry.getKey());
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

        /**
         * This method is called every second to track if the user launched a app.
         * If the purged list contains that app then the user is forwarded to home screen and TLE dialog is displayed.
         */
        private void everySecondTask() {
            if (purgedApps.isEmpty()) return;
            Log.d(AppConstants.DEBUG_TAG, "iteration: " + (counter++));

            String currentlyActiveApp = ScreenUsageHelper.getLastActiveApp(usageStatsManager, 1);
            if (purgedApps.contains(currentlyActiveApp)) {
                Log.d(AppConstants.DEBUG_TAG, "...........................Purged app " + currentlyActiveApp + " is opened ............................................");
                openTLEDialog(currentlyActiveApp);
            }
        }

        /**
         * Responsible for starting overlay dialog service which display a dialog for motivation and information, if it is already not running.
         *
         * @param appPackage The package of the app whose timer ran out or Time Limit Exceeded
         */
        private void openTLEDialog(String appPackage) {
            if (!Utils.isServiceRunning(context, OverlayDialogService.class.getName())) {
                Intent intent = new Intent(context, OverlayDialogService.class);
                intent.putExtra("appPackage", appPackage);
                context.startService(intent);
            }
        }
    }
}