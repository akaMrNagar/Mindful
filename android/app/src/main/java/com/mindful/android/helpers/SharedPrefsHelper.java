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

import android.content.Context;
import android.content.SharedPreferences;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.mindful.android.models.AppRestrictions;
import com.mindful.android.models.BedtimeSettings;
import com.mindful.android.models.RestrictionGroup;
import com.mindful.android.models.WellBeingSettings;
import com.mindful.android.utils.JsonDeserializer;
import com.mindful.android.utils.Utils;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.Calendar;
import java.util.HashMap;
import java.util.HashSet;

/**
 * Helper class to manage SharedPreferences operations.
 * Provides methods to store and retrieve various application settings and data.
 */
public class SharedPrefsHelper {

    private static SharedPreferences mUniquePrefs;
    private static final String UNIQUE_PREFS_BOX = "UniquePrefs";
    private static final String PREF_KEY_NOTIFICATION_PERMISSION_COUNT = "notificationPermissionCount";
    private static final String PREF_KEY_DATA_RESET_TIME_MINS = "dataResetTimeMins";
    private static final String PREF_KEY_SHORTS_SCREEN_TIME = "shortsScreenTime";
    private static final String PREF_KEY_BEDTIME_SETTINGS = "bedtimeSettings";
    public static final String PREF_KEY_WELLBEING_SETTINGS = "wellBeingSettings";
    private static final String PREF_KEY_EXCLUDED_APPS = "excludedApps";

    private static SharedPreferences mAppRestrictionPrefs;
    private static final String APP_RESTRICTION_PREFS_BOX = "AppRestrictionPrefs";
    private static final String PREF_KEY_APP_RESTRICTIONS = "appRestrictions";

    private static SharedPreferences mRestrictionGroupPrefs;
    private static final String RESTRICTION_GROUP_PREFS_BOX = "RestrictionGroupPrefs";
    private static final String PREF_KEY_RESTRICTION_GROUPS = "restrictionGroups";

    private static SharedPreferences mCrashLogPrefs;
    private static final String CRASH_LOG_PREFS_BOX = "CrashLogPrefs";
    private static final String PREF_KEY_CRASH_LOGS = "crashLogs";

    private static void checkAndInitializeUniquePrefs(@NonNull Context context) {
        if (mUniquePrefs != null) return;
        mUniquePrefs = context.getApplicationContext().getSharedPreferences(UNIQUE_PREFS_BOX, Context.MODE_PRIVATE);
    }

    private static void checkAndInitializeAppRestrictionPrefs(@NonNull Context context) {
        if (mAppRestrictionPrefs != null) return;
        mAppRestrictionPrefs = context.getApplicationContext().getSharedPreferences(APP_RESTRICTION_PREFS_BOX, Context.MODE_PRIVATE);
    }

    private static void checkAndInitializeRestrictionGroupPrefs(@NonNull Context context) {
        if (mRestrictionGroupPrefs != null) return;
        mRestrictionGroupPrefs = context.getApplicationContext().getSharedPreferences(RESTRICTION_GROUP_PREFS_BOX, Context.MODE_PRIVATE);
    }

    private static void checkAndInitializeCrashLogPrefs(@NonNull Context context) {
        if (mCrashLogPrefs != null) return;
        mCrashLogPrefs = context.getApplicationContext().getSharedPreferences(CRASH_LOG_PREFS_BOX, Context.MODE_PRIVATE);
    }


    /**
     * Checks and Migrates shared prefs data from old one file to multiple new files.
     *
     * @param context The application context.
     */
    public static void migrateFromOldPrefs(@NonNull Context context) {
        checkAndInitializeUniquePrefs(context);
        boolean isMigrationDone = mUniquePrefs.getBoolean("MigrationDone", false);
        if (isMigrationDone) return;

        // Load unique data
        getSetNotificationAskCount(context, OldPrefsHelper.getNotificationAskCount(context));
        getSetDataResetTimeMins(context, OldPrefsHelper.getDataResetTimeMins(context));
        getSetShortsScreenTimeMs(context, OldPrefsHelper.getShortsScreenTimeMs(context));
        getSetWellBeingSettings(context, OldPrefsHelper.getWellBeingSettingsString(context));
        getSetBedtimeSettings(context, OldPrefsHelper.getBedtimeSettingsString(context));
        getSetExcludedApps(context, OldPrefsHelper.getExcludedAppsString(context));

        // Load app restrictions
        getSetAppRestrictions(context, OldPrefsHelper.getAppRestrictionsString(context));

        // Load restriction groups
        getSetRestrictionGroups(context, OldPrefsHelper.getRestrictionGroupsString(context));

        mUniquePrefs.edit().putBoolean("MigrationDone", true).apply();
    }


