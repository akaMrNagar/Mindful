package com.mindful.android.helpers;

import android.content.Context;
import android.content.SharedPreferences;

import androidx.annotation.NonNull;

public class OldPrefsHelper {
    private static SharedPreferences mSharedPrefs;
    private static final String PREFS_SHARED_BOX = "MindfulSharedPreferences";
    private static final String PREF_KEY_NOTIFICATION_PERMISSION_COUNT = "mindful.notificationPermissionCount";
    private static final String PREF_KEY_DATA_RESET_TIME_MINS = "mindful.dataResetTimeMins";
    private static final String PREF_KEY_SHORTS_SCREEN_TIME = "mindful.shortsScreenTime";
    private static final String PREF_KEY_EXCLUDED_APPS = "mindful.excludedApps";
    private static final String PREF_KEY_APP_RESTRICTIONS = "mindful.appRestrictions";
    private static final String PREF_KEY_RESTRICTION_GROUPS = "mindful.restrictionGroups";
    private static final String PREF_KEY_BEDTIME_SETTINGS = "mindful.bedtimeSettings";
    public static final String PREF_KEY_WELLBEING_SETTINGS = "mindful.wellBeingSettings";

    private static void checkAndInitializePrefs(@NonNull Context context) {
        if (mSharedPrefs != null) return;
        mSharedPrefs = context.getApplicationContext().getSharedPreferences(PREFS_SHARED_BOX, Context.MODE_PRIVATE);
    }


    public static int getNotificationAskCount(@NonNull Context context) {
        checkAndInitializePrefs(context);
        return mSharedPrefs.getInt(PREF_KEY_NOTIFICATION_PERMISSION_COUNT, 0);
    }

    public static int getDataResetTimeMins(@NonNull Context context) {
        checkAndInitializePrefs(context);
        return mSharedPrefs.getInt(PREF_KEY_DATA_RESET_TIME_MINS, 0);
    }

    @NonNull
    public static String getExcludedAppsString(@NonNull Context context) {
        checkAndInitializePrefs(context);
        return mSharedPrefs.getString(PREF_KEY_EXCLUDED_APPS, "");
    }


    public static long getShortsScreenTimeMs(@NonNull Context context) {
        checkAndInitializePrefs(context);
        return mSharedPrefs.getLong(PREF_KEY_SHORTS_SCREEN_TIME, 0L);
    }


    @NonNull
    public static String getAppRestrictionsString(@NonNull Context context) {
        checkAndInitializePrefs(context);
        return mSharedPrefs.getString(PREF_KEY_APP_RESTRICTIONS, "");
    }


    @NonNull
    public static String getRestrictionGroupsString(@NonNull Context context) {
        checkAndInitializePrefs(context);
        return mSharedPrefs.getString(PREF_KEY_RESTRICTION_GROUPS, "");
    }


    @NonNull
    public static String getWellBeingSettingsString(@NonNull Context context) {
        checkAndInitializePrefs(context);
        return mSharedPrefs.getString(PREF_KEY_WELLBEING_SETTINGS, "");
    }


    @NonNull
    public static String getBedtimeSettingsString(@NonNull Context context) {
        checkAndInitializePrefs(context);
        return mSharedPrefs.getString(PREF_KEY_BEDTIME_SETTINGS, "");

    }

}
