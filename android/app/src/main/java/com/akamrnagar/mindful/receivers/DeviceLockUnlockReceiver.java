package com.akamrnagar.mindful.receivers;

import static com.akamrnagar.mindful.services.MindfulTrackerService.ACTION_APP_LAUNCHED;
import static com.akamrnagar.mindful.utils.AppConstants.INTENT_EXTRA_PACKAGE_NAME;

import android.app.usage.UsageEvents;
import android.app.usage.UsageStatsManager;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

import androidx.annotation.NonNull;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Timer;
import java.util.TimerTask;

public class DeviceLockUnlockReceiver extends BroadcastReceiver {
    private final String TAG = "Mindful.DeviceLockUnlockReceiver";
    private static final long mTimerRate = 500;
    private final Context mContext;
    private final UsageStatsManager mUsageStatsManager;
    private Timer mAppLaunchTrackingTimer;
    private List<String> mActiveAppsList = new ArrayList<>(3);
    private String mLastLaunchedAppPackage = "";
    private boolean mIsTrackingPaused = false;


    public DeviceLockUnlockReceiver(Context context) {
        mContext = context;
        mUsageStatsManager = (UsageStatsManager) mContext.getSystemService(Context.USAGE_STATS_SERVICE);
        onDeviceUnlocked();
    }

    @Override
    public void onReceive(Context context, @NonNull Intent intent) {
        if (intent.getAction() != null && Intent.ACTION_USER_PRESENT.equals(intent.getAction())) {
            onDeviceUnlocked();
            Log.d(TAG, "onDeviceUnLocked: User UNLOCKED the device and device is ACTIVE");
        } else if (Objects.equals(intent.getAction(), Intent.ACTION_SCREEN_OFF)) {
            onDeviceLocked();
            Log.d(TAG, "onDeviceLocked: User LOCKED the device and device is INACTIVE");
        }
    }


    private void onDeviceUnlocked() {
        if (mAppLaunchTrackingTimer == null) {
            mAppLaunchTrackingTimer = new Timer();
            mAppLaunchTrackingTimer.schedule(new TimerTask() {
                @Override
                public void run() {
                    onAppLaunchTrackingTimerRun();
                }
            }, 0, mTimerRate);
        }

        Log.d(TAG, "onDeviceUnLocked: Repeated task scheduled for tracking new app launches.");
        broadcastLastAppLaunchEvent();
    }

    private void onDeviceLocked() {

        if (mAppLaunchTrackingTimer != null) {
            mAppLaunchTrackingTimer.purge();
            mAppLaunchTrackingTimer.cancel();
            mAppLaunchTrackingTimer = null;
        }
        Log.d(TAG, "onDeviceLocked: App launch tracking task cancelled.");
    }


    private void onAppLaunchTrackingTimerRun() {
        long now = System.currentTimeMillis();
        UsageEvents usageEvents = mUsageStatsManager.queryEvents(now - mTimerRate, now);

        while (usageEvents.hasNextEvent()) {
            UsageEvents.Event currentEvent = new UsageEvents.Event();
            usageEvents.getNextEvent(currentEvent);

            int eventType = currentEvent.getEventType();
            String packageName = currentEvent.getPackageName();

            if (eventType == UsageEvents.Event.ACTIVITY_RESUMED && !mActiveAppsList.contains(packageName)) {
                mActiveAppsList.add(packageName);
            } else if (eventType == UsageEvents.Event.ACTIVITY_PAUSED || eventType == UsageEvents.Event.ACTIVITY_STOPPED) {
                mActiveAppsList.remove(packageName);
            }
        }


        if (!mActiveAppsList.isEmpty() && !mLastLaunchedAppPackage.equals(mActiveAppsList.get(0))) {
            mLastLaunchedAppPackage = mActiveAppsList.get(0);
            broadcastLastAppLaunchEvent();
        }
    }


    /**
     * Broadcast an event of type ACTION_APP_LAUNCHED with the last launched app
     * package
     */
    public void broadcastLastAppLaunchEvent() {
        if (mLastLaunchedAppPackage.isEmpty() || mIsTrackingPaused) return;

        // Broadcast event
        Intent eventIntent = new Intent();
        eventIntent.setAction(ACTION_APP_LAUNCHED);
        eventIntent.setPackage(mContext.getPackageName());
        eventIntent.putExtra(INTENT_EXTRA_PACKAGE_NAME, mLastLaunchedAppPackage);
        mContext.sendBroadcast(eventIntent);
    }

    public void pauseResumeTracking(boolean shouldPause) {
        mIsTrackingPaused = shouldPause;
        if(!shouldPause) broadcastLastAppLaunchEvent();
    }


    public void dispose() {
        onDeviceLocked();
    }
}
