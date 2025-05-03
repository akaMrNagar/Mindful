package com.mindful.android.helpers.storage

import android.content.ContentValues
import android.content.Context
import android.database.sqlite.SQLiteDatabase
import android.util.Log
import com.mindful.android.models.Notification
import java.io.File

open class DriftDbHelper(context: Context) {
    companion object {
        private const val TAG = "Mindful.DriftDbHelper"
    }

    private var db: SQLiteDatabase? = null

    init {
        openDatabase(context)
    }

    // Open the database if it's not already open
    private fun openDatabase(context: Context) {
        if (db == null) {
            // /data/user/0/com.mindful.android/app_flutter/Mindful0.sqlite
            val dbPath = "${context.dataDir.path}/app_flutter/Mindful.sqlite"
            val dbFile = File(dbPath)

            /// Will open only if it exists
            if (dbFile.exists()) {
                db = SQLiteDatabase.openOrCreateDatabase(dbFile, null)
                Log.d("Mindful.DriftDbHelper", "openDatabase: Database opened successfully")
            }
        }

    }

    // Get the database instance
    fun getDatabase(): SQLiteDatabase {
        return db
            ?: throw IllegalStateException("Database not initialized. Call AppDbHelper.openDb(context) first.")
    }

    // Close the database
    fun closeDatabase() {
        db?.close()
        db = null

    }

    // ================================ DAO API ==========================================

    // Insert multiple notifications using a transaction
    fun insertNotifications(
        notifications: List<Notification>,
        autoCloseDb: Boolean = true,
    ): Boolean {
        try {
            // Begin the transaction
            db?.beginTransaction()

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
                values.put("is_read", false)

                // Insert the notification into the database
                db?.insert("notifications_table", null, values)
            }

            // End transaction and Close db if needed
            db?.setTransactionSuccessful()
            db?.endTransaction()

            Log.d(TAG, "insertNotifications: Successfully inserted notifications")
            return true
        } catch (e: Exception) {
            Log.e(TAG, "insertNotifications: Failed to insert notifications", e)
            return false
        } finally {
            if (autoCloseDb) closeDatabase()
        }
    }

}
