package com.akamrnagar.mindful.helpers;

import android.content.Context;
import android.content.SharedPreferences;

import androidx.annotation.NonNull;

import com.akamrnagar.mindful.models.BedtimeSettings;
import com.akamrnagar.mindful.models.WellBeingSettings;
import com.akamrnagar.mindful.utils.Utils;

import org.jetbrains.annotations.Contract;

import java.util.HashMap;
import java.util.HashSet;

public class SharedPrefsHelper {
    private static SharedPreferences mSharedPrefs;

    private static final String PREFS_SHARED_BOX = "FlutterSharedPreferences";
    private static final String PREF_KEY_BLOCKED_APPS = "flutter.mindful.blockedApps";
    private static final String PREF_KEY_APP_TIMERS = "flutter.mindful.appTimers";
    private static final String PREF_KEY_BEDTIME_SETTINGS = "flutter.mindful.bedtimeSettings";
    public static final String PREF_KEY_WELLBEING_SETTINGS = "flutter.mindful.wellBeingSettings";


    private static void initialize(@NonNull Context context) {
        mSharedPrefs = context.getSharedPreferences(PREFS_SHARED_BOX, Context.MODE_PRIVATE);
    }

    public static void registerListener(SharedPreferences.OnSharedPreferenceChangeListener callback) {
        mSharedPrefs.registerOnSharedPreferenceChangeListener(callback);
    }

    public static void unregisterListener(SharedPreferences.OnSharedPreferenceChangeListener callback) {
        mSharedPrefs.unregisterOnSharedPreferenceChangeListener(callback);
    }

    public static void storeBlockedApps(@NonNull Context context, @NonNull String dartJsonBlockedApps) {
        if (mSharedPrefs == null) initialize(context);
        mSharedPrefs.edit().putString(PREF_KEY_BLOCKED_APPS, dartJsonBlockedApps).apply();
    }

    public static void storeAppTimers(@NonNull Context context, @NonNull String dartJsonAppTimers) {
        if (mSharedPrefs == null) initialize(context);
        mSharedPrefs.edit().putString(PREF_KEY_APP_TIMERS, dartJsonAppTimers).apply();
    }

    public static void storeBedtimeSettings(@NonNull Context context, @NonNull String dartJsonBedtimeSettings) {
        if (mSharedPrefs == null) initialize(context);
        mSharedPrefs.edit().putString(PREF_KEY_BEDTIME_SETTINGS, dartJsonBedtimeSettings).apply();
    }

    public static void storeWellBeingSettings(@NonNull Context context, @NonNull String dartJsonWellBeingSettings) {
        if (mSharedPrefs == null) initialize(context);
        mSharedPrefs.edit().putString(PREF_KEY_WELLBEING_SETTINGS, dartJsonWellBeingSettings).apply();
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
}
