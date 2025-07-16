package com.mindful.android.helpers.storage

import android.content.ContentValues
import android.content.Context
import android.database.sqlite.SQLiteDatabase
import android.util.Log
import androidx.core.database.sqlite.transaction
import com.mindful.android.models.Notification
import java.io.File


object DriftDbHelper {
    private const val TAG = "Mindful.DriftDbHelper"

    // Open the database if it's not already open
    private fun openDatabase(context: Context): SQLiteDatabase? {
        try {
            // /data/user/0/com.mindful.android/app_flutter/Mindful0.sqlite
            val dbPath = "${context.dataDir.path}/app_flutter/Mindful.sqlite"
            val dbFile = File(dbPath)

            /// Will open only if it exists
            if (dbFile.exists()) {
                val db = SQLiteDatabase.openDatabase(
                    dbFile.path,
                    null,
                    SQLiteDatabase.OPEN_READWRITE,
                )
                Log.d(TAG, "openDatabase: Database opened successfully")
                return db
            }

            return null
        } catch (e: Exception) {
            Log.e(TAG, "openDatabase(): Failed to open database", e)
            SharedPrefsHelper.insertCrashLogToPrefs(context, e)
            return null
        }
    }


    // ================================ DAO API ==========================================

    // Insert multiple notifications using a transaction
    @Synchronized
    fun insertNotifications(
        context: Context,
        notifications: List<Notification>,
    ): Boolean {
        val db = openDatabase(context)

        try {
            // Begin the transaction
            db?.transaction {
                val values = ContentValues()
                for (notification in notifications) {
                    // Clear values for the next insert
                    values.clear()
                    values.put("key", notification.key)
                    values.put("package_name", notification.packageName)
                    values.put("title", notification.title)
                    values.put("content", notification.content)
                    // Convert MsEpoch to SecEpoch
                    values.put("time_stamp", notification.timeStamp / 1000L)
                    values.put("category", notification.category)
                    values.put("is_read", notification.isRead)

                    // Insert the notification into the database
                    this.insert("notifications_table", null, values)
                }
            }
            Log.d(TAG, "insertNotifications: Successfully inserted notifications")
            return true
        } catch (e: Exception) {
            Log.e(TAG, "insertNotifications: Failed to insert notifications", e)
            return false
        } finally {
            db?.close()
        }
    }

    @Synchronized
    fun fetchLast24HourUnreadNotifications(
        context: Context,
    ): List<Notification> {
        val db = openDatabase(context)
        val result = mutableListOf<Notification>()
        val last24HoursSec = System.currentTimeMillis() / 1000L - 24 * 60 * 60

        try {
            val cursor = db?.query(
                "notifications_table",
                null,
                "is_read = ? AND time_stamp >= ?",
                arrayOf("0", last24HoursSec.toString()),
                null,
                null,
                "time_stamp DESC"
            )

            cursor?.use {
                if (it.moveToFirst()) {
                    do {
                        result.add(Notification.fromCursor(it))
                    } while (it.moveToNext())
                }
            }

            Log.d(TAG, "fetchLast24HourUnreadNotifications: Found ${result.size} notifications")
        } catch (e: Exception) {
            Log.e(TAG, "fetchLast24HourUnreadNotifications: Error fetching notifications", e)
        } finally {
            db?.close()
        }

        return result
    }

    @Synchronized
    fun markNotificationsAsRead(
        context: Context,
        ids: List<Int>,
    ) {
        if (ids.isEmpty()) return
        val db = openDatabase(context)


        try {
            db?.transaction {
                val values = ContentValues().apply { put("is_read", 1) }
                ids.forEach { id ->
                    this.update(
                        "notifications_table",
                        values,
                        "id = ?",
                        arrayOf(id.toString())
                    )
                }
            }
            Log.d(TAG, "markNotificationsAsRead: Marked ${ids.size} notifications as read")
        } catch (e: Exception) {
            Log.e(TAG, "markNotificationsAsRead: Error marking notifications as read", e)
        } finally {
            db?.close()
        }
    }

}
