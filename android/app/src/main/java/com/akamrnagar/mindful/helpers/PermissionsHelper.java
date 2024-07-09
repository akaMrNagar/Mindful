package com.akamrnagar.mindful.helpers;

import android.app.NotificationManager;
import android.content.Context;

import androidx.annotation.NonNull;

import com.akamrnagar.mindful.services.MindfulAccessibilityService;

public class PermissionsHelper {

    public static boolean getAndAskAccessibilityPermission(@NonNull Context context, boolean askPermissionToo) {
        if (ServicesHelper.isServiceRunning(context, MindfulAccessibilityService.class.getName())) {
            return true;
        }

        if (askPermissionToo) ActivityNewTaskHelper.openMindfulAccessibilitySection(context);
        return false;
    }
//    private boolean isVpnPrepared() {
//        Intent intent = MindfulVpnService.prepare(this);
//        if (intent == null) {
//            return true;
//        } else {
//            startActivityForResult(intent, 0);
//            return false;
//        }
//    }



    public static boolean getAndAskUsageStatesPermission(@NonNull Context context, boolean askPermissionToo) {
        return true;
    }

    public static boolean getAndAskDisplayOverlayPermission(@NonNull Context context, boolean askPermissionToo) {
        return true;
    }

    public static boolean getAndAskBatteryOptimizationPermission(@NonNull Context context, boolean askPermissionToo) {
        return true;
    }

    public static boolean getAndAskDndPermission(@NonNull Context context, boolean askPermissionToo) {
        NotificationManager notificationManager = (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);
        if (notificationManager.isNotificationPolicyAccessGranted()) return true;

        /// Ask for permission
        if (askPermissionToo) ActivityNewTaskHelper.openDoNotDisturbAccessSection(context);

        return false;
    }


}
