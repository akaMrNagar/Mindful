package com.akamrnagar.mindful.helpers;

import static com.akamrnagar.mindful.workers.MidnightWorker.MIDNIGHT_WORKER_ID;
import static com.akamrnagar.mindful.workers.StartBedtimeWorker.BEDTIME_WORKER_START_ID;
import static com.akamrnagar.mindful.workers.StopBedtimeWorker.BEDTIME_WORKER_STOP_ID;

import android.content.Context;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.work.ExistingPeriodicWorkPolicy;
import androidx.work.PeriodicWorkRequest;
import androidx.work.WorkManager;

import com.akamrnagar.mindful.models.BedtimeSettings;
import com.akamrnagar.mindful.workers.MidnightWorker;
import com.akamrnagar.mindful.workers.StartBedtimeWorker;
import com.akamrnagar.mindful.workers.StopBedtimeWorker;

import java.util.Calendar;
import java.util.Date;
import java.util.concurrent.TimeUnit;

public class WorkersHelper {

    private static final String TAG = "Mindful.WorkerTasksHelper";
    private static final String BEDTIME_WORKERS_UNIQUE_TAG = "com.akamrnagar.mindful.BedtimeWorkers";
    private static final String MIDNIGHT_WORKER_UNIQUE_TAG = "com.akamrnagar.mindful.MidnightWorker";


    public static void cancelBedtimeRoutine(Context context) {
        WorkManager.getInstance(context).cancelAllWorkByTag(BEDTIME_WORKERS_UNIQUE_TAG);
        Log.d(TAG, "cancelBedtimeRoutine:  Bedtime routine task cancelled successfully");
    }

    public static void scheduleMidnightWorker(@NonNull Context context) {
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.DAY_OF_YEAR, cal.get(Calendar.DAY_OF_YEAR) + 1);
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);

        long initialDelay = cal.getTimeInMillis() - System.currentTimeMillis();

        WorkManager workManager = WorkManager.getInstance(context);
        PeriodicWorkRequest midnightRequest = new PeriodicWorkRequest.Builder(
                MidnightWorker.class, 1, TimeUnit.DAYS)
                .setInitialDelay(initialDelay, TimeUnit.MILLISECONDS)
                .addTag(MIDNIGHT_WORKER_UNIQUE_TAG)
                .build();
        workManager.enqueueUniquePeriodicWork(MIDNIGHT_WORKER_ID, ExistingPeriodicWorkPolicy.UPDATE, midnightRequest);

        Log.d(TAG, "scheduleMidnightWorker: Midnight worker is scheduled successfully for "
                + new Date(System.currentTimeMillis() + initialDelay));
    }

    public static void scheduleBedtimeRoutine(@NonNull Context context) {
        BedtimeSettings bedtimeSettings = SharedPrefsHelper.fetchBedtimeSettings(context);

        int hour = bedtimeSettings.startTimeInMins / 60;
        int minutes = bedtimeSettings.startTimeInMins % 60;

        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.HOUR_OF_DAY, hour);
        cal.set(Calendar.MINUTE, minutes);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);


        long initialDelay = cal.getTimeInMillis() - System.currentTimeMillis();
        long duration = bedtimeSettings.totalDurationInMins * 60000L;
        WorkManager workManager = WorkManager.getInstance(context);

        PeriodicWorkRequest startBedtimeRequest = new PeriodicWorkRequest.Builder(
                StartBedtimeWorker.class, 1, TimeUnit.DAYS)
                .setInitialDelay(initialDelay, TimeUnit.MILLISECONDS)
                .addTag(BEDTIME_WORKERS_UNIQUE_TAG)
                .build();
        workManager.enqueueUniquePeriodicWork(BEDTIME_WORKER_START_ID, ExistingPeriodicWorkPolicy.UPDATE, startBedtimeRequest);


        PeriodicWorkRequest stopBedtimeRequest = new PeriodicWorkRequest.Builder(
                StopBedtimeWorker.class, 1, TimeUnit.DAYS)
                .setInitialDelay(initialDelay + duration, TimeUnit.MILLISECONDS)
                .addTag(BEDTIME_WORKERS_UNIQUE_TAG)
                .build();
        workManager.enqueueUniquePeriodicWork(BEDTIME_WORKER_STOP_ID, ExistingPeriodicWorkPolicy.UPDATE, stopBedtimeRequest);


        Log.d(TAG, "scheduleBedtimeTask: Bedtime routine task scheduled successfully which starts on: "
                + new Date(System.currentTimeMillis() + initialDelay)
                + " and ends on : "
                + new Date(System.currentTimeMillis() + initialDelay + duration)
        );
    }
}
