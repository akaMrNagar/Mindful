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
package com.mindful.android.services.notification

import android.app.PendingIntent
import android.content.Intent
import android.os.IBinder
import android.service.notification.NotificationListenerService
import android.service.notification.StatusBarNotification
import android.util.Log
import com.mindful.android.generics.ServiceBinder
import com.mindful.android.helpers.storage.DriftDbHelper
import com.mindful.android.helpers.storage.SharedPrefsHelper
import com.mindful.android.models.Notification
import com.mindful.android.models.NotificationSettings
import java.util.concurrent.ExecutorService
import java.util.concurrent.Executors


class MindfulNotificationListenerService : NotificationListenerService() {
    companion object {
        private const val TAG = "Mindful.MindfulNotificationService"
    }

    private val binder = ServiceBinder(this@MindfulNotificationListenerService)
    private val executorService: ExecutorService = Executors.newFixedThreadPool(4)

    private var settings: NotificationSettings = NotificationSettings()
    private val pendingIntents: MutableMap<String, PendingIntent> = HashMap()
    private val pendingNotifications: MutableList<Notification> = mutableListOf()

    private var isListenerActive = false
    private var lastDbInsertTime: Long = 0

    /**
     *  Returns the pending intent for the provided key if found, otherwise null
     */
    fun getPendingIntentForKey(key: String): PendingIntent? {
        Log.d(TAG, "getPendingIntentForKey: key: $key ,\nIntents:$pendingIntents")
        return pendingIntents[key]
    }

    override fun onListenerConnected() {
        isListenerActive = true
        Log.d(TAG, "onListenerConnected: Notifications listener CONNECTED")
        super.onListenerConnected()
    }

    override fun onListenerDisconnected() {
        isListenerActive = false
        Log.d(TAG, "onListenerConnected: Notifications listener DIS-CONNECTED")
        super.onListenerDisconnected()
    }

    override fun onNotificationPosted(sbn: StatusBarNotification) {
        if (!isListenerActive) return
        val packageName = sbn.packageName
        try {
            /// FIXME: Uncomment it out
            // If from mindful
            // if(packageName == this.packageName) return

            // Dismiss notification if it is from distracting apps
            if (settings.batchedApps.contains(packageName) && sbn.isClearable) {
                cancelNotification(sbn.key)
                Log.d(TAG, "onNotificationPosted: Distracting notification dismissed")
            }

            // Process only if keeping history or it is from distracting apps
            if (settings.storeNonBatchedToo || settings.batchedApps.contains(packageName)) {
                executorService.submit { processNotificationInBg(sbn) }
            }
        } catch (e: Exception) {
            SharedPrefsHelper.insertCrashLogToPrefs(this, e)
            Log.e(TAG, "onNotificationPosted: Something went wrong for package: $packageName", e)
        }
        super.onNotificationPosted(sbn)
    }


    fun updateNotificationSettings(settings: NotificationSettings) {
        this.settings = settings
        Log.d(
            TAG,
            "updateNotificationSettings: Notification settings updated successfully: $settings"
        )
    }

    private fun processNotificationInBg(sbn: StatusBarNotification) {
        Log.d(TAG, "processNotificationInBg: Processing notification")

        // Create notification and cache
        val notification = Notification.fromSbn(sbn)
        pendingIntents[notification.key] = sbn.notification.contentIntent
        pendingNotifications.add(notification)


        // Insert notifications to db if the difference between last insertion is more than 1 minute
        if ((System.currentTimeMillis() - lastDbInsertTime) >= (60000)) {
            insertNotificationsToDb()
        }
    }

    private fun insertNotificationsToDb() {
        // Return if no pending notifications
        if (pendingNotifications.isEmpty()) return


        val isSuccess = DriftDbHelper(this).insertNotifications(pendingNotifications)
        lastDbInsertTime = System.currentTimeMillis()

        // Clear list if inserted successfully
        if (isSuccess) pendingNotifications.clear()
    }


    override fun onBind(intent: Intent): IBinder? {
        return if (intent.action == ServiceBinder.ACTION_BIND_TO_MINDFUL) binder
        else super.onBind(intent)
    }

    override fun onDestroy() {
        super.onDestroy()
        insertNotificationsToDb()
        Log.d(TAG, "onDestroy: Notifications listener DESTROYED")
    }
}