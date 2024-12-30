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
import static com.mindful.android.receivers.alarm.NotificationBatchReceiver.ACTION_PUSH_BATCH;
import static com.mindful.android.utils.AppConstants.ONE_DAY_IN_MS;

import android.app.AlarmManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.util.Log;

import androidx.annotation.NonNull;

import com.mindful.android.generics.SafeServiceConnection;
import com.mindful.android.models.BedtimeSettings;
import com.mindful.android.receivers.alarm.BedtimeRoutineReceiver;
import com.mindful.android.receivers.alarm.MidnightResetReceiver;
import com.mindful.android.receivers.alarm.NotificationBatchReceiver;
import com.mindful.android.services.MindfulTrackerService;
import com.mindful.android.utils.Utils;

import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Helper class for scheduling alarm tasks related to bedtime routines and midnight resets.
 */
public class AlarmTasksSchedulingHelper {
    private static final String TAG = "Mindful.AlarmTasksSchedulingHelper";

    /**
     * Schedules the midnight reset task if it is not already scheduled.
     * Which will trigger at 12 midnight every day (with delay of 3 seconds).
     *
     * @param context               The application context.
     * @param checkBeforeScheduling Flag indicating whether to check if the task is already scheduled.
     */
    public static void scheduleMidnightResetTask(@NonNull Context context, boolean checkBeforeScheduling) {
        if (checkBeforeScheduling) {
            Intent intent = new Intent(context.getApplicationContext(), MidnightResetReceiver.class).setAction(MidnightResetReceiver.ACTION_START_MIDNIGHT_RESET);
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

        scheduleOrUpdateExactAlarmTask(context, MidnightResetReceiver.class, MidnightResetReceiver.ACTION_START_MIDNIGHT_RESET, cal.getTimeInMillis());
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
        long endTimeMs = Utils.todToTodayCal(bedtimeSettings.startTimeInMins + bedtimeSettings.totalDurationInMins).getTimeInMillis();

        // Bedtime is already ended then reschedule for the next day
        if (endTimeMs < nowInMs) {
            alertTimeMs += ONE_DAY_IN_MS;
            startTimeMs += ONE_DAY_IN_MS;
            endTimeMs += ONE_DAY_IN_MS;
        }

        // If alert time is in future
        if (alertTimeMs > nowInMs) {
            scheduleOrUpdateExactAlarmTask(context, BedtimeRoutineReceiver.class, ACTION_ALERT_BEDTIME, alertTimeMs);
        }

        // Bedtime start and stop tasks
        scheduleOrUpdateExactAlarmTask(context, BedtimeRoutineReceiver.class, ACTION_START_BEDTIME, startTimeMs);
        scheduleOrUpdateExactAlarmTask(context, BedtimeRoutineReceiver.class, ACTION_STOP_BEDTIME, endTimeMs);
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
        // Cancel the alarms
        cancelExactAlarmTasks(context, BedtimeRoutineReceiver.class, Arrays.asList(ACTION_ALERT_BEDTIME, ACTION_START_BEDTIME, ACTION_STOP_BEDTIME));

        // Let service know
        if (Utils.isServiceRunning(context, MindfulTrackerService.class.getName())) {
            SafeServiceConnection<MindfulTrackerService> conn = new SafeServiceConnection<>(MindfulTrackerService.class, context);
            conn.setOnConnectedCallback(s -> s.startStopBedtimeMode(null));
            conn.bindService();
            conn.unBindService();
        }
        Log.d(TAG, "cancelBedtimeRoutineTasks: Bedtime routine tasks cancelled successfully");
    }

    /**
     * Schedules next future possible notification batch.
     *
     * @param context      The application context.
     * @param scheduleTods The hashset of integers representing TODs in minutes.
     */
    public static void scheduleNotificationBatchTask(@NonNull Context context, @NonNull HashSet<Integer> scheduleTods) {
        List<Integer> sortedTods = scheduleTods.stream().sorted().collect(Collectors.toList());
        if (sortedTods.isEmpty()) return;

        long now = System.currentTimeMillis();
        Long nextAlarmTime = null;

        // Find the first future TOD
        for (int tod : sortedTods) {
            long currentTime = Utils.todToTodayCal(tod).getTimeInMillis();
            if (currentTime > now) {
                nextAlarmTime = currentTime;
                break;
            }
        }

        // If no future TOD, schedule for the first TOD of the next day
        if (nextAlarmTime == null) {
            nextAlarmTime = Utils.todToTodayCal(sortedTods.get(0)).getTimeInMillis() + ONE_DAY_IN_MS;
        }

        scheduleOrUpdateExactAlarmTask(context, NotificationBatchReceiver.class, ACTION_PUSH_BATCH, nextAlarmTime);
        Log.d(TAG, "scheduleNotificationBatchTask: Notification batch task scheduled successfully for " + new Date(nextAlarmTime));
    }

    /**
     * Cancels notification batch schedule task.
     *
     * @param context The application context.
     */
    public static void cancelNotificationBatchTask(@NonNull Context context) {
        cancelExactAlarmTasks(context, NotificationBatchReceiver.NotificationBatchWorker.class, Collections.singletonList(ACTION_PUSH_BATCH));
        Log.d(TAG, "cancelNotificationBatchTask: Notification batch tasks cancelled successfully");
    }

    /**
     * Schedules or updates an alarm task with the specified parameters.
     *
     * @param context       The application context.
     * @param receiverClass The receiver class for the alarm.
     * @param intentAction  The action to be set on the intent.
     * @param epochTimeMs   The time at which the alarm should go off, in milliseconds since epoch.
     */
    private static void scheduleOrUpdateExactAlarmTask(@NonNull Context context, Class<?> receiverClass, String intentAction, long epochTimeMs) {
        AlarmManager alarmManager = (AlarmManager) context.getSystemService(Context.ALARM_SERVICE);
        Intent intent = new Intent(context.getApplicationContext(), receiverClass).setAction(intentAction);
        PendingIntent pendingIntent = PendingIntent.getBroadcast(context, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_IMMUTABLE);

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            if (alarmManager.canScheduleExactAlarms()) {
                alarmManager.setExactAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, epochTimeMs, pendingIntent);
            }
        } else {
            alarmManager.setExactAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, epochTimeMs, pendingIntent);
        }
    }

    /**
     * Cancels all the exact alarm task related to the service class and the list of actions.
     *
     * @param context       The application context.
     * @param receiverClass The receiver class for the alarm.
     * @param intentActions The list of actions to be set on the intents.
     */
    private static void cancelExactAlarmTasks(@NonNull Context context, Class<?> receiverClass, @NonNull List<String> intentActions) {
        AlarmManager alarmManager = (AlarmManager) context.getSystemService(Context.ALARM_SERVICE);

        for (String action : intentActions) {
            Intent intent = new Intent(context.getApplicationContext(), receiverClass).setAction(action);
            PendingIntent pendingIntent = PendingIntent.getBroadcast(context, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_IMMUTABLE);
            alarmManager.cancel(pendingIntent);
        }
    }


}
