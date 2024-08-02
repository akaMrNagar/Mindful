package com.mindful.android.helpers;

import android.content.Context;
import android.content.SharedPreferences;

import androidx.annotation.NonNull;

import com.mindful.android.models.BedtimeSettings;
import com.mindful.android.models.WellBeingSettings;
import com.mindful.android.utils.AppConstants;
import com.mindful.android.utils.Utils;

import org.jetbrains.annotations.Contract;

import java.util.HashMap;
import java.util.HashSet;

/**
 * Helper class to manage SharedPreferences operations.
 * Provides methods to store and retrieve various application settings and data.
 */
public class SharedPrefsHelper {
    private static SharedPreferences mSharedPrefs;
    private static final String PREFS_SHARED_BOX = "MindfulSharedPreferences";
    private static final String PREF_KEY_EMERGENCY_PASSES_COUNT = "mindful.emergencyPassesCount";
    private static final String PREF_KEY_NOTIFICATION_PERMISSION_COUNT = "mindful.notificationPermissionCount";
    private static final String PREF_KEY_DATA_RESET_TIME_MINS = "mindful.dataResetTimeMins";
    private static final String PREF_KEY_BLOCKED_APPS = "mindful.blockedApps";
    private static final String PREF_KEY_APP_TIMERS = "mindful.appTimers";
    private static final String PREF_KEY_BEDTIME_SETTINGS = "mindful.bedtimeSettings";
    private static final String PREF_KEY_SHORTS_SCREEN_TIME = "mindful.shortsScreenTime";
    public static final String PREF_KEY_WELLBEING_SETTINGS = "mindful.wellBeingSettings";

    private static void initialize(@NonNull Context context) {
        mSharedPrefs = context.getApplicationContext().getSharedPreferences(PREFS_SHARED_BOX, Context.MODE_PRIVATE);
    }

    /**
     * Registers a listener for SharedPreferences changes.
     *
     * @param context  The application context.
     * @param callback The listener to register.
     */
    public static void registerListener(Context context, SharedPreferences.OnSharedPreferenceChangeListener callback) {
        if (mSharedPrefs == null) initialize(context);
        mSharedPrefs.registerOnSharedPreferenceChangeListener(callback);
    }

    /**
     * Unregisters a listener for SharedPreferences changes.
     *
     * @param context  The application context.
     * @param callback The listener to unregister.
     */
    public static void unregisterListener (Context context, SharedPreferences.OnSharedPreferenceChangeListener callback) {
        if (mSharedPrefs == null) initialize(context);
        mSharedPrefs.unregisterOnSharedPreferenceChangeListener(callback);
    }

    /**
     * Stores the data reset time in minutes.
     *
     * @param context    The application context.
     * @param timeInMins The time in minutes.
     */
    public static void storeDataResetTimeMins(@NonNull Context context, int timeInMins) {
        if (mSharedPrefs == null) initialize(context);
        mSharedPrefs.edit().putInt(PREF_KEY_DATA_RESET_TIME_MINS, timeInMins).apply();
    }

    /**
     * Stores the count of notification permission requests.
     *
     * @param context The application context.
     * @param count   The number of requests.
     */
    public static void storeNotificationAskCount(@NonNull Context context, int count) {
        if (mSharedPrefs == null) initialize(context);
        mSharedPrefs.edit().putInt(PREF_KEY_NOTIFICATION_PERMISSION_COUNT, count).apply();
    }

    /**
     * Stores the count of emergency passes.
     *
     * @param context         The application context.
     * @param passesLeftCount The number of emergency passes left.
     */
    public static void storeEmergencyPassesCount(@NonNull Context context, int passesLeftCount) {
        if (mSharedPrefs == null) initialize(context);
        mSharedPrefs.edit().putInt(PREF_KEY_EMERGENCY_PASSES_COUNT, passesLeftCount).apply();
    }

    /**
     * Stores the JSON representation of blocked apps.
     *
     * @param context             The application context.
     * @param dartJsonBlockedApps The JSON string of blocked apps.
     */
    public static void storeBlockedAppsJson(@NonNull Context context, @NonNull String dartJsonBlockedApps) {
        if (mSharedPrefs == null) initialize(context);
        mSharedPrefs.edit().putString(PREF_KEY_BLOCKED_APPS, dartJsonBlockedApps).apply();
    }

    /**
     * Stores the JSON representation of app timers.
     *
     * @param context           The application context.
     * @param dartJsonAppTimers The JSON string of app timers.
     */
    public static void storeAppTimersJson(@NonNull Context context, @NonNull String dartJsonAppTimers) {
        if (mSharedPrefs == null) initialize(context);
        mSharedPrefs.edit().putString(PREF_KEY_APP_TIMERS, dartJsonAppTimers).apply();
    }