    /**
     * Registers or Unregister a listener to/from SharedPreferences changes.
     *
     * @param context        The application context.
     * @param shouldRegister If TRUE the callback will be registered else unregistered.
     * @param callback       The listener to register.
     */
    public static void registerUnregisterListenerToUniquePrefs(Context context, boolean shouldRegister, SharedPreferences.OnSharedPreferenceChangeListener callback) {
        checkAndInitializeUniquePrefs(context);
        try {
            if (shouldRegister) {
                mUniquePrefs.registerOnSharedPreferenceChangeListener(callback);
            } else {
                mUniquePrefs.unregisterOnSharedPreferenceChangeListener(callback);
            }
        } catch (Exception ignored) {
        }
    }

    /**
     * Get the notification permission request count if count is null else store it.
     *
     * @param context The application context.
     * @param count   The number of requests.
     */
    public static int getSetNotificationAskCount(@NonNull Context context, @Nullable Integer count) {
        checkAndInitializeUniquePrefs(context);
        if (count == null) {
            return mUniquePrefs.getInt(PREF_KEY_NOTIFICATION_PERMISSION_COUNT, 0);
        } else {
            mUniquePrefs.edit().putInt(PREF_KEY_NOTIFICATION_PERMISSION_COUNT, count).apply();
            return count;
        }
    }

    /**
     * Get the data reset time in MINUTES if the passed timeInMins is null else store it .
     *
     * @param context    The application context.
     * @param timeInMins The time in minutes.
     * @return Instance of calender set to data reset time for today
     */
    @NonNull
    public static Calendar getSetDataResetTimeMins(@NonNull Context context, @Nullable Integer timeInMins) {
        checkAndInitializeUniquePrefs(context);
        if (timeInMins == null) {
            return Utils.todToTodayCal(mUniquePrefs.getInt(PREF_KEY_DATA_RESET_TIME_MINS, 0));
        } else {
            mUniquePrefs.edit().putInt(PREF_KEY_DATA_RESET_TIME_MINS, timeInMins).apply();
            return Utils.todToTodayCal(timeInMins);
        }
    }


    /**
     * Fetches the hashset of excluded apps if jsonExcludedApps is null else store it's json.
     *
     * @param context          The application context.
     * @param jsonExcludedApps The JSON string of excluded apps.
     */
    @NonNull
    public static HashSet<String> getSetExcludedApps(@NonNull Context context, @Nullable String jsonExcludedApps) {
        checkAndInitializeUniquePrefs(context);
        if (jsonExcludedApps == null) {
            return JsonDeserializer.jsonStrToStringHashSet(mUniquePrefs.getString(PREF_KEY_EXCLUDED_APPS, ""));
        } else {
            mUniquePrefs.edit().putString(PREF_KEY_EXCLUDED_APPS, jsonExcludedApps).apply();
            return JsonDeserializer.jsonStrToStringHashSet(jsonExcludedApps);
        }
    }

    /**
     * Fetches the short content's screen time if screenTime is null else store it's json.
     *
     * @param context    The application context.
     * @param screenTime The short content's screen time.
     */
    public static long getSetShortsScreenTimeMs(@NonNull Context context, @Nullable Long screenTime) {
        checkAndInitializeUniquePrefs(context);
        if (screenTime == null) {
            return mUniquePrefs.getLong(PREF_KEY_SHORTS_SCREEN_TIME, 0L);
        } else {
            mUniquePrefs.edit().putLong(PREF_KEY_SHORTS_SCREEN_TIME, screenTime).apply();
            return screenTime;
        }
    }

    /**
     * Fetches the well-being settings if jsonWellBeingSettings is null else store it's json.
     *
     * @param context               The application context.
     * @param jsonWellBeingSettings The JSON string of well-being settings.
     */
    @NonNull
    public static WellBeingSettings getSetWellBeingSettings(@NonNull Context context, @Nullable String jsonWellBeingSettings) {
        checkAndInitializeUniquePrefs(context);
        if (jsonWellBeingSettings == null) {
            return new WellBeingSettings(mUniquePrefs.getString(PREF_KEY_WELLBEING_SETTINGS, ""));
        } else {
            mUniquePrefs.edit().putString(PREF_KEY_WELLBEING_SETTINGS, jsonWellBeingSettings).apply();
            return new WellBeingSettings(jsonWellBeingSettings);
        }
    }

