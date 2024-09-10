/*
 *
 *  * Copyright (c) 2024 Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

package com.mindful.android.receivers;

import static com.mindful.android.services.MindfulTrackerService.ACTION_NEW_APP_LAUNCHED;
import static com.mindful.android.services.OverlayDialogService.INTENT_EXTRA_PACKAGE_NAME;

import android.app.usage.UsageEvents;
import android.app.usage.UsageStatsManager;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

import androidx.annotation.NonNull;

import com.mindful.android.generics.SuccessCallback;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Timer;
import java.util.TimerTask;

/**
 * BroadcastReceiver that monitors device lock/unlock events and tracks app launches while the device is unlocked.
 */
public class DeviceLockUnlockReceiver extends BroadcastReceiver {
    private final String TAG = "Mindful.DeviceLockUnlockReceiver";
    private static final long TIMER_RATE = 500; // Interval for tracking app launches in milliseconds
    private final Context mContext;
    private final UsageStatsManager mUsageStatsManager;
    private final SuccessCallback<Boolean> mOnChangeCallback;
    private final List<String> mActiveAppsList = new ArrayList<>(3);
    private Timer mAppLaunchTrackingTimer;
    private String mLastLaunchedAppPackage = "";
    private boolean mIsTrackingPaused = false;

    /**
     * Constructs a DeviceLockUnlockReceiver instance.
     *
     * @param context The application context.
     */
    public DeviceLockUnlockReceiver(Context context, UsageStatsManager usageStatsManager, SuccessCallback<Boolean> onChangeCallback) {
        mContext = context;
        mOnChangeCallback = onChangeCallback;
        mUsageStatsManager = usageStatsManager;
        onDeviceUnlocked();
    }

    @Override
    public void onReceive(Context context, @NonNull Intent intent) {
        if (intent.getAction() != null && Intent.ACTION_USER_PRESENT.equals(intent.getAction())) {
            onDeviceUnlocked();
            mOnChangeCallback.onSuccess(true);
            Log.d(TAG, "onDeviceUnlocked: User UNLOCKED the device and device is ACTIVE");
        } else if (Objects.equals(intent.getAction(), Intent.ACTION_SCREEN_OFF)) {
            onDeviceLocked();
            mOnChangeCallback.onSuccess(false);
            Log.d(TAG, "onDeviceLocked: User LOCKED the device and device is INACTIVE");
        }
    }

    /**
     * Initializes app launch tracking when the device is unlocked.
     */
    private void onDeviceUnlocked() {
        if (mAppLaunchTrackingTimer == null) {
            mAppLaunchTrackingTimer = new Timer();
            mAppLaunchTrackingTimer.schedule(new TimerTask() {
                @Override
                public void run() {
                    onAppLaunchTrackingTimerRun();
                }
            }, 0, TIMER_RATE);
        }

        Log.d(TAG, "onDeviceUnlocked: Repeated task scheduled for tracking new app launches.");
        broadcastLastAppLaunchEvent();
    }

    /**
     * Stops app launch tracking when the device is locked.
     */
    private void onDeviceLocked() {
        if (mAppLaunchTrackingTimer != null) {
            mAppLaunchTrackingTimer.purge();
            mAppLaunchTrackingTimer.cancel();
            mAppLaunchTrackingTimer = null;
        }
        Log.d(TAG, "onDeviceLocked: App launch tracking task cancelled.");
    }

    /**
     * Periodically checks for new app launches and broadcasts an event if a new app is detected.
     */
    private void onAppLaunchTrackingTimerRun() {
        long now = System.currentTimeMillis();
        UsageEvents usageEvents = mUsageStatsManager.queryEvents(now - TIMER_RATE, now);
        UsageEvents.Event currentEvent = new UsageEvents.Event();

        while (usageEvents.hasNextEvent()) {
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
     * Broadcasts an event indicating the last launched app package name.
     */
    public void broadcastLastAppLaunchEvent() {
        if (mLastLaunchedAppPackage.isEmpty() || mIsTrackingPaused) return;

        // Create and send the broadcast intent
        Intent eventIntent = new Intent();
        eventIntent.setAction(ACTION_NEW_APP_LAUNCHED);
        eventIntent.setPackage(mContext.getPackageName());
        eventIntent.putExtra(INTENT_EXTRA_PACKAGE_NAME, mLastLaunchedAppPackage);
        mContext.sendBroadcast(eventIntent);
    }

    /**
     * Pauses or resumes app launch tracking.
     *
     * @param shouldPause True to pause tracking, false to resume.
     */
    public void pauseResumeTracking(boolean shouldPause) {
        mIsTrackingPaused = shouldPause;
        if (!shouldPause) broadcastLastAppLaunchEvent();
    }

    /**
     * Cleans up resources and stops tracking when no longer needed.
     */
    public void dispose() {
        onDeviceLocked();
    }
}
