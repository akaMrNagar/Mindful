/*
 *
 *  *
 *  *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *  *
 *  *  * This source code is licensed under the GPL-2.0 license license found in the
 *  *  * LICENSE file in the root directory of this source tree.
 *  *
 *
 */

package com.mindful.android.receivers;

import android.app.usage.UsageEvents;
import android.app.usage.UsageStatsManager;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

import androidx.annotation.NonNull;

import com.mindful.android.generics.SuccessCallback;
import com.mindful.android.utils.Utils;

import java.util.ArrayList;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

/**
 * BroadcastReceiver that monitors device lock/unlock events and tracks app launches while the device is unlocked.
 */
public class DeviceLockUnlockReceiver extends BroadcastReceiver {
    private final String TAG = "Mindful.DeviceLockUnlockReceiver";
    private static final long TIMER_RATE = 500; // Interval for tracking app launches in milliseconds
    private final UsageStatsManager mUsageStatsManager;
    private final SuccessCallback<Boolean> mOnChangeCallback;
    private final SuccessCallback<String> mOnAppLaunchCallback;
    private final List<String> mActiveAppsList = new ArrayList<>(3);
    private Timer mAppLaunchTrackingTimer;
    private String mLastLaunchedAppPackage = "";
    private boolean mIsTrackingPaused = false;


    public DeviceLockUnlockReceiver(UsageStatsManager usageStatsManager, SuccessCallback<Boolean> onChangeCallback, SuccessCallback<String> onAppLaunchCallback) {
        mOnChangeCallback = onChangeCallback;
        mOnAppLaunchCallback = onAppLaunchCallback;
        mUsageStatsManager = usageStatsManager;
        onDeviceUnlocked();
    }

    @Override
    public void onReceive(Context context, @NonNull Intent intent) {
        String action = Utils.getActionFromIntent(intent);
        if (Intent.ACTION_USER_PRESENT.equals(action)) {
            onDeviceUnlocked();
            mOnChangeCallback.onSuccess(true);
            Log.d(TAG, "onDeviceUnlocked: User UNLOCKED the device and device is ACTIVE");
        } else if (Intent.ACTION_SCREEN_OFF.equals(action)) {
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
        UsageEvents usageEvents = mUsageStatsManager.queryEvents(now - (TIMER_RATE * 2), now);
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
        mOnAppLaunchCallback.onSuccess(mLastLaunchedAppPackage);
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
