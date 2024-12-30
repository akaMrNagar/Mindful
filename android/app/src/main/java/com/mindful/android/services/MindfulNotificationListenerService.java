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

package com.mindful.android.services;


import static com.mindful.android.generics.ServiceBinder.ACTION_BIND_TO_MINDFUL;

import android.content.Intent;
import android.os.IBinder;
import android.service.notification.NotificationListenerService;
import android.service.notification.StatusBarNotification;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.mindful.android.generics.ServiceBinder;
import com.mindful.android.helpers.SharedPrefsHelper;
import com.mindful.android.models.UpcomingNotification;
import com.mindful.android.utils.Utils;

import org.jetbrains.annotations.Contract;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Map;


public class MindfulNotificationListenerService extends NotificationListenerService {
    private final String TAG = "Mindful.MindfulNotificationService";
    private final ServiceBinder<MindfulNotificationListenerService> mBinder = new ServiceBinder<>(MindfulNotificationListenerService.this);
    private HashSet<String> mDistractingApps = new HashSet<>(0);
    private boolean mIsListenerActive = false;

    @Override
    public void onListenerConnected() {
        super.onListenerConnected();
        mDistractingApps = SharedPrefsHelper.getSetNotificationBatchedApps(this, null);
        mIsListenerActive = true;
    }

    @Override
    public void onListenerDisconnected() {
        super.onListenerDisconnected();
        mIsListenerActive = false;

    }

    @Override
    public void onNotificationPosted(StatusBarNotification sbn) {
        super.onNotificationPosted(sbn);
        if (!mIsListenerActive) return;
        String packageName = sbn.getPackageName();
        try {

            // Return if the posting app is not marked as distracting
            if (!mDistractingApps.contains(packageName) || !sbn.isClearable()) return;

            // Dismiss notification
            cancelNotification(sbn.getKey());
            Log.d(TAG, "onNotificationPosted: Notification dismissed");

            // Check if we need to store it or not
            if (shouldStoreNotification(packageName, sbn.getTag())) {
                UpcomingNotification notification = new UpcomingNotification(sbn);
                SharedPrefsHelper.insertNotificationToPrefs(this, notification);
                Log.d(TAG, "onNotificationPosted: Notification stored from package: " + packageName);
            }

        } catch (Exception e) {
            SharedPrefsHelper.insertCrashLogToPrefs(this, e);
            Log.e(TAG, "onNotificationPosted: Something went wrong for package: " + packageName, e);
        }
    }


    @Contract(pure = true)
    private boolean shouldStoreNotification(@NonNull String packageName, @Nullable String tag) {
        // For whatsapp
        if (packageName.equals("com.whatsapp") && tag == null) return false;
        return true;
    }


    public void updateDistractingApps(HashSet<String> distractingApps) {
        mDistractingApps = distractingApps;
        Log.d(TAG, "updateDistractingApps: Distracting apps updated successfully");
    }


    @Override
    public IBinder onBind(Intent intent) {
        String action = Utils.getActionFromIntent(intent);
        return action.equals(ACTION_BIND_TO_MINDFUL) ? mBinder : super.onBind(intent);
    }
}