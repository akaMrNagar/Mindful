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

public class SharedPrefsHelper {
    private static SharedPreferences mSharedPrefs;

    private static final String PREFS_SHARED_BOX = "MindfulSharedPreferences";
    private static final String PREF_KEY_EMERGENCY_PASSES_COUNT = "mindful.emergencyPassesCount";
    private static final String PREF_KEY_NOTIFICATION_PERMISSION_COUNT = "mindful.notificationPermissionCount";
    private static final String PREF_KEY_DATA_RESET_TIME_MINS = "mindful.dataResetTimeMins";
    private static final String PREF_KEY_BLOCKED_APPS = "mindful.blockedApps";
    private static final String PREF_KEY_APP_TIMERS = "mindful.appTimers";
    private static final String PREF_KEY_BEDTIME_SETTINGS = "mindful.bedtimeSettings";
    public static final String PREF_KEY_WELLBEING_SETTINGS = "mindful.wellBeingSettings";
    public static final String PREF_KEY_SHORTS_SCREEN_TIME = "mindful.shortsScreenTime";


    private static void initialize(@NonNull Context context) {
        mSharedPrefs = context.getApplicationContext().getSharedPreferences(PREFS_SHARED_BOX, Context.MODE_PRIVATE);
    }

    public static void registerListener(SharedPreferences.OnSharedPreferenceChangeListener callback) {
        mSharedPrefs.registerOnSharedPreferenceChangeListener(callback);
    }

    public static void unregisterListener(SharedPreferences.OnSharedPreferenceChangeListener callback) {
        mSharedPrefs.unregisterOnSharedPreferenceChangeListener(callback);
    }

    public static void storeDataResetTimeMins(@NonNull Context context, int timeInMins) {
        if (mSharedPrefs == null) initialize(context);
        mSharedPrefs.edit().putInt(PREF_KEY_DATA_RESET_TIME_MINS, timeInMins).apply();
    }

    public static void storeNotificationAskCount(@NonNull Context context, int count) {
        if (mSharedPrefs == null) initialize(context);
        mSharedPrefs.edit().putInt(PREF_KEY_NOTIFICATION_PERMISSION_COUNT, count).apply();
    }


    public static void storeEmergencyPassesCount(@NonNull Context context, int passesLeftCount) {
        if (mSharedPrefs == null) initialize(context);
        mSharedPrefs.edit().putInt(PREF_KEY_EMERGENCY_PASSES_COUNT, passesLeftCount).apply();
    }

    public static void storeBlockedAppsJson(@NonNull Context context, @NonNull String dartJsonBlockedApps) {
        if (mSharedPrefs == null) initialize(context);
        mSharedPrefs.edit().putString(PREF_KEY_BLOCKED_APPS, dartJsonBlockedApps).apply();
    }

    public static void storeAppTimersJson(@NonNull Context context, @NonNull String dartJsonAppTimers) {
        if (mSharedPrefs == null) initialize(context);
        mSharedPrefs.edit().putString(PREF_KEY_APP_TIMERS, dartJsonAppTimers).apply();
    }

    public static void storeBedtimeSettingsJson(@NonNull Context context, @NonNull String dartJsonBedtimeSettings) {
        if (mSharedPrefs == null) initialize(context);
        mSharedPrefs.edit().putString(PREF_KEY_BEDTIME_SETTINGS, dartJsonBedtimeSettings).apply();
    }

    public static void storeWellBeingSettingsJson(@NonNull Context context, @NonNull String dartJsonWellBeingSettings) {
        if (mSharedPrefs == null) initialize(context);
        mSharedPrefs.edit().putString(PREF_KEY_WELLBEING_SETTINGS, dartJsonWellBeingSettings).apply();
    }

    public static void storeShortsScreenTimeMs(@NonNull Context context, long screenTime) {
        if (mSharedPrefs == null) initialize(context);
        mSharedPrefs.edit().putLong(PREF_KEY_SHORTS_SCREEN_TIME, screenTime).apply();
    }

    public static int fetchDataResetTimeMins(@NonNull Context context) {
        if (mSharedPrefs == null) initialize(context);
        return mSharedPrefs.getInt(PREF_KEY_DATA_RESET_TIME_MINS, 0);
    }

    public static int fetchNotificationAskCount(@NonNull Context context) {
        if (mSharedPrefs == null) initialize(context);
        return mSharedPrefs.getInt(PREF_KEY_NOTIFICATION_PERMISSION_COUNT, 0);
    }

    public static int fetchEmergencyPassesCount(@NonNull Context context) {
        if (mSharedPrefs == null) initialize(context);
        return mSharedPrefs.getInt(PREF_KEY_EMERGENCY_PASSES_COUNT, AppConstants.DEFAULT_EMERGENCY_PASSES_COUNT);
    }

    @NonNull
    public static HashSet<String> fetchBlockedApps(@NonNull Context context) {
        if (mSharedPrefs == null) initialize(context);
        return Utils.jsonStrToStringHashSet(mSharedPrefs.getString(PREF_KEY_BLOCKED_APPS, ""));
    }

    @NonNull
    public static HashMap<String, Long> fetchAppTimers(@NonNull Context context) {
        if (mSharedPrefs == null) initialize(context);
        return Utils.jsonStrToStringLongHashMap(mSharedPrefs.getString(PREF_KEY_APP_TIMERS, ""));
    }

    @NonNull
    @Contract("_ -> new")
    public static BedtimeSettings fetchBedtimeSettings(@NonNull Context context) {
        if (mSharedPrefs == null) initialize(context);
        return new BedtimeSettings(mSharedPrefs.getString(PREF_KEY_BEDTIME_SETTINGS, ""));
    }

    @NonNull
    @Contract("_ -> new")
    public static WellBeingSettings fetchWellBeingSettings(@NonNull Context context) {
        if (mSharedPrefs == null) initialize(context);
        return new WellBeingSettings(mSharedPrefs.getString(PREF_KEY_WELLBEING_SETTINGS, ""));
    }

    public static long fetchShortsScreenTimeMs(@NonNull Context context) {
        if (mSharedPrefs == null) initialize(context);
        return mSharedPrefs.getLong(PREF_KEY_SHORTS_SCREEN_TIME, 0L);
    }
}