    /**
     * Fetches the bedtime settings if jsonBedtimeSettings is null else store it's json.
     *
     * @param context             The application context.
     * @param jsonBedtimeSettings The JSON string of bedtime settings.
     */
    @NonNull
    public static BedtimeSettings getSetBedtimeSettings(@NonNull Context context, @Nullable String jsonBedtimeSettings) {
        checkAndInitializeUniquePrefs(context);
        if (jsonBedtimeSettings == null) {
            return new BedtimeSettings(mUniquePrefs.getString(PREF_KEY_BEDTIME_SETTINGS, ""));
        } else {
            mUniquePrefs.edit().putString(PREF_KEY_BEDTIME_SETTINGS, jsonBedtimeSettings).apply();
            return new BedtimeSettings(jsonBedtimeSettings);
        }
    }

    /**
     * Fetches the hashmap of app restrictions if jsonAppRestrictions is null else store it's json.
     *
     * @param context             The application context.
     * @param jsonAppRestrictions The JSON string of hashmap of app restrictions.
     */
    @NonNull
    public static HashMap<String, AppRestrictions> getSetAppRestrictions(@NonNull Context context, @Nullable String jsonAppRestrictions) {
        checkAndInitializeAppRestrictionPrefs(context);
        if (jsonAppRestrictions == null) {
            return JsonDeserializer.jsonStrToAppRestrictionsHashMap(mAppRestrictionPrefs.getString(PREF_KEY_APP_RESTRICTIONS, ""));
        } else {
            mAppRestrictionPrefs.edit().putString(PREF_KEY_APP_RESTRICTIONS, jsonAppRestrictions).apply();
            return JsonDeserializer.jsonStrToAppRestrictionsHashMap(jsonAppRestrictions);
        }
    }

    /**
     * Fetches the hashmap of restriction groups if jsonRestrictionGroups is null else store it's json.
     *
     * @param context               The application context.
     * @param jsonRestrictionGroups The JSON string of hashmap of restriction groups.
     */
    @NonNull
    public static HashMap<Integer, RestrictionGroup> getSetRestrictionGroups(@NonNull Context context, @Nullable String jsonRestrictionGroups) {
        checkAndInitializeRestrictionGroupPrefs(context);
        if (jsonRestrictionGroups == null) {
            return JsonDeserializer.jsonStrToRestrictionGroupsHashMap(mRestrictionGroupPrefs.getString(PREF_KEY_RESTRICTION_GROUPS, ""));
        } else {
            mRestrictionGroupPrefs.edit().putString(PREF_KEY_RESTRICTION_GROUPS, jsonRestrictionGroups).apply();
            return JsonDeserializer.jsonStrToRestrictionGroupsHashMap(jsonRestrictionGroups);
        }
    }

    /**
     * Creates and Inserts a new crash log into SharedPreferences based on the passed exception.
     *
     * @param context   The application context used to retrieve app version and store the log.
     * @param exception The exception that was thrown, which will be logged in the crash log.
     */
    public static void insertCrashLogToPrefs(@NonNull Context context, @NonNull Throwable exception) {
        checkAndInitializeCrashLogPrefs(context);

        // Create new object
        JSONObject currentLog = new JSONObject();
        try {
            currentLog.put("appVersion", Utils.getAppVersion(context));
            currentLog.put("timeStamp", System.currentTimeMillis());
            currentLog.put("error", exception.toString());
            currentLog.put("stackTrace", Log.getStackTraceString(exception));
        } catch (Exception ignored) {
        }

        // Get existing crash logs
        String crashLogsJson = mCrashLogPrefs.getString(PREF_KEY_CRASH_LOGS, "[]");
        JSONArray crashLogsArray;
        try {
            crashLogsArray = new JSONArray(crashLogsJson);
        } catch (Exception e1) {
            crashLogsArray = new JSONArray();
        }

        // Insert current log and update prefs
        crashLogsArray.put(currentLog);

        mCrashLogPrefs.edit().putString(PREF_KEY_CRASH_LOGS, crashLogsArray.toString()).apply();
    }


    /**
     * Retrieves the crash logs from SharedPreferences as a JSON string.
     *
     * @param context The application context used to access SharedPreferences.
     * @return A JSON string representing the stored crash logs array.
     */
    @NonNull
    public static String getCrashLogsArrayString(@NonNull Context context) {
        checkAndInitializeCrashLogPrefs(context);
        return mCrashLogPrefs.getString(PREF_KEY_CRASH_LOGS, "[]");
    }

    /**
     * Clears all the stored crash logs from shared prefs.
     *
     * @param context The application context used to access SharedPreferences.
     */
    public static void clearCrashLogs(@NonNull Context context) {
        checkAndInitializeCrashLogPrefs(context);
        mCrashLogPrefs.edit().putString(PREF_KEY_CRASH_LOGS, "[]").apply();
    }
}
