//package com.mindful.android.helpers;
//
//import static com.mindful.android.workers.BedtimeStartWorker.BEDTIME_START_WORKER_ID;
//import static com.mindful.android.workers.BedtimeStopWorker.BEDTIME_STOP_WORKER_ID;
//import static com.mindful.android.workers.DailyMidnightWorker.DAILY_MIDNIGHT_WORKER_ID;
//
//import android.content.Context;
//import android.util.Log;
//
//import androidx.annotation.NonNull;
//import androidx.work.ExistingWorkPolicy;
//import androidx.work.OneTimeWorkRequest;
//import androidx.work.WorkManager;
//
//import com.mindful.android.models.BedtimeSettings;
//import com.mindful.android.workers.BedtimeStartWorker;
//import com.mindful.android.workers.BedtimeStopWorker;
//import com.mindful.android.workers.DailyMidnightWorker;
//
//import java.util.Calendar;
//import java.util.Date;
//import java.util.concurrent.TimeUnit;
//
///**
// * Helper class for scheduling and canceling WorkManager tasks related to bedtime routines
// * and midnight operations.
// */
//public class WorkersHelper {
//    private static final String TAG = "Mindful.WorkerTasksHelper";
//    private static final String BEDTIME_WORKERS_UNIQUE_TAG = "com.mindful.android.BedtimeWorkers";
//    private static final String MIDNIGHT_WORKER_UNIQUE_TAG = "com.mindful.android.MidnightWorker";
//
//    /**
//     * Cancels all scheduled bedtime routine tasks.
//     *
//     * @param context The application context.
//     */
//    public static void cancelBedtimeRoutine(Context context) {
//        WorkManager.getInstance(context).cancelAllWorkByTag(BEDTIME_WORKERS_UNIQUE_TAG);
//        Log.d(TAG, "cancelBedtimeRoutine: Bedtime routine task cancelled successfully");
//    }
//
//    /**
//     * Schedules a periodic worker to run at midnight every day.
//     * The worker is ignored if already scheduled.
//     * Rescheduling from DailyMidnightWorker
//     * <p>
//     * NOTE: WorkManager cannot schedule periodic worker at a fixed time therefore we are scheduling one time worker which recursively schedule worker for next cycle
//     *
//     * @param context The application context.
//     */
//    public static void scheduleMidnightWorker(@NonNull Context context) {
//        Calendar cal = Calendar.getInstance();
//        cal.set(Calendar.HOUR_OF_DAY, 0);
//        cal.set(Calendar.MINUTE, 0);
//        cal.set(Calendar.SECOND, 0);
//        cal.set(Calendar.MILLISECOND, 0);
//
//        cal.add(Calendar.DATE, 1);
//        long initialDelay = cal.getTimeInMillis() - System.currentTimeMillis();
//
//        WorkManager workManager = WorkManager.getInstance(context);
//        OneTimeWorkRequest midnightRequest = new OneTimeWorkRequest.Builder(DailyMidnightWorker.class)
//                .setInitialDelay(initialDelay, TimeUnit.MILLISECONDS)
//                .addTag(MIDNIGHT_WORKER_UNIQUE_TAG)
//                .build();
//        workManager.enqueueUniqueWork(DAILY_MIDNIGHT_WORKER_ID, ExistingWorkPolicy.REPLACE, midnightRequest);
//
//        Log.d(TAG, "scheduleMidnightWorker: Repeated midnight worker is scheduled/updated successfully from "
//                + new Date(cal.getTimeInMillis())
//        );
//    }
//
//    /**
//     * Schedules the bedtime routine tasks based on the provided BedtimeSettings.
//     * This includes starting and stopping bedtime tasks.
//     * Rescheduling from BedtimeStartWorker
//     * <p>
//     * NOTE: WorkManager cannot schedule periodic worker at a fixed time therefore we are scheduling one time worker which recursively schedule worker for next cycle
//     *
//     * @param context The application context.
//     */
//    public static void scheduleBedtimeRoutine(@NonNull Context context) {
//        BedtimeSettings bedtimeSettings = SharedPrefsHelper.fetchBedtimeSettings(context);
//
//        int hour = bedtimeSettings.startTimeInMins / 60;
//        int minutes = bedtimeSettings.startTimeInMins % 60;
//
//        Calendar cal = Calendar.getInstance();
//        cal.set(Calendar.HOUR_OF_DAY, hour);
//        cal.set(Calendar.MINUTE, minutes);
//        cal.set(Calendar.SECOND, 0);
//        cal.set(Calendar.MILLISECOND, 0);
//
//        cal.add(Calendar.DATE, 1);
//        long initialDelay = cal.getTimeInMillis() - System.currentTimeMillis();
//        long duration = bedtimeSettings.totalDurationInMins * 60000L;
//
//        WorkManager workManager = WorkManager.getInstance(context);
//        OneTimeWorkRequest startBedtimeRequest = new OneTimeWorkRequest.Builder(BedtimeStartWorker.class)
//                .setInitialDelay(initialDelay, TimeUnit.MILLISECONDS)
//                .addTag(BEDTIME_WORKERS_UNIQUE_TAG)
//                .build();
//        workManager.enqueueUniqueWork(BEDTIME_START_WORKER_ID, ExistingWorkPolicy.REPLACE, startBedtimeRequest);
//
//        OneTimeWorkRequest stopBedtimeRequest = new OneTimeWorkRequest.Builder(BedtimeStopWorker.class)
//                .setInitialDelay(initialDelay + duration, TimeUnit.MILLISECONDS)
//                .addTag(BEDTIME_WORKERS_UNIQUE_TAG)
//                .build();
//        workManager.enqueueUniqueWork(BEDTIME_STOP_WORKER_ID, ExistingWorkPolicy.REPLACE, stopBedtimeRequest);
//
//        Log.d(TAG, "scheduleBedtimeTask: Bedtime routine task scheduled successfully which starts on: "
//                + new Date(cal.getTimeInMillis())
//                + " and ends on : "
//                + new Date(cal.getTimeInMillis() + duration)
//        );
//    }
//}
