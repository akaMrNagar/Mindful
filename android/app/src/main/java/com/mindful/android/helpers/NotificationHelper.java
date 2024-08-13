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
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.core.app.ActivityCompat;
import androidx.core.app.NotificationCompat;

import com.mindful.android.R;

/**
 * NotificationHelper provides utility methods for managing notification channels and permissions
 * in an Android application.
 * It includes functionalities to register notification channels and request notification permissions.
 */
public class NotificationHelper {
    private static final String TAG = "Mindful.NotificationHelper";

    // Notification channel names
    private static final String NOTIFICATION_IMPORTANT_CHANNEL_NAME = "Important";
    private static final String NOTIFICATION_OTHER_CHANNEL_NAME = "Other";

    // Notification channel IDs
    public static final String NOTIFICATION_IMPORTANT_CHANNEL_ID = "mindful.notification.channel.important";
    public static final String NOTIFICATION_OTHER_CHANNEL_ID = "mindful.notification.channel.other";

    /**
     * Registers notification channels for the application. This method creates and registers
     * channels for important and other notifications, specifying their importance and descriptions.
     *
     * @param context The application context used to access system services.
     */
    public static void registerNotificationGroupAndChannels(Context context) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            // Create channels
            NotificationChannel importantChannel = new NotificationChannel(NOTIFICATION_IMPORTANT_CHANNEL_ID, NOTIFICATION_IMPORTANT_CHANNEL_NAME, NotificationManager.IMPORTANCE_HIGH);
            NotificationChannel otherChannel = new NotificationChannel(NOTIFICATION_OTHER_CHANNEL_ID, NOTIFICATION_OTHER_CHANNEL_NAME, NotificationManager.IMPORTANCE_MIN);
            importantChannel.setDescription("These notifications include crucial reminders and updates, designed to help you stay on track.");
            otherChannel.setDescription("These are non-critical updates. They can be disabled but are included to comply with Android requirements.");

            // Register channels
            NotificationManager notificationManager = (NotificationManager) context.getSystemService(NotificationManager.class);
            notificationManager.createNotificationChannel(otherChannel);
            notificationManager.createNotificationChannel(importantChannel);
        }
    }

    /**
     * Checks if notification permissions are granted and optionally asks for it if not granted.
     *
     * @param context          The application context used to check notification permissions.
     * @param activity         The activity used to request notification permissions if needed.
     * @param askPermissionToo Whether to request notification permission if not already granted.
     * @return True if notification permissions are granted, false otherwise.
     */
    public static boolean getAndAskNotificationPermission(@NonNull Context context, @NonNull Activity activity, boolean askPermissionToo) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            int status = context.checkSelfPermission(Manifest.permission.POST_NOTIFICATIONS);
            if (status == PackageManager.PERMISSION_GRANTED) {
                return true;
            }
        } else {
            NotificationManager notificationManager =
                    (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);
            if (notificationManager.areNotificationsEnabled()) {
                return true;
            }
        }

        if (askPermissionToo) {
            if (Build.VERSION.SDK_INT < Build.VERSION_CODES.TIRAMISU) {
                NewActivitiesLaunchHelper.openMindfulNotificationSection(context);
            } else {
                int count = SharedPrefsHelper.fetchNotificationAskCount(context);
                if (count < 2) {
                    ActivityCompat.requestPermissions(
                            activity,
                            new String[]{Manifest.permission.POST_NOTIFICATIONS},
                            0
                    );
                } else {
                    NewActivitiesLaunchHelper.openMindfulNotificationSection(context);
                }

                SharedPrefsHelper.storeNotificationAskCount(context, count + 1);
            }
        }
        return false;
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
            Toast.makeText(context, "Please allow do not disturb access to Mindful", Toast.LENGTH_SHORT).show();
        }
    }

    /**
     * Sends an important alert notification with the specified content.
     *
     * @param context The application context used to access system services.
     * @param id      The ID of the notification.
     * @param alert   The content of the notification.
     */
    public static void pushImpAlertNotification(@NonNull Context context, int id, String alert) {
        NotificationManager notificationManager = (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);
        notificationManager.notify(
                id, new NotificationCompat.Builder(context, NOTIFICATION_IMPORTANT_CHANNEL_ID)
                        .setSmallIcon(R.drawable.ic_notification)
                        .setOngoing(false)
                        .setOnlyAlertOnce(true)
                        .setContentTitle("Mindful")
                        .setContentText(alert)
                        .build()
        );
    }

    /**
     * Builds and returns a progress notification with the specified parameters.
     *
     * @param context     The application context used to access system services.
     * @param title       The title of the notification.
     * @param content     The content text of the notification.
     * @param maxProgress The maximum progress value.
     * @param progress    The current progress value.
     * @return A Notification object representing the progress notification.
     */
    @NonNull
    public static Notification buildProgressNotification(Context context,
                                                         String title,
                                                         String content,
                                                         int maxProgress,
                                                         int progress
    ) {
        return new NotificationCompat.Builder(context, NOTIFICATION_IMPORTANT_CHANNEL_ID)
                .setSmallIcon(R.drawable.ic_notification)
                .setOngoing(true)
                .setOnlyAlertOnce(true)
                .setContentTitle(title)
                .setContentText(content)
                .setProgress(maxProgress, progress, false).build();
    }

    /**
     * Builds and returns a notification for a foreground service with the specified content.
     *
     * @param context The application context used to access system services.
     * @param content The content text of the notification.
     * @return A Notification object representing the foreground service notification.
     */
    @NonNull
    public static Notification buildFgServiceNotification(Context context, String content) {
        return new NotificationCompat.Builder(context, NOTIFICATION_OTHER_CHANNEL_ID)
                .setSmallIcon(R.drawable.ic_notification)
                .setAutoCancel(true)
                .setContentTitle("Mindful is running")
                .setContentText(content)
                .build();
    }
}
