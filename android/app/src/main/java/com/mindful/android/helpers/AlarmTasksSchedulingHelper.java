/*
 *
 *  * Copyright (c) 2024 Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

package com.mindful.android.helpers;

import android.app.AlarmManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.util.Log;

import androidx.annotation.NonNull;

import com.mindful.android.models.BedtimeSettings;
import com.mindful.android.receivers.alarm.BedtimeRoutineReceiver;
import com.mindful.android.receivers.alarm.MidnightResetReceiver;

import java.util.Calendar;

/**
 * Helper class for scheduling alarm tasks related to bedtime routines and midnight resets.
 */
public class AlarmTasksSchedulingHelper {
    private static final String TAG = "Mindful.RepeatingTasksHelper";

    /**
     * Schedules the midnight reset task if it is not already scheduled.
     * Which will trigger at 12 midnight every day.
     *
     * @param context               The application context.
     * @param checkBeforeScheduling Flag indicating whether to check if the task is already scheduled.
     */
    public static void scheduleMidnightResetTask(@NonNull Context context, boolean checkBeforeScheduling) {
        if (checkBeforeScheduling) {
            Intent intent = new Intent(context, MidnightResetReceiver.class)
                    .setAction(MidnightResetReceiver.ACTION_START_MIDNIGHT_RESET);
            PendingIntent pendingIntent = PendingIntent.getBroadcast(context, 0, intent,
                    PendingIntent.FLAG_NO_CREATE | PendingIntent.FLAG_IMMUTABLE);

            if (pendingIntent != null) {
                Log.d(TAG, "scheduleMidnightTask: Midnight reset task is already scheduled");
                return;
            }
        }

        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 5); // For safe side

        cal.add(Calendar.DATE, 1);
        scheduleOrUpdateAlarmTask(context, MidnightResetReceiver.class,
                MidnightResetReceiver.ACTION_START_MIDNIGHT_RESET, cal.getTimeInMillis());
        Log.d(TAG, "scheduleMidnightTask: Midnight reset task scheduled successfully for " + cal.getTime());
    }

    /**
     * Schedules the bedtime start task based on the bedtime settings.
     *
     * @param context The application context.
     */
    public static void scheduleBedtimeStartTask(@NonNull Context context) {
        BedtimeSettings bedtimeSettings = SharedPrefsHelper.fetchBedtimeSettings(context);

        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.HOUR_OF_DAY, bedtimeSettings.startTimeInMins / 60);
        cal.set(Calendar.MINUTE, bedtimeSettings.startTimeInMins % 60);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);

        // Schedule for next day if end time of routine has been passed
        Calendar endCal = (Calendar) cal.clone();
        endCal.add(Calendar.MINUTE, bedtimeSettings.totalDurationInMins);
        if (endCal.before(Calendar.getInstance())) {
            cal.add(Calendar.DATE, 1);
        }

        scheduleOrUpdateAlarmTask(context, BedtimeRoutineReceiver.class,
                BedtimeRoutineReceiver.ACTION_START_BEDTIME, cal.getTimeInMillis());
        Log.d(TAG, "scheduleBedtimeStartTask: Bedtime START task scheduled successfully for " + cal.getTime());
    }

    /**
     * Schedules the bedtime stop task based on the bedtime settings.
     *
     * @param context The application context.
     */
    public static void scheduleBedtimeStopTask(@NonNull Context context) {
        BedtimeSettings bedtimeSettings = SharedPrefsHelper.fetchBedtimeSettings(context);

        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.HOUR_OF_DAY, bedtimeSettings.startTimeInMins / 60);
        cal.set(Calendar.MINUTE, bedtimeSettings.startTimeInMins % 60);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        cal.add(Calendar.MINUTE, bedtimeSettings.totalDurationInMins);

        scheduleOrUpdateAlarmTask(context, BedtimeRoutineReceiver.class,
                BedtimeRoutineReceiver.ACTION_STOP_BEDTIME, cal.getTimeInMillis());
        Log.d(TAG, "scheduleBedtimeStopTask: Bedtime STOP task scheduled successfully for " + cal.getTime());
    }

    /**
     * Cancels both scheduled start and stop bedtime routine tasks.
     *
     * @param context The application context.
     */
    public static void cancelBedtimeRoutineTasks(@NonNull Context context) {
        Intent startIntent = new Intent(context, BedtimeRoutineReceiver.class)
                .setAction(BedtimeRoutineReceiver.ACTION_START_BEDTIME);
        Intent stopIntent = new Intent(context, BedtimeRoutineReceiver.class)
                .setAction(BedtimeRoutineReceiver.ACTION_STOP_BEDTIME);
        PendingIntent startPendingIntent = PendingIntent.getBroadcast(context, 0, startIntent,
                PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_IMMUTABLE);
        PendingIntent stopPendingIntent = PendingIntent.getBroadcast(context, 0, stopIntent,
                PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_IMMUTABLE);

        // Cancel the alarms
        AlarmManager alarmManager = (AlarmManager) context.getSystemService(Context.ALARM_SERVICE);
        alarmManager.cancel(startPendingIntent);
        alarmManager.cancel(stopPendingIntent);

        // Turn off Dnd
        NotificationHelper.toggleDnd(context, false);
        Log.d(TAG, "cancelBedtimeRoutineTasks: Bedtime routine tasks cancelled successfully");
    }

    /**
     * Schedules or updates an alarm task with the specified parameters.
     *
     * @param context       The application context.
     * @param receiverClass The receiver class for the alarm.
     * @param intentAction  The action to be set on the intent.
     * @param epochTimeMs   The time at which the alarm should go off, in milliseconds since epoch.
     */
    private static void scheduleOrUpdateAlarmTask(@NonNull Context context, Class<?> receiverClass,
                                                  String intentAction, long epochTimeMs) {
        AlarmManager alarmManager = (AlarmManager) context.getSystemService(Context.ALARM_SERVICE);
        Intent intent = new Intent(context, receiverClass).setAction(intentAction);
        PendingIntent pendingIntent = PendingIntent.getBroadcast(context, 0, intent,
                PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_IMMUTABLE);

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            if (alarmManager.canScheduleExactAlarms()) {
                alarmManager.setExactAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, epochTimeMs, pendingIntent);
            }
        } else {
            alarmManager.setExactAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, epochTimeMs, pendingIntent);
        }
    }
}
