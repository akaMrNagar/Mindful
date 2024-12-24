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

import android.app.Notification;
import android.content.Intent;
import android.os.IBinder;
import android.service.notification.NotificationListenerService;
import android.service.notification.StatusBarNotification;
import android.util.Log;

import com.mindful.android.generics.ServiceBinder;
import com.mindful.android.models.PendingNotification;
import com.mindful.android.utils.Utils;

import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;


public class MindfulNotificationListenerService extends NotificationListenerService {
    private final String TAG = "Mindful.MindfulNotificationService";
    private final ServiceBinder<MindfulNotificationListenerService> mBinder = new ServiceBinder<>(MindfulNotificationListenerService.this);


    private final HashMap<String, PendingNotification> mPendingNotifications = new HashMap<>(0);
    private HashSet<String> mDistractingApps = new HashSet<>(Arrays.asList("com.whatsapp"));


    @Override
    public void onNotificationPosted(StatusBarNotification sbn) {
        super.onNotificationPosted(sbn);
        String packageName = sbn.getPackageName();

        // Return if the posting app is not marked as distracting
        if (!mDistractingApps.contains(packageName)) return;

        Log.d(TAG, "onNotificationPosted: Notification received from distracting app");
        Notification notification = sbn.getNotification();
        String titleText = notification.extras.getString(Notification.EXTRA_TITLE, "Null");
        String contentText = notification.extras.getString(Notification.EXTRA_TEXT, "Null");
        String uniqueKey = sbn.getKey();

        mPendingNotifications.put(uniqueKey, new PendingNotification(packageName, titleText, contentText, notification.getLargeIcon(), notification.contentIntent));
        cancelNotification(sbn.getKey());
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