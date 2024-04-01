package com.akamrnagar.mindful.utils;

public class AppConstants {
    public static final String MY_APP_PACKAGE = "com.akamrnagar.mindful";
    public static final String ERROR_TAG = "[MINDFUL NATIVE ERROR]";
    public static final String DEBUG_TAG = "[MINDFUL NATIVE LOG]";
    public static final String FLUTTER_METHOD_CHANNEL = "com.akamrnagar.mindful.methodchannel";

    // Related to shared preferences
    // using 'flutter' prefix in each key only in native side but not on flutter side
    public static final String PREFS_BOX = "FlutterSharedPreferences";
    public static final String PREF_KEY_APP_TIMERS = "flutter.mindful.apptimers";
    public static final String PREF_BEDTIME_INFO = "flutter.mindful.bedtimeInfo";


    /// Worker task tags
    public static final String WORKER_TAG_BEDTIME_START = "mindful.worker.bedtime.task.start";
    public static final String WORKER_TAG_BEDTIME_END = "mindful.worker.bedtime.task.end";


}
