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

import android.content.Intent
import android.os.IBinder
import android.service.notification.NotificationListenerService
import android.service.notification.StatusBarNotification
import android.util.Log
import com.mindful.android.generics.ServiceBinder
import com.mindful.android.helpers.storage.SharedPrefsHelper
import com.mindful.android.models.UpcomingNotification


class MindfulNotificationListenerService : NotificationListenerService() {
    companion object {
        private const val TAG = "Mindful.MindfulNotificationService"
    }

    private val mBinder = ServiceBinder(this@MindfulNotificationListenerService)
    private val mSocialMediaPackages =
        setOf("com.whatsapp", "com.instagram.android", "com.snapchat.android")

    private var mDistractingApps = HashSet<String>(0)
    private var mIsListenerActive = false

    override fun onListenerConnected() {
        super.onListenerConnected()
        mDistractingApps = SharedPrefsHelper.getSetNotificationBatchedApps(this, null)
        mIsListenerActive = true
    }

    override fun onListenerDisconnected() {
        mIsListenerActive = false
        super.onListenerDisconnected()
    }

    override fun onNotificationPosted(sbn: StatusBarNotification) {
        if (!mIsListenerActive) return
        val packageName = sbn.packageName
        try {
            // Return if the posting app is not marked as distracting
            if (!mDistractingApps.contains(packageName) || !sbn.isClearable) return


            // Dismiss notification
            cancelNotification(sbn.key)
            Log.d(TAG, "onNotificationPosted: Notification dismissed")

            // Return if it is from social media but does not have tag
            if (sbn.tag == null && mSocialMediaPackages.contains(packageName)) return

            // Check if we can store it or not
            val notification = UpcomingNotification(sbn)
            if (notification.titleText.isEmpty() || notification.contentText.isEmpty()) {
                Log.d(
                    TAG,
                    "onNotificationPosted: Notification is not valid, so skipping it from storing."
                )
                SharedPrefsHelper.insertCrashLogToPrefs(
                    this,
                    Exception("Invalid notification from " + packageName + " with title: " + notification.titleText + " and content: " + notification.contentText)
                )
                return
            }

            SharedPrefsHelper.insertNotificationToPrefs(this, notification)
            Log.d(TAG, "onNotificationPosted: Notification stored from package: $packageName")
        } catch (e: Exception) {
            SharedPrefsHelper.insertCrashLogToPrefs(this, e)
            Log.e(TAG, "onNotificationPosted: Something went wrong for package: $packageName", e)
        }
        super.onNotificationPosted(sbn)
    }


    fun updateDistractingApps(distractingApps: HashSet<String>) {
        mDistractingApps = distractingApps
        Log.d(TAG, "updateDistractingApps: Distracting apps updated successfully")
    }

    override fun onBind(intent: Intent): IBinder? {
        return if (intent.action == ServiceBinder.ACTION_BIND_TO_MINDFUL) mBinder
        else super.onBind(intent)
    }

    override fun onDestroy() {
        SharedPrefsHelper.insertCrashLogToPrefs(
            this,
            Throwable("MindfulNotificationListenerService is DESTROYED")
        )
        super.onDestroy()
    }
}