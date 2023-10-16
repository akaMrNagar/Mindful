package com.akamrnagar.mindful.services;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.Service;
import android.app.usage.UsageEvents;
import android.app.usage.UsageStatsManager;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Build;
import android.os.IBinder;

import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;
import androidx.core.app.NotificationCompat;

import com.akamrnagar.mindful.utils.AppConstants;

import java.util.ArrayList;
import java.util.Timer;
import java.util.TimerTask;

import io.flutter.Log;

public class AppLaunchTrackerService extends Service {
    private Timer timer = new Timer();
    private final long appCheckTimeRateMs = 1000; // = every 1 second

    private ArrayList<String> lockedApps = new ArrayList<>();
    private UsageStatsManager usageStatsManager;
    private int counter = 0;

    public int onStartCommand(Intent intent, int flags, int startId) {
        Log.e(AppConstants.LOG_TAG, "Service is started");

        // Do your initialization work here
        lockedApps.addAll(intent.getExtras().getStringArrayList("lockedApps"));

//        IntentFilter filter = new IntentFilter();
//        receiver = new UnlockReceiver();
//        filter.addAction(Intent.ACTION_USER_PRESENT);
//        getApplicationContext().registerReceiver(receiver,filter);

        for (String s : lockedApps) {
            Log.e(AppConstants.LOG_TAG, s);
        }

        //calls every second
        timer.scheduleAtFixedRate(new TimerTask() {
            @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP_MR1)
            @Override
            public void run() {
                startEverySecondTask();
            }
        }, appCheckTimeRateMs, appCheckTimeRateMs);


        // creating notification
        String CHANNEL_ID = "Service Channel";
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            NotificationChannel channel = new NotificationChannel(CHANNEL_ID, CHANNEL_ID, NotificationManager.IMPORTANCE_LOW);
            getSystemService(NotificationManager.class).createNotificationChannel(channel);
            Notification.Builder notification = new Notification.Builder(this, CHANNEL_ID)
                    .setContentTitle("Focus Lock")
                    .setContentText("Background service is running");

            startForeground(333, notification.build());
        } else {
            NotificationCompat.Builder notification = new NotificationCompat.Builder(this, CHANNEL_ID)
                    .setContentTitle("Focus Lock")
                    .setContentText("Background service is running")
                    .setAutoCancel(true);

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                notification.setPriority(NotificationManager.IMPORTANCE_LOW);
            }
            startForeground(333, notification.build());
        }

        return START_STICKY;
    }

    @Override
    public void onDestroy() {
        timer.cancel();
        timer.purge();
//        getApplicationContext().unregisterReceiver(receiver);
        Log.e(AppConstants.LOG_TAG, "Service is stopped");
        super.onDestroy();
    }

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP_MR1)
    private void startEverySecondTask() {
        Log.e(AppConstants.LOG_TAG, "Service is running: " + counter);
        counter++;

        if (usageStatsManager == null) {
            usageStatsManager = (UsageStatsManager) getApplicationContext().getSystemService(Context.USAGE_STATS_SERVICE);
        }

        UsageEvents usageEvents = usageStatsManager.queryEvents(System.currentTimeMillis() - (1000), System.currentTimeMillis());

        while (usageEvents.hasNextEvent()) {
            UsageEvents.Event currentEvent = new UsageEvents.Event();
            usageEvents.getNextEvent(currentEvent);

            if (currentEvent.getEventType() == UsageEvents.Event.ACTIVITY_RESUMED) {
                if (lockedApps.contains(currentEvent.getPackageName())) {
//                    ServicesManager.getInstance().startLockedOverlayService();
                    Log.e(AppConstants.LOG_TAG, "The opened app is locked and it package name is : " + currentEvent.getPackageName());
                }
            }
        }

    }
}
