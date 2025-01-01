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


import com.mindful.android.generics.ServiceBinder;
import com.mindful.android.helpers.SharedPrefsHelper;
import com.mindful.android.models.UpcomingNotification;
import com.mindful.android.utils.Utils;

import java.util.HashSet;
import java.util.Set;


public class MindfulNotificationListenerService extends NotificationListenerService {
    private final String TAG = "Mindful.MindfulNotificationService";
    private final ServiceBinder<MindfulNotificationListenerService> mBinder = new ServiceBinder<>(MindfulNotificationListenerService.this);
    private final Set<String> mSocialMediaPackages = Set.of("com.whatsapp", "com.instagram.android", "com.snapchat.android");

    private HashSet<String> mDistractingApps = new HashSet<>(0);
    private boolean mIsListenerActive = false;

    @Override
    public void onListenerConnected() {
        super.onListenerConnected();
        mDistractingApps = SharedPrefsHelper.getSetNotificationBatchedApps(this, null);

        //
        SharedPrefsHelper.insertCrashLogToPrefs(this, new Throwable("MindfulNotificationListenerService is CONNECTED by system"));
        mIsListenerActive = true;
    }

    @Override
    public void onListenerDisconnected() {
        super.onListenerDisconnected();

        //
        SharedPrefsHelper.insertCrashLogToPrefs(this, new Throwable("MindfulNotificationListenerService is DIS-CONNECTED by system"));
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

            // Return if it is from social media but does not have tag
            if (sbn.getTag() == null && mSocialMediaPackages.contains(packageName)) return;

            // Check if we can store it or not
            UpcomingNotification notification = new UpcomingNotification(sbn);
            if (notification.titleText.isEmpty() || notification.contentText.isEmpty()) {
                Log.d(TAG, "onNotificationPosted: Notification is not valid, so skipping it from storing.");
                SharedPrefsHelper.insertCrashLogToPrefs(
                        this,
                        new Exception("Invalid notification from " + packageName + " with title: " + notification.titleText + " and content: " + notification.contentText)
                );
                return;
            }

            SharedPrefsHelper.insertNotificationToPrefs(this, notification);
            Log.d(TAG, "onNotificationPosted: Notification stored from package: " + packageName);
        } catch (Exception e) {
            SharedPrefsHelper.insertCrashLogToPrefs(this, e);
            Log.e(TAG, "onNotificationPosted: Something went wrong for package: " + packageName, e);
        }
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

    @Override
    public void onDestroy() {
        super.onDestroy();
        SharedPrefsHelper.insertCrashLogToPrefs(this, new Throwable("MindfulNotificationListenerService is DESTROYED"));
    }
}