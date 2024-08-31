/*
 *
 *  * Copyright (c) 2024 Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

package com.mindful.android.utils;

public class AppConstants {
    public static final String FLUTTER_METHOD_CHANNEL = "com.mindful.android.methodchannel";

    public static final String TIMER_APP_PAUSE_MESSAGE = "You've hit your daily limit on this app. Embrace this opportunity to supercharge your productivity.";
    public static final String BEDTIME_APP_PAUSE_MESSAGE = "It's bedtime! This app is paused for the night to help you unwind and prepare for a peaceful sleep.";
    public static final String FOCUS_SESSION_APP_PAUSE_MESSAGE = "It's focus time! This app is paused to help you stay on track and make the most of your session.";

    public static final int DEFAULT_EMERGENCY_PASSES_COUNT = 3;
    public static final int DEFAULT_EMERGENCY_PASS_PERIOD_MS = 5 * 60 * 1000;
    public static final long WIDGET_MANUAL_REFRESH_INTERVAL = 60 * 1000; // 1 minute


    /// Notification IDs
    public static final int TRACKER_SERVICE_NOTIFICATION_ID = 301;
    public static final int VPN_SERVICE_NOTIFICATION_ID = 302;
    public static final int OVERLAY_SERVICE_NOTIFICATION_ID = 303;
    public static final int EMERGENCY_PAUSE_SERVICE_NOTIFICATION_ID = 304;
    public static final int FOCUS_SESSION_SERVICE_NOTIFICATION_ID = 305;
    public static final int BEDTIME_ROUTINE_NOTIFICATION_ID = 306;
}
