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
package com.mindful.android.helpers.database

import android.content.Context
import android.content.SharedPreferences
import android.content.SharedPreferences.OnSharedPreferenceChangeListener
import android.util.Log
import com.mindful.android.models.AppRestrictions
import com.mindful.android.models.BedtimeSettings
import com.mindful.android.models.RestrictionGroup
import com.mindful.android.models.UpcomingNotification
import com.mindful.android.models.WellBeingSettings
import com.mindful.android.utils.AppConstants
import com.mindful.android.utils.JsonDeserializer
import com.mindful.android.utils.Utils
import org.json.JSONArray
import org.json.JSONObject
import java.util.Calendar

/**
 * Helper class to manage SharedPreferences operations.
 * Provides methods to store and retrieve various application settings and data.
 */
object SharedPrefsHelper {
    private var mUniquePrefs: SharedPreferences? = null
    private const val UNIQUE_PREFS_BOX = "UniquePrefs"
    private const val PREF_KEY_NOTIFICATION_PERMISSION_COUNT = "notificationPermissionCount"
    private const val PREF_KEY_DATA_RESET_TIME_MINS = "dataResetTimeMins"
    private const val PREF_KEY_SHORTS_SCREEN_TIME = "shortsScreenTime"
    private const val PREF_KEY_BEDTIME_SETTINGS = "bedtimeSettings"
    const val PREF_KEY_WELLBEING_SETTINGS: String = "wellBeingSettings"
    private const val PREF_KEY_EXCLUDED_APPS = "excludedApps"

    private var mAppRestrictionPrefs: SharedPreferences? = null
    private const val APP_RESTRICTION_PREFS_BOX = "AppRestrictionPrefs"
    private const val PREF_KEY_APP_RESTRICTIONS = "appRestrictions"

    private var mRestrictionGroupPrefs: SharedPreferences? = null
    private const val RESTRICTION_GROUP_PREFS_BOX = "RestrictionGroupPrefs"
    private const val PREF_KEY_RESTRICTION_GROUPS = "restrictionGroups"

    private var mCrashLogPrefs: SharedPreferences? = null
    private const val CRASH_LOG_PREFS_BOX = "CrashLogPrefs"
    private const val PREF_KEY_CRASH_LOGS = "crashLogs"

    private var mNotificationBatchPrefs: SharedPreferences? = null
    private const val NOTIFICATION_BATCH_PREFS_BOX = "NotificationBatchPrefs"
    private const val PREF_KEY_UPCOMING_NOTIFICATIONS = "upcomingNotifications"
    private const val PREF_KEY_BATCH_SCHEDULES = "batchSchedules"
    private const val PREF_KEY_BATCHED_APPS = "batchedApps"



    private fun checkAndInitializeUniquePrefs(context: Context) {
        if (mUniquePrefs != null) return
        mUniquePrefs =
            context.applicationContext.getSharedPreferences(UNIQUE_PREFS_BOX, Context.MODE_PRIVATE)
    }

    private fun checkAndInitializeAppRestrictionPrefs(context: Context) {
        if (mAppRestrictionPrefs != null) return
        mAppRestrictionPrefs = context.applicationContext.getSharedPreferences(
            APP_RESTRICTION_PREFS_BOX, Context.MODE_PRIVATE
        )
    }

    private fun checkAndInitializeRestrictionGroupPrefs(context: Context) {
        if (mRestrictionGroupPrefs != null) return
        mRestrictionGroupPrefs = context.applicationContext.getSharedPreferences(
            RESTRICTION_GROUP_PREFS_BOX, Context.MODE_PRIVATE
        )
    }

    private fun checkAndInitializeCrashLogPrefs(context: Context) {
        if (mCrashLogPrefs != null) return
        mCrashLogPrefs = context.applicationContext.getSharedPreferences(
            CRASH_LOG_PREFS_BOX,
            Context.MODE_PRIVATE
        )
    }

    private fun checkAndInitializeNotificationBatchPrefs(context: Context) {
        if (mNotificationBatchPrefs != null) return
        mNotificationBatchPrefs = context.applicationContext.getSharedPreferences(
            NOTIFICATION_BATCH_PREFS_BOX, Context.MODE_PRIVATE
        )
    }


