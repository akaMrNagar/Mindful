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

package com.mindful.android.helpers;

import android.Manifest;
import android.app.Activity;
import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.content.Context;
import android.content.pm.PackageManager;
import android.os.Build;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.core.app.ActivityCompat;
import androidx.core.app.NotificationCompat;

import com.mindful.android.R;
import com.mindful.android.utils.Utils;

import java.util.Arrays;

/**
 * NotificationHelper provides utility methods for managing notification channels and permissions
 * in an Android application.
 * It includes functionalities to register notification channels and request notification permissions.
 */
public class NotificationHelper {
    private static final String TAG = "Mindful.NotificationHelper";

    // Notification channel IDs
    public static final String NOTIFICATION_CRITICAL_CHANNEL_ID = "mindful.notification.channel.CRITICAL";
    public static final String NOTIFICATION_FOCUS_CHANNEL_ID = "mindful.notification.channel.FOCUS";
    public static final String NOTIFICATION_BEDTIME_CHANNEL_ID = "mindful.notification.channel.BEDTIME";
    public static final String NOTIFICATION_SERVICE_CHANNEL_ID = "mindful.notification.channel.SERVICE";

    /**
     * Registers notification channels for the application. This method creates and registers
     * channels for important and other notifications, specifying their importance and descriptions.
     *
     * @param context The application context used to access system services.
     */
    public static void registerNotificationChannels(Context context) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            // Create channels
            NotificationChannel criticalChannel = new NotificationChannel(NOTIFICATION_CRITICAL_CHANNEL_ID, "Critical Alerts", NotificationManager.IMPORTANCE_HIGH);
            criticalChannel.setDescription("These notifications include crucial updates regarding the essential system operations to ensure Mindful runs smoothly.");

            NotificationChannel focusChannel = new NotificationChannel(NOTIFICATION_FOCUS_CHANNEL_ID, "Focus Sessions", NotificationManager.IMPORTANCE_DEFAULT);
            focusChannel.setDescription("These notifications include updates regarding focus sessions to help you stay on track.");

            NotificationChannel bedtimeChannel = new NotificationChannel(NOTIFICATION_BEDTIME_CHANNEL_ID, "Bedtime Routine", NotificationManager.IMPORTANCE_DEFAULT);
            bedtimeChannel.setDescription("These notifications include updates regarding bedtime routine to help you get a peaceful sleep.");

            NotificationChannel serviceChannel = new NotificationChannel(NOTIFICATION_SERVICE_CHANNEL_ID, "Running Services", NotificationManager.IMPORTANCE_DEFAULT);
            serviceChannel.setSound(null, null);
            serviceChannel.setDescription("These are non-critical notifications. They can be disabled but are included to comply with Android requirements.");

            // Register channels
            NotificationManager notificationManager = (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);
            notificationManager.createNotificationChannels(Arrays.asList(criticalChannel, focusChannel, bedtimeChannel, serviceChannel));
        }
    }

    /**
     * Builds and returns a notification for a foreground service with the specified content.
     *
     * @param context The application context used to access system services.
     * @param content The content text of the notification.
     * @return A Notification object representing the foreground service notification.
     */
    @NonNull
    public static Notification buildFgServiceNotification(@NonNull Context context, String content) {
        return new NotificationCompat.Builder(context, NOTIFICATION_SERVICE_CHANNEL_ID)
                .setSmallIcon(R.drawable.ic_notification)
                .setAutoCancel(true)
                .setContentTitle(context.getString(R.string.service_running_notification_title))
                .setContentIntent(Utils.getPendingIntentForMindful(context))
                .setContentText(content)
                .build();
    }

    /**
     * Toggles the Do Not Disturb (DND) mode on or off based on the provided flag.
     *
     * @param context     The application context used to access system services.
     * @param shouldStart If true, enables DND mode; if false, disables it.
     */
    public static void toggleDnd(@NonNull Context context, boolean shouldStart) {
        NotificationManager notificationManager = (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);

        // Check if permission for DND mode is granted
        if (notificationManager.isNotificationPolicyAccessGranted()) {
            if (shouldStart) {
                notificationManager.setInterruptionFilter(NotificationManager.INTERRUPTION_FILTER_PRIORITY);
                Log.d(TAG, "toggleDnd: DND mode started");
            } else {
                notificationManager.setInterruptionFilter(NotificationManager.INTERRUPTION_FILTER_ALL);
                Log.d(TAG, "toggleDnd: DND mode stopped");
            }
        } else {
            Log.d(TAG, "toggleDnd: Do not have permission to modify DND mode");
        }
    }
}
