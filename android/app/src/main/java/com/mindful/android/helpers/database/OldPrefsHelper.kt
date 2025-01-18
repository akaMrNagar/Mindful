package com.mindful.android.helpers.database

import android.content.Context
import android.content.SharedPreferences

object OldPrefsHelper {
    private var mSharedPrefs: SharedPreferences? = null
    private const val PREFS_SHARED_BOX = "MindfulSharedPreferences"
    private const val PREF_KEY_NOTIFICATION_PERMISSION_COUNT = "mindful.notificationPermissionCount"
    private const val PREF_KEY_DATA_RESET_TIME_MINS = "mindful.dataResetTimeMins"
    private const val PREF_KEY_SHORTS_SCREEN_TIME = "mindful.shortsScreenTime"
    private const val PREF_KEY_EXCLUDED_APPS = "mindful.excludedApps"
    private const val PREF_KEY_APP_RESTRICTIONS = "mindful.appRestrictions"
    private const val PREF_KEY_RESTRICTION_GROUPS = "mindful.restrictionGroups"
    private const val PREF_KEY_BEDTIME_SETTINGS = "mindful.bedtimeSettings"
    private const val PREF_KEY_WELLBEING_SETTINGS: String = "mindful.wellBeingSettings"

    private fun checkAndInitializePrefs(context: Context) {
        if (mSharedPrefs != null) return
        mSharedPrefs =
            context.applicationContext.getSharedPreferences(PREFS_SHARED_BOX, Context.MODE_PRIVATE)
    }


    fun getNotificationAskCount(context: Context): Int {
        checkAndInitializePrefs(context)
        return mSharedPrefs!!.getInt(PREF_KEY_NOTIFICATION_PERMISSION_COUNT, 0)
    }

    fun getDataResetTimeMins(context: Context): Int {
        checkAndInitializePrefs(context)
        return mSharedPrefs!!.getInt(PREF_KEY_DATA_RESET_TIME_MINS, 0)
    }

    fun getExcludedAppsString(context: Context): String {
        checkAndInitializePrefs(context)
        return mSharedPrefs!!.getString(PREF_KEY_EXCLUDED_APPS, "")!!
    }


    fun getShortsScreenTimeMs(context: Context): Long {
        checkAndInitializePrefs(context)
        return mSharedPrefs!!.getLong(PREF_KEY_SHORTS_SCREEN_TIME, 0L)
    }


    fun getAppRestrictionsString(context: Context): String {
        checkAndInitializePrefs(context)
        return mSharedPrefs!!.getString(PREF_KEY_APP_RESTRICTIONS, "")!!
    }


    fun getRestrictionGroupsString(context: Context): String {
        checkAndInitializePrefs(context)
        return mSharedPrefs!!.getString(PREF_KEY_RESTRICTION_GROUPS, "")!!
    }


    fun getWellBeingSettingsString(context: Context): String {
        checkAndInitializePrefs(context)
        return mSharedPrefs!!.getString(PREF_KEY_WELLBEING_SETTINGS, "")!!
    }


    fun getBedtimeSettingsString(context: Context): String {
        checkAndInitializePrefs(context)
        return mSharedPrefs!!.getString(PREF_KEY_BEDTIME_SETTINGS, "")!!
    }
}
