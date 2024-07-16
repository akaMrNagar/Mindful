package com.akamrnagar.mindful.helpers;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.content.Context;
import android.os.Build;

import androidx.annotation.NonNull;
import androidx.core.app.NotificationCompat;

import com.akamrnagar.mindful.R;

public class NotificationHelper {

    private static final String NOTIFICATION_SERVICE_CHANNEL_NAME = "Service Channel";
    private static final String NOTIFICATION_GENERAL_CHANNEL_NAME = "General Channel";
    private static final String NOTIFICATION_SERVICE_CHANNEL_ID = "com.akamrnagar.mindful.notification.services.channel";
    private static final String NOTIFICATION_GENERAL_CHANNEL_ID = "com.akamrnagar.mindful.notification.general.channel";

    public static void registerNotificationChannels(Context context) {
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
            NotificationChannel generalChannel = new NotificationChannel(NOTIFICATION_GENERAL_CHANNEL_ID, NOTIFICATION_GENERAL_CHANNEL_NAME, NotificationManager.IMPORTANCE_DEFAULT);
            generalChannel.setDescription("Desc");

            NotificationChannel serviceChannel = new NotificationChannel(NOTIFICATION_SERVICE_CHANNEL_ID, NOTIFICATION_SERVICE_CHANNEL_NAME, NotificationManager.IMPORTANCE_HIGH);
            serviceChannel.setDescription("Desc");

            NotificationManager notificationManager = (NotificationManager) context.getSystemService(NotificationManager.class);
            notificationManager.createNotificationChannel(generalChannel);
            notificationManager.createNotificationChannel(serviceChannel);
        }
    }


    @NonNull
    public static Notification createTrackingNotification(Context context, String info) {

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {

            return new Notification.Builder(context, NOTIFICATION_SERVICE_CHANNEL_ID)
                    .setSmallIcon(R.mipmap.ic_launcher)
                    .setContentTitle("Mindful")
                    .setContentText(info)
                    .build();
        } else {
            NotificationCompat.Builder notification = new NotificationCompat.Builder(context, NOTIFICATION_SERVICE_CHANNEL_ID)
                    .setSmallIcon(R.mipmap.ic_launcher)
                    .setContentTitle("Mindful")
                    .setContentText(info)
                    .setAutoCancel(true);

            notification.setPriority(NotificationManager.IMPORTANCE_MAX);
            return notification.build();
        }
    }

    public static void sendPushNotification(Context context, String title, String content) {
        Notification notification;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            notification = new Notification.Builder(context, NOTIFICATION_GENERAL_CHANNEL_ID)
                    .setSmallIcon(R.mipmap.ic_launcher)
                    .setContentTitle(title)
                    .setContentText(content)
                    .build();

        } else {
            NotificationCompat.Builder notificationCompat = new NotificationCompat.Builder(context, NOTIFICATION_GENERAL_CHANNEL_ID)
                    .setSmallIcon(R.mipmap.ic_launcher)
                    .setContentTitle(title)
                    .setContentText(content)
                    .setAutoCancel(true);

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                notificationCompat.setPriority(NotificationManager.IMPORTANCE_HIGH);
            }

            notification = notificationCompat.build();
        }

        context.getSystemService(NotificationManager.class).notify(0, notification);
    }

}