    /**
     * Checks and Migrates shared prefs data from old one file to multiple new files.
     *
     * @param context The application context.
     */
    fun migrateFromOldPrefs(context: Context) {
        checkAndInitializeUniquePrefs(context)
        val isMigrationDone = mUniquePrefs!!.getBoolean("MigrationDone", false)
        if (isMigrationDone) return

        // Load unique data
        getSetNotificationAskCount(context, OldPrefsHelper.getNotificationAskCount(context))
        getSetDataResetTimeMins(context, OldPrefsHelper.getDataResetTimeMins(context))
        getSetShortsScreenTimeMs(context, OldPrefsHelper.getShortsScreenTimeMs(context))
        getSetWellBeingSettings(context, OldPrefsHelper.getWellBeingSettingsString(context))
        getSetBedtimeSettings(context, OldPrefsHelper.getBedtimeSettingsString(context))
        getSetExcludedApps(context, OldPrefsHelper.getExcludedAppsString(context))

        // Load app restrictions
        getSetAppRestrictions(context, OldPrefsHelper.getAppRestrictionsString(context))

        // Load restriction groups
        getSetRestrictionGroups(context, OldPrefsHelper.getRestrictionGroupsString(context))

        mUniquePrefs!!.edit().putBoolean("MigrationDone", true).apply()
    }


    /**
     * Registers or Unregister a listener to/from SharedPreferences changes.
     *
     * @param context        The application context.
     * @param shouldRegister If TRUE the callback will be registered else unregistered.
     * @param callback       The listener to register.
     */
    fun registerUnregisterListenerToUniquePrefs(
        context: Context,
        shouldRegister: Boolean,
        callback: OnSharedPreferenceChangeListener?
    ) {
        checkAndInitializeUniquePrefs(context)
        try {
            if (shouldRegister) {
                mUniquePrefs!!.registerOnSharedPreferenceChangeListener(callback)
            } else {
                mUniquePrefs!!.unregisterOnSharedPreferenceChangeListener(callback)
            }
        } catch (ignored: Exception) {
        }
    }

    /**
     * Get the notification permission request count if count is null else store it.
     *
     * @param context The application context.
     * @param count   The number of requests.
     */
    fun getSetNotificationAskCount(context: Context, count: Int?): Int {
        checkAndInitializeUniquePrefs(context)
        if (count == null) {
            return mUniquePrefs!!.getInt(PREF_KEY_NOTIFICATION_PERMISSION_COUNT, 0)
        } else {
            mUniquePrefs!!.edit().putInt(PREF_KEY_NOTIFICATION_PERMISSION_COUNT, count).apply()
            return count
        }
    }

    /**
     * Get the data reset time in MINUTES if the passed timeInMins is null else store it .
     *
     * @param context    The application context.
     * @param timeInMins The time in minutes.
     * @return Instance of calender set to data reset time for today
     */
    fun getSetDataResetTimeMins(context: Context, timeInMins: Int?): Calendar {
        checkAndInitializeUniquePrefs(context)
        if (timeInMins == null) {
            return Utils.todToTodayCal(mUniquePrefs!!.getInt(PREF_KEY_DATA_RESET_TIME_MINS, 0))
        } else {
            mUniquePrefs!!.edit().putInt(PREF_KEY_DATA_RESET_TIME_MINS, timeInMins).apply()
            return Utils.todToTodayCal(timeInMins)
        }
    }


    /**
     * Fetches the hashset of excluded apps if jsonExcludedApps is null else store it's json.
     *
     * @param context          The application context.
     * @param jsonExcludedApps The JSON string of excluded apps.
     */
    fun getSetExcludedApps(context: Context, jsonExcludedApps: String?): HashSet<String> {
        checkAndInitializeUniquePrefs(context)
        if (jsonExcludedApps == null) {
            return JsonDeserializer.jsonStrToStringHashSet(
                mUniquePrefs!!.getString(PREF_KEY_EXCLUDED_APPS, "")
            )
        } else {
            mUniquePrefs!!.edit().putString(PREF_KEY_EXCLUDED_APPS, jsonExcludedApps).apply()
            return JsonDeserializer.jsonStrToStringHashSet(jsonExcludedApps)
        }
    }

    /**
     * Fetches the short content's screen time if screenTime is null else store it's json.
     *
     * @param context    The application context.
     * @param screenTime The short content's screen time.
     */
    fun getSetShortsScreenTimeMs(context: Context, screenTime: Long?): Long {
        checkAndInitializeUniquePrefs(context)
        if (screenTime == null) {
            return mUniquePrefs!!.getLong(PREF_KEY_SHORTS_SCREEN_TIME, 0L)
        } else {
            mUniquePrefs!!.edit().putLong(PREF_KEY_SHORTS_SCREEN_TIME, screenTime).apply()
            return screenTime
        }
    }

