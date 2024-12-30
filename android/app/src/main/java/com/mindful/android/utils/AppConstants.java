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

package com.mindful.android.utils;

public class AppConstants {
    public static final String FLUTTER_METHOD_CHANNEL = "com.mindful.android.methodchannel";

    // Extra intent data
    public static final String INTENT_EXTRA_IS_SELF_RESTART = "com.mindful.android.isSelfRestart";
    public static final String INTENT_EXTRA_INITIAL_ROUTE = "com.mindful.android.initialRoute";
    public static final String INTENT_EXTRA_PACKAGE_NAME = "com.mindful.android.launchedAppPackageName";
    public static final String INTENT_EXTRA_DIALOG_INFO = "com.mindful.android.dialogInformation";
    public static final String INTENT_EXTRA_MAX_PROGRESS = "com.mindful.android.maxProgress";
    public static final String INTENT_EXTRA_PROGRESS = "com.mindful.android.progress";


    // Notification IDs
    public static final int TRACKER_SERVICE_NOTIFICATION_ID = 101;
    public static final int VPN_SERVICE_NOTIFICATION_ID = 102;
    public static final int OVERLAY_SERVICE_NOTIFICATION_ID = 103;
    public static final int EMERGENCY_PAUSE_SERVICE_NOTIFICATION_ID = 104;
    public static final int FOCUS_SESSION_SERVICE_NOTIFICATION_ID = 105;
    public static final int BEDTIME_ROUTINE_NOTIFICATION_ID = 106;
    public static final int NOTIFICATION_BATCH_SCHEDULE_NOTIFICATION_ID = 107;

    // Static consts
    /**
     * Total milliseconds in one day or 24 hours precise.
     */
    public static final long ONE_DAY_IN_MS = 24 * 60 * 60 * 1000;
}
