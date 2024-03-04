package com.akamrnagar.mindful.helpers;

import static com.akamrnagar.mindful.workers.BedtimeScheduleWorker.BEDTIME_WORKER_ID_START;
import static com.akamrnagar.mindful.workers.BedtimeScheduleWorker.BEDTIME_WORKER_ID_STOP;
import static com.akamrnagar.mindful.workers.BedtimeScheduleWorker.BEDTIME_WORKER_TAG;

import android.content.Context;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.work.Data;
import androidx.work.ExistingPeriodicWorkPolicy;
import androidx.work.PeriodicWorkRequest;
import androidx.work.WorkManager;

import com.akamrnagar.mindful.utils.AppConstants;
import com.akamrnagar.mindful.workers.BedtimeScheduleWorker;

import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;

import io.flutter.plugin.common.MethodCall;

public class WorkersHelper {

    public static void cancelBedtimeTask(Context context) {
        WorkManager.getInstance(context).cancelAllWorkByTag(BEDTIME_WORKER_TAG);
    }

    public static void scheduleBedtimeTask(Context context, @NonNull MethodCall call) {

        Long startMsEpoch = (Long) call.argument("startMsEpoch");
        Integer durationMs = call.argument("durationMs");
        Boolean toggleDnd = call.argument("toggleDnd");
        Boolean pauseApps = call.argument("pauseApps");
        List<Boolean> selectedDays = call.argument("selectedDays");

        if (startMsEpoch == null || durationMs == null || toggleDnd == null || pauseApps == null || selectedDays == null) {
            Log.d(AppConstants.DEBUG_TAG, "WorkersHelper.scheduleBedtimeTask(): Arguments not found");
            return;
        }

        Log.d(AppConstants.DEBUG_TAG, "WorkerTaskManager.scheduleBedtimeTask(): called");

        boolean[] days = new boolean[selectedDays.size()];
        for (int i = 0; i < selectedDays.size(); i++) {
            days[i] = selectedDays.get(i);
        }

        long initialDelay = startMsEpoch - System.currentTimeMillis();
        WorkManager workManager = WorkManager.getInstance(context);

        PeriodicWorkRequest startBedtimeRequest = new PeriodicWorkRequest.Builder(
                BedtimeScheduleWorker.class, 1, TimeUnit.DAYS)
                .setInitialDelay(initialDelay, TimeUnit.MILLISECONDS)
                .setInputData(
                        new Data.Builder()
                                .putBoolean("STATE", true)
                                .putBoolean("toggleDnd", toggleDnd)
                                .putBoolean("pauseApps", pauseApps)
                                .putBooleanArray("selectedDays", days)
                                .build()
                )
                .addTag(BEDTIME_WORKER_TAG)
                .build();
        workManager.enqueueUniquePeriodicWork(BEDTIME_WORKER_ID_START, ExistingPeriodicWorkPolicy.CANCEL_AND_REENQUEUE, startBedtimeRequest);


        PeriodicWorkRequest stopBedtimeRequest = new PeriodicWorkRequest.Builder(
                BedtimeScheduleWorker.class, 1, TimeUnit.DAYS)
                .setInitialDelay(initialDelay + durationMs, TimeUnit.MILLISECONDS)
                .setInputData(new Data.Builder().putBoolean("STATE", false).build())
                .addTag(BEDTIME_WORKER_TAG)
                .build();
        workManager.enqueueUniquePeriodicWork(BEDTIME_WORKER_ID_STOP, ExistingPeriodicWorkPolicy.CANCEL_AND_REENQUEUE, stopBedtimeRequest);


        Log.d(AppConstants.DEBUG_TAG, "Task scheduled successfully for: " + new Date(startMsEpoch).getTime());
    }
}
