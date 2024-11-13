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

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.mindful.android.models.AppRestrictions;
import com.mindful.android.models.BedtimeSettings;
import com.mindful.android.models.RestrictionGroup;
import com.mindful.android.models.WellBeingSettings;
import com.mindful.android.utils.JsonDeserializer;

import java.util.Calendar;
import java.util.HashMap;

/**
 * Helper class to manage SharedPreferences operations.
 * Provides methods to store and retrieve various application settings and data.
 */
public class SharedPrefsHelper {
    private static SharedPreferences mSharedPrefs;
    private static final String PREFS_SHARED_BOX = "MindfulSharedPreferences";
    private static final String PREF_KEY_NOTIFICATION_PERMISSION_COUNT = "mindful.notificationPermissionCount";
    private static final String PREF_KEY_DATA_RESET_TIME_MINS = "mindful.dataResetTimeMins";
    private static final String PREF_KEY_SHORTS_SCREEN_TIME = "mindful.shortsScreenTime";
    private static final String PREF_KEY_APP_RESTRICTIONS = "mindful.appRestrictions";
    private static final String PREF_KEY_RESTRICTION_GROUPS = "mindful.restrictionGroups";
    private static final String PREF_KEY_BEDTIME_SETTINGS = "mindful.bedtimeSettings";
    public static final String PREF_KEY_WELLBEING_SETTINGS = "mindful.wellBeingSettings";

    private static void checkAndInitializePrefs(@NonNull Context context) {
        if (mSharedPrefs != null) return;
        mSharedPrefs = context.getApplicationContext().getSharedPreferences(PREFS_SHARED_BOX, Context.MODE_PRIVATE);
    }


    /**
     * Registers or Unregister a listener to/from SharedPreferences changes.
     *
     * @param context        The application context.
     * @param shouldRegister If TRUE the callback will be registered else unregistered.
     * @param callback       The listener to register.
     */
    public static void registerUnregisterListener(Context context, boolean shouldRegister, SharedPreferences.OnSharedPreferenceChangeListener callback) {
        checkAndInitializePrefs(context);
        try {
            if (shouldRegister) {
                mSharedPrefs.registerOnSharedPreferenceChangeListener(callback);
            } else {
                mSharedPrefs.unregisterOnSharedPreferenceChangeListener(callback);
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
        checkAndInitializePrefs(context);
        if (count == null) {
            return mSharedPrefs.getInt(PREF_KEY_NOTIFICATION_PERMISSION_COUNT, 0);
        } else {
            mSharedPrefs.edit().putInt(PREF_KEY_NOTIFICATION_PERMISSION_COUNT, count).apply();
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
        checkAndInitializePrefs(context);
        if (timeInMins == null) {
            timeInMins = mSharedPrefs.getInt(PREF_KEY_DATA_RESET_TIME_MINS, 0);
        } else {
            mSharedPrefs.edit().putInt(PREF_KEY_DATA_RESET_TIME_MINS, timeInMins).apply();
        }

        Calendar dataUsageCal = Calendar.getInstance();
        dataUsageCal.set(Calendar.HOUR_OF_DAY, timeInMins / 60);
        dataUsageCal.set(Calendar.MINUTE, timeInMins % 60);
        dataUsageCal.set(Calendar.SECOND, 0);
        dataUsageCal.set(Calendar.MILLISECOND, 0);

        return dataUsageCal;
    }


    /**
     * Stores the screen time in milliseconds for shorts.
     *
     * @param context    The application context.
     * @param screenTime The screen time in milliseconds.
     */
    public static long getSetShortsScreenTimeMs(@NonNull Context context, @Nullable Long screenTime) {
        checkAndInitializePrefs(context);
        if (screenTime == null) {
            return mSharedPrefs.getLong(PREF_KEY_SHORTS_SCREEN_TIME, 0L);
        } else {
            mSharedPrefs.edit().putLong(PREF_KEY_SHORTS_SCREEN_TIME, screenTime).apply();
            return screenTime;
        }
    }


    @NonNull
    public static HashMap<String, AppRestrictions> getSetAppRestrictions(@NonNull Context context, @Nullable String jsonAppRestrictions) {
        checkAndInitializePrefs(context);
        if (jsonAppRestrictions == null) {
            return JsonDeserializer.jsonStrToAppRestrictionsHashMap(mSharedPrefs.getString(PREF_KEY_APP_RESTRICTIONS, ""));
        } else {
            mSharedPrefs.edit().putString(PREF_KEY_APP_RESTRICTIONS, jsonAppRestrictions).apply();
            return JsonDeserializer.jsonStrToAppRestrictionsHashMap(jsonAppRestrictions);
        }
    }

    @NonNull
    public static HashMap<Integer, RestrictionGroup> getSetRestrictionGroups(@NonNull Context context, @Nullable String jsonRestrictionGroups) {
        checkAndInitializePrefs(context);
        if (jsonRestrictionGroups == null) {
            return JsonDeserializer.jsonStrToRestrictionGroupsHashMap(mSharedPrefs.getString(PREF_KEY_RESTRICTION_GROUPS, ""));
        } else {
            mSharedPrefs.edit().putString(PREF_KEY_RESTRICTION_GROUPS, jsonRestrictionGroups).apply();
            return JsonDeserializer.jsonStrToRestrictionGroupsHashMap(jsonRestrictionGroups);
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
        checkAndInitializePrefs(context);
        if (jsonWellBeingSettings == null) {
            return new WellBeingSettings(mSharedPrefs.getString(PREF_KEY_WELLBEING_SETTINGS, ""));
        } else {
            mSharedPrefs.edit().putString(PREF_KEY_WELLBEING_SETTINGS, jsonWellBeingSettings).apply();
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
        checkAndInitializePrefs(context);
        if (jsonBedtimeSettings == null) {
            return new BedtimeSettings(mSharedPrefs.getString(PREF_KEY_BEDTIME_SETTINGS, ""));
        } else {
            mSharedPrefs.edit().putString(PREF_KEY_BEDTIME_SETTINGS, jsonBedtimeSettings).apply();
            return new BedtimeSettings(jsonBedtimeSettings);
        }
    }


}
