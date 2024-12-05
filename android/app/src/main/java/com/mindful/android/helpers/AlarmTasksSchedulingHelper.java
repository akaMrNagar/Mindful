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

import static com.mindful.android.receivers.alarm.BedtimeRoutineReceiver.ACTION_ALERT_BEDTIME;
import static com.mindful.android.receivers.alarm.BedtimeRoutineReceiver.ACTION_START_BEDTIME;
import static com.mindful.android.receivers.alarm.BedtimeRoutineReceiver.ACTION_STOP_BEDTIME;

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
import com.mindful.android.services.MindfulTrackerService;
import com.mindful.android.utils.Utils;

import java.util.Calendar;
import java.util.Date;

/**
 * Helper class for scheduling alarm tasks related to bedtime routines and midnight resets.
 */
public class AlarmTasksSchedulingHelper {
    private static final String TAG = "Mindful.AlarmTasksSchedulingHelper";
    private static final long oneDayInMs = 24 * 60 * 60 * 1000;

    /**
     * Schedules the midnight reset task if it is not already scheduled.
     * Which will trigger at 12 midnight every day (with delay of 3 seconds).
     *
     * @param context               The application context.
     * @param checkBeforeScheduling Flag indicating whether to check if the task is already scheduled.
     */
    public static void scheduleMidnightResetTask(@NonNull Context context, boolean checkBeforeScheduling) {
        if (checkBeforeScheduling) {
            Intent intent = new Intent(context, MidnightResetReceiver.class).setAction(MidnightResetReceiver.ACTION_START_MIDNIGHT_RESET);
            PendingIntent pendingIntent = PendingIntent.getBroadcast(context, 0, intent, PendingIntent.FLAG_NO_CREATE | PendingIntent.FLAG_IMMUTABLE);

            if (pendingIntent != null) {
                Log.d(TAG, "scheduleMidnightTask: Midnight reset task is already scheduled");
                return;
            }
        }

        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 3); // For safe side
        cal.add(Calendar.DATE, 1);

        scheduleOrUpdateAlarmTask(context, MidnightResetReceiver.class, MidnightResetReceiver.ACTION_START_MIDNIGHT_RESET, cal.getTimeInMillis());
        Log.d(TAG, "scheduleMidnightTask: Midnight reset task scheduled successfully for " + cal.getTime());
    }

    /**
     * Schedules the bedtime alert, start, and stop tasks based on the bedtime settings.
     *
     * @param context         The application context.
     * @param bedtimeSettings The Bedtime settings object used for scheduling.
     */
    public static void scheduleBedtimeRoutineTasks(@NonNull Context context, @NonNull BedtimeSettings bedtimeSettings) {
        long nowInMs = System.currentTimeMillis();
        long alertTimeMs = Utils.todToTodayCal(bedtimeSettings.startTimeInMins - 30).getTimeInMillis();
        long startTimeMs = Utils.todToTodayCal(bedtimeSettings.startTimeInMins).getTimeInMillis();
        long endTimeMs = (startTimeMs + (bedtimeSettings.totalDurationInMins * 60000L));

        // Bedtime is already ended then reschedule for the next day
        if (endTimeMs < nowInMs) {
            alertTimeMs += oneDayInMs;
            startTimeMs += oneDayInMs;
            endTimeMs += oneDayInMs;
        }

        // If alert time is in future
        if (alertTimeMs > nowInMs) {
            scheduleOrUpdateAlarmTask(context, BedtimeRoutineReceiver.class, ACTION_ALERT_BEDTIME, alertTimeMs);
        }

        // Bedtime start and stop tasks
        scheduleOrUpdateAlarmTask(context, BedtimeRoutineReceiver.class, ACTION_START_BEDTIME, startTimeMs);
        scheduleOrUpdateAlarmTask(context, BedtimeRoutineReceiver.class, ACTION_STOP_BEDTIME, endTimeMs);
        Log.d(TAG, "scheduleBedtimeStartTask: Bedtime routine tasks scheduled successfully for - "
                + "\nalert: " + (alertTimeMs > nowInMs ? "" : "(skipping) ") + new Date(alertTimeMs)
                + "\nstart: " + new Date(startTimeMs)
                + "\nend: " + new Date(endTimeMs)
        );
    }


    /**
     * Cancels both scheduled start and stop bedtime routine tasks.
     *
     * @param context The application context.
     */
    public static void cancelBedtimeRoutineTasks(@NonNull Context context) {
        Intent alertIntent = new Intent(context, BedtimeRoutineReceiver.class).setAction(ACTION_ALERT_BEDTIME);
        Intent startIntent = new Intent(context, BedtimeRoutineReceiver.class).setAction(ACTION_START_BEDTIME);
        Intent stopIntent = new Intent(context, BedtimeRoutineReceiver.class).setAction(BedtimeRoutineReceiver.ACTION_STOP_BEDTIME);
        PendingIntent alertPendingIntent = PendingIntent.getBroadcast(context, 0, alertIntent, PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_IMMUTABLE);
        PendingIntent startPendingIntent = PendingIntent.getBroadcast(context, 0, startIntent, PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_IMMUTABLE);
        PendingIntent stopPendingIntent = PendingIntent.getBroadcast(context, 0, stopIntent, PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_IMMUTABLE);

        // Cancel the alarms
        AlarmManager alarmManager = (AlarmManager) context.getSystemService(Context.ALARM_SERVICE);
        alarmManager.cancel(alertPendingIntent);
        alarmManager.cancel(startPendingIntent);
        alarmManager.cancel(stopPendingIntent);

        // Turn off Dnd
        NotificationHelper.toggleDnd(context, false);

        // Let service know
        if (Utils.isServiceRunning(context, MindfulTrackerService.class.getName())) {
            Intent serviceIntent = new Intent(context, MindfulTrackerService.class).setAction(MindfulTrackerService.ACTION_STOP_BEDTIME_MODE);
            context.startService(serviceIntent);
        }

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
    private static void scheduleOrUpdateAlarmTask(@NonNull Context context, Class<?> receiverClass, String intentAction, long epochTimeMs) {
        AlarmManager alarmManager = (AlarmManager) context.getSystemService(Context.ALARM_SERVICE);
        Intent intent = new Intent(context, receiverClass).setAction(intentAction);
        PendingIntent pendingIntent = PendingIntent.getBroadcast(context, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_IMMUTABLE);

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            if (alarmManager.canScheduleExactAlarms()) {
                alarmManager.setExactAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, epochTimeMs, pendingIntent);
            }
        } else {
            alarmManager.setExactAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, epochTimeMs, pendingIntent);
        }
    }
}
