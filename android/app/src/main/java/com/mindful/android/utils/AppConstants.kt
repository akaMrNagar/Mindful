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
package com.mindful.android.utils

object AppConstants {
    const val FLUTTER_METHOD_CHANNEL_FG: String = "com.mindful.android.methodchannel.fg"
    const val FLUTTER_METHOD_CHANNEL_BG: String = "com.mindful.android.methodchannel.bg"

    const val REMOVED_APP_NAME: String = "Removed Apps"
    const val REMOVED_PACKAGE: String = "com.android.removed"
    const val TETHERING_APP_NAME: String = "Tethering & Hotspot"
    const val TETHERING_PACKAGE: String = "com.android.tethering"

    // Extra intent data
    const val INTENT_EXTRA_IS_SELF_RESTART: String = "com.mindful.android.isSelfRestart"
    const val INTENT_EXTRA_PACKAGE_NAME: String = "com.mindful.android.packageName"

    // Notification IDs
    const val TRACKER_SERVICE_NOTIFICATION_ID: Int = 101
    const val VPN_SERVICE_NOTIFICATION_ID: Int = 102
    const val OVERLAY_SERVICE_NOTIFICATION_ID: Int = 103
    const val EMERGENCY_PAUSE_SERVICE_NOTIFICATION_ID: Int = 104
    const val FOCUS_SESSION_SERVICE_NOTIFICATION_ID: Int = 105
    const val BEDTIME_ROUTINE_NOTIFICATION_ID: Int = 106
    const val NOTIFICATION_BATCH_SCHEDULE_NOTIFICATION_ID: Int = 107

    const val SETTINGS_PACKAGE: String = "com.android.settings"

    // Platforms package names
    const val SYSTEM_SETTINGS_PACKAGE: String = "com.android.settings"
    const val INSTAGRAM_PACKAGE: String = "com.instagram.android"
    const val YOUTUBE_PACKAGE: String = "com.google.android.youtube"
    const val YOUTUBE_CLIENT_PACKAGE_SUFFIX: String = ".android.youtube"
    const val SNAPCHAT_PACKAGE: String = "com.snapchat.android"
    const val FACEBOOK_PACKAGE: String = "com.facebook.katana"
    const val REDDIT_PACKAGE: String = "com.reddit.frontpage"

    // Static const
    /**
     * Total milliseconds in one day or 24 hours precise.
     */
    const val ONE_DAY_IN_MS: Long = (24 * 60 * 60 * 1000).toLong()
}
