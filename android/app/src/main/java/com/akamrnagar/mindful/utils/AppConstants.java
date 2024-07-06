package com.akamrnagar.mindful.utils;

public class AppConstants {
    public static final String MY_APP_PACKAGE = "com.akamrnagar.mindful";
    public static final String FLUTTER_METHOD_CHANNEL = "com.akamrnagar.mindful.methodchannel";

    // Related to shared preferences
    // using 'flutter' prefix in each key only in native side but not on flutter side
    public static final String PREFS_SHARED_BOX = "FlutterSharedPreferences";
    public static final String PREF_KEY_APP_TIMERS = "flutter.mindful.appTimers";
    public static final String PREF_KEY_BEDTIME_SETTINGS = "flutter.mindful.bedtimeSettings";

    public static final String PREF_KEY_BLOCKED_APPS = "flutter.mindful.blockedApps";
    public static final String PREF_KEY_BLOCKED_WEBSITES = "flutter.mindful.blockedWebsites";
    public static final String PREF_KEY_SHOULD_BLOCK_SHORTS = "flutter.mindful.shouldBlockShorts";
    public static final String PREF_KEY_SHOULD_BLOCK_NSFW = "flutter.mindful.shouldBlockNsfw";
    public static final String PREF_KEY_IS_DISTRACTION_BLOCKER_ON = "flutter.mindful.isDistractionBlockerOn";
    public static final String PREF_KEY_REDIRECT_URL = "flutter.mindful.redirectUrl";


}