    /**
     * Fetches the well-being settings if jsonWellBeingSettings is null else store it's json.
     *
     * @param context               The application context.
     * @param jsonWellBeingSettings The JSON string of well-being settings.
     */
    fun getSetWellBeingSettings(
        context: Context,
        jsonWellBeingSettings: String?
    ): WellBeingSettings {
        checkAndInitializeUniquePrefs(context)
        if (jsonWellBeingSettings == null) {
            return WellBeingSettings(mUniquePrefs!!.getString(PREF_KEY_WELLBEING_SETTINGS, "")!!)
        } else {
            mUniquePrefs!!.edit().putString(PREF_KEY_WELLBEING_SETTINGS, jsonWellBeingSettings)
                .apply()
            return WellBeingSettings(jsonWellBeingSettings)
        }
    }

    /**
     * Fetches the bedtime settings if jsonBedtimeSettings is null else store it's json.
     *
     * @param context             The application context.
     * @param jsonBedtimeSettings The JSON string of bedtime settings.
     */
    fun getSetBedtimeSettings(context: Context, jsonBedtimeSettings: String?): BedtimeSettings {
        checkAndInitializeUniquePrefs(context)
        if (jsonBedtimeSettings == null) {
            return BedtimeSettings(mUniquePrefs!!.getString(PREF_KEY_BEDTIME_SETTINGS, "")!!)
        } else {
            mUniquePrefs!!.edit().putString(PREF_KEY_BEDTIME_SETTINGS, jsonBedtimeSettings).apply()
            return BedtimeSettings(jsonBedtimeSettings)
        }
    }

    /**
     * Fetches the hashmap of app restrictions if jsonAppRestrictions is null else store it's json.
     *
     * @param context             The application context.
     * @param jsonAppRestrictions The JSON string of hashmap of app restrictions.
     */
    fun getSetAppRestrictions(
        context: Context,
        jsonAppRestrictions: String?
    ): HashMap<String, AppRestrictions> {
        checkAndInitializeAppRestrictionPrefs(context)
        if (jsonAppRestrictions == null) {
            return JsonDeserializer.jsonStrToAppRestrictionsHashMap(
                mAppRestrictionPrefs!!.getString(PREF_KEY_APP_RESTRICTIONS, "")
            )
        } else {
            mAppRestrictionPrefs!!.edit().putString(PREF_KEY_APP_RESTRICTIONS, jsonAppRestrictions)
                .apply()
            return JsonDeserializer.jsonStrToAppRestrictionsHashMap(jsonAppRestrictions)
        }
    }

    /**
     * Fetches the hashmap of restriction groups if jsonRestrictionGroups is null else store it's json.
     *
     * @param context               The application context.
     * @param jsonRestrictionGroups The JSON string of hashmap of restriction groups.
     */
    fun getSetRestrictionGroups(
        context: Context,
        jsonRestrictionGroups: String?
    ): HashMap<Int, RestrictionGroup> {
        checkAndInitializeRestrictionGroupPrefs(context)
        if (jsonRestrictionGroups == null) {
            return JsonDeserializer.jsonStrToRestrictionGroupsHashMap(
                mRestrictionGroupPrefs!!.getString(PREF_KEY_RESTRICTION_GROUPS, "")
            )
        } else {
            mRestrictionGroupPrefs!!.edit()
                .putString(PREF_KEY_RESTRICTION_GROUPS, jsonRestrictionGroups).apply()
            return JsonDeserializer.jsonStrToRestrictionGroupsHashMap(jsonRestrictionGroups)
        }
    }

    /**
     * Creates and Inserts a new crash log into SharedPreferences based on the passed exception.
     *
     * @param context   The application context used to retrieve app version and store the log.
     * @param exception The exception that was thrown, which will be logged in the crash log.
     */
    fun insertCrashLogToPrefs(context: Context, exception: Throwable) {
        checkAndInitializeCrashLogPrefs(context)

        // Create new object
        val currentLog = JSONObject()
        try {
            currentLog.put("appVersion", Utils.getAppVersion(context))
            currentLog.put("timeStamp", System.currentTimeMillis())
            currentLog.put("error", exception.toString())
            currentLog.put("stackTrace", Log.getStackTraceString(exception))
        } catch (ignored: Exception) {
        }

        // Get existing crash logs
        val crashLogsJson = mCrashLogPrefs!!.getString(PREF_KEY_CRASH_LOGS, "[]")
        var crashLogsArray = try {
            JSONArray(crashLogsJson)
        } catch (e1: Exception) {
            JSONArray()
        }

        // Insert current log and update prefs
        crashLogsArray.put(currentLog)

        mCrashLogPrefs!!.edit().putString(PREF_KEY_CRASH_LOGS, crashLogsArray.toString()).apply()
    }