    /**
     * Stores the JSON representation of bedtime settings.
     *
     * @param context                 The application context.
     * @param dartJsonBedtimeSettings The JSON string of bedtime settings.
     */
    public static void storeBedtimeSettingsJson(@NonNull Context context, @NonNull String dartJsonBedtimeSettings) {
        if (mSharedPrefs == null) initialize(context);
        mSharedPrefs.edit().putString(PREF_KEY_BEDTIME_SETTINGS, dartJsonBedtimeSettings).apply();
    }

    /**
     * Stores the JSON representation of well-being settings.
     *
     * @param context                   The application context.
     * @param dartJsonWellBeingSettings The JSON string of well-being settings.
     */
    public static void storeWellBeingSettingsJson(@NonNull Context context, @NonNull String dartJsonWellBeingSettings) {
        if (mSharedPrefs == null) initialize(context);
        mSharedPrefs.edit().putString(PREF_KEY_WELLBEING_SETTINGS, dartJsonWellBeingSettings).apply();
    }

    /**
     * Stores the screen time in milliseconds for shorts.
     *
     * @param context    The application context.
     * @param screenTime The screen time in milliseconds.
     */
    public static void storeShortsScreenTimeMs(@NonNull Context context, long screenTime) {
        if (mSharedPrefs == null) initialize(context);
        mSharedPrefs.edit().putLong(PREF_KEY_SHORTS_SCREEN_TIME, screenTime).apply();
    }

    /**
     * Fetches the data reset time in minutes.
     *
     * @param context The application context.
     * @return The time in minutes.
     */
    public static int fetchDataResetTimeMins(@NonNull Context context) {
        if (mSharedPrefs == null) initialize(context);
        return mSharedPrefs.getInt(PREF_KEY_DATA_RESET_TIME_MINS, 0);
    }

    /**
     * Fetches the count of notification permission requests.
     *
     * @param context The application context.
     * @return The number of requests.
     */
    public static int fetchNotificationAskCount(@NonNull Context context) {
        if (mSharedPrefs == null) initialize(context);
        return mSharedPrefs.getInt(PREF_KEY_NOTIFICATION_PERMISSION_COUNT, 0);
    }

    /**
     * Fetches the count of emergency passes.
     *
     * @param context The application context.
     * @return The number of emergency passes left.
     */
    public static int fetchEmergencyPassesCount(@NonNull Context context) {
        if (mSharedPrefs == null) initialize(context);
        return mSharedPrefs.getInt(PREF_KEY_EMERGENCY_PASSES_COUNT, AppConstants.DEFAULT_EMERGENCY_PASSES_COUNT);
    }

    /**
     * Fetches the blocked apps as a HashSet of package names.
     *
     * @param context The application context.
     * @return The HashSet of blocked apps.
     */
    @NonNull
    public static HashSet<String> fetchBlockedApps(@NonNull Context context) {
        if (mSharedPrefs == null) initialize(context);
        return Utils.jsonStrToStringHashSet(mSharedPrefs.getString(PREF_KEY_BLOCKED_APPS, ""));
    }

    /**
     * Fetches the app timers as a HashMap of package names to their respective timer values.
     *
     * @param context The application context.
     * @return The HashMap of app timers.
     */
    @NonNull
    public static HashMap<String, Long> fetchAppTimers(@NonNull Context context) {
        if (mSharedPrefs == null) initialize(context);
        return Utils.jsonStrToStringLongHashMap(mSharedPrefs.getString(PREF_KEY_APP_TIMERS, ""));
    }

    /**
     * Fetches the bedtime settings.
     *
     * @param context The application context.
     * @return The BedtimeSettings object.
     */
    @NonNull
    @Contract("_ -> new")
    public static BedtimeSettings fetchBedtimeSettings(@NonNull Context context) {
        if (mSharedPrefs == null) initialize(context);
        return new BedtimeSettings(mSharedPrefs.getString(PREF_KEY_BEDTIME_SETTINGS, ""));
    }

    /**
     * Fetches the well-being settings.
     *
     * @param context The application context.
     * @return The WellBeingSettings object.
     */
    @NonNull
    @Contract("_ -> new")
    public static WellBeingSettings fetchWellBeingSettings(@NonNull Context context) {
        if (mSharedPrefs == null) initialize(context);
        return new WellBeingSettings(mSharedPrefs.getString(PREF_KEY_WELLBEING_SETTINGS, ""));
    }

    /**
     * Fetches the screen time for shorts in milliseconds.
     *
     * @param context The application context.
     * @return The screen time in milliseconds.
     */
    public static long fetchShortsScreenTimeMs(@NonNull Context context) {
        if (mSharedPrefs == null) initialize(context);
        return mSharedPrefs.getLong(PREF_KEY_SHORTS_SCREEN_TIME, 0L);
    }
}
