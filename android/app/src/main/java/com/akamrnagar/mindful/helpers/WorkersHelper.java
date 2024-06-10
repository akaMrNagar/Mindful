package com.akamrnagar.mindful.helpers;

import static com.akamrnagar.mindful.workers.BedtimeWorker.BEDTIME_WORKER_ID_START;
import static com.akamrnagar.mindful.workers.BedtimeWorker.BEDTIME_WORKER_ID_STOP;
import static com.akamrnagar.mindful.workers.BedtimeWorker.BEDTIME_WORKER_UNIQUE_TAG;

import android.content.Context;
import android.content.SharedPreferences;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.work.Data;
import androidx.work.ExistingPeriodicWorkPolicy;
import androidx.work.PeriodicWorkRequest;
import androidx.work.WorkManager;

import com.akamrnagar.mindful.models.BedtimeSettings;
import com.akamrnagar.mindful.utils.AppConstants;
import com.akamrnagar.mindful.workers.BedtimeWorker;

import java.util.Calendar;
import java.util.Date;
import java.util.concurrent.TimeUnit;

import io.flutter.plugin.common.MethodCall;

public class WorkersHelper {

    private static final String TAG = "Mindful.WorkerTasksHelper";

    public static void cancelBedtimeRoutine(Context context) {
        WorkManager.getInstance(context).cancelAllWorkByTag(BEDTIME_WORKER_UNIQUE_TAG);
    }

    public static void scheduleBedtimeRoutine(@NonNull Context context, @NonNull MethodCall call) {

        SharedPreferences prefs = context.getSharedPreferences(AppConstants.PREFS_SHARED_BOX, Context.MODE_PRIVATE);
        String jsonString = prefs.getString(AppConstants.PREF_KEY_BEDTIME_SETTINGS, "");

        BedtimeSettings bedtimeSettings = new BedtimeSettings(jsonString);

        int hour = bedtimeSettings.startTimeInMins / 60;
        int minutes = bedtimeSettings.startTimeInMins % 60;

        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.HOUR_OF_DAY, hour);
        cal.set(Calendar.MINUTE, minutes);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);


        long initialDelay = cal.getTimeInMillis() - System.currentTimeMillis();
        long duration = bedtimeSettings.totalDurationMins * 60000L;
        WorkManager workManager = WorkManager.getInstance(context);

        PeriodicWorkRequest startBedtimeRequest = new PeriodicWorkRequest.Builder(
                BedtimeWorker.class, 1, TimeUnit.DAYS)
                .setInitialDelay(initialDelay, TimeUnit.MILLISECONDS)
                .setInputData(new Data.Builder().putBoolean("STATE", true).build())
                .addTag(BEDTIME_WORKER_UNIQUE_TAG)
                .build();
        workManager.enqueueUniquePeriodicWork(BEDTIME_WORKER_ID_START, ExistingPeriodicWorkPolicy.CANCEL_AND_REENQUEUE, startBedtimeRequest);


        PeriodicWorkRequest stopBedtimeRequest = new PeriodicWorkRequest.Builder(
                BedtimeWorker.class, 1, TimeUnit.DAYS)
                .setInitialDelay(initialDelay + duration, TimeUnit.MILLISECONDS)
                .setInputData(new Data.Builder().putBoolean("STATE", false).build())
                .addTag(BEDTIME_WORKER_UNIQUE_TAG)
                .build();
        workManager.enqueueUniquePeriodicWork(BEDTIME_WORKER_ID_STOP, ExistingPeriodicWorkPolicy.CANCEL_AND_REENQUEUE, stopBedtimeRequest);


        Log.d(TAG, "scheduleBedtimeTask: Bedtime routine task scheduled successfully which starts on: "
                + new Date(cal.getTimeInMillis())
                + " and ends on : "
                + new Date(cal.getTimeInMillis() + duration)
        );
    }
}