    /**
     * Retrieves the crash logs from SharedPreferences as a JSON Array string.
     *
     * @param context The application context used to access SharedPreferences.
     * @return A JSON string representing the stored crash logs array.
     */
    fun getCrashLogsArrayString(context: Context): String {
        checkAndInitializeCrashLogPrefs(context)
        return mCrashLogPrefs!!.getString(PREF_KEY_CRASH_LOGS, "[]")!!
    }

    /**
     * Clears all the stored crash logs from shared prefs.
     *
     * @param context The application context used to access SharedPreferences.
     */
    fun clearCrashLogs(context: Context) {
        checkAndInitializeCrashLogPrefs(context)
        mCrashLogPrefs!!.edit().putString(PREF_KEY_CRASH_LOGS, "[]").apply()
    }


    /**
     * Fetches the hashset of integers representing notification schedules if jsonNotificationSchedules is null else store it's json.
     *
     * @param context                   The application context.
     * @param jsonNotificationSchedules The JSON string of hashset of integers representing notification schedules.
     */
    fun getSetNotificationBatchSchedules(
        context: Context,
        jsonNotificationSchedules: String?
    ): HashSet<Int> {
        checkAndInitializeNotificationBatchPrefs(context)
        if (jsonNotificationSchedules == null) {
            return JsonDeserializer.jsonStrToIntegerHashSet(
                mNotificationBatchPrefs!!.getString(PREF_KEY_BATCH_SCHEDULES, "")!!
            )
        } else {
            mNotificationBatchPrefs!!.edit()
                .putString(PREF_KEY_BATCH_SCHEDULES, jsonNotificationSchedules).apply()
            return JsonDeserializer.jsonStrToIntegerHashSet(jsonNotificationSchedules)
        }
    }

    /**
     * Fetches the hashset of notification batched apps if jsonBatchedApps is null else store it's json.
     *
     * @param context         The application context.
     * @param jsonBatchedApps The JSON string of notification batched apps.
     */
    fun getSetNotificationBatchedApps(
        context: Context,
        jsonBatchedApps: String?
    ): HashSet<String> {
        checkAndInitializeNotificationBatchPrefs(context)
        if (jsonBatchedApps == null) {
            return JsonDeserializer.jsonStrToStringHashSet(
                mNotificationBatchPrefs!!.getString(PREF_KEY_BATCHED_APPS, "")!!
            )
        } else {
            mNotificationBatchPrefs!!.edit().putString(PREF_KEY_BATCHED_APPS, jsonBatchedApps)
                .apply()
            return JsonDeserializer.jsonStrToStringHashSet(jsonBatchedApps)
        }
    }

    /**
     * Creates and Inserts a new notification into SharedPreferences based on the passed object.
     *
     * @param context      The application context used to retrieve app version and store the log.
     * @param notification The notification which will be inserted as map.
     */
    fun insertNotificationToPrefs(context: Context, notification: UpcomingNotification) {
        checkAndInitializeNotificationBatchPrefs(context)

        // Create new json object
        val currentNotification = JSONObject(notification.toMap())

        // Get existing notifications
        val notificationsJson =
            mNotificationBatchPrefs!!.getString(PREF_KEY_UPCOMING_NOTIFICATIONS, "[]")
        var notificationsArray: JSONArray? = null
        try {
            notificationsArray = JSONArray(notificationsJson)

            // Remove notifications older than 24 hours
            val last24Time = System.currentTimeMillis() - AppConstants.ONE_DAY_IN_MS

            for (i in 0 until notificationsArray.length()) {
                val timeStamp = notificationsArray.getJSONObject(i).getLong("timeStamp")
                if (timeStamp < last24Time) {
                    notificationsArray.remove(i)
                }
            }
        } catch (e1: Exception) {
            notificationsArray = JSONArray()
        }

        // Insert current notification and update prefs
        notificationsArray!!.put(currentNotification)
        mNotificationBatchPrefs!!.edit()
            .putString(PREF_KEY_UPCOMING_NOTIFICATIONS, notificationsArray.toString()).apply()
    }


    /**
     * Retrieves the list of notification from SharedPreferences as a JSON Array string.
     *
     * @param context The application context used to access SharedPreferences.
     * @return A JSON string representing the stored notifications array.
     */
    fun getSerializedNotificationsJson(context: Context): String {
        checkAndInitializeNotificationBatchPrefs(context)
        return mNotificationBatchPrefs!!.getString(PREF_KEY_UPCOMING_NOTIFICATIONS, "[]")!!
    }
}
