package com.akamrnagar.mindful.workers;


import android.content.Context;

import androidx.annotation.NonNull;
import androidx.work.Data;
import androidx.work.Worker;
import androidx.work.WorkerParameters;

public class BedtimeScheduleWorker extends Worker {

    private static final String TAG = "Mindful.BedtimeScheduleWorker";
    public static final String BEDTIME_WORKER_ID_START = "com.akamrnagar.mindful.BedtimeWorker.START";
    public static final String BEDTIME_WORKER_ID_STOP = "com.akamrnagar.mindful.BedtimeWorker.STOP";
    public static final String BEDTIME_WORKER_TAG = "com.akamrnagar.mindful.BedtimeWorker";
    private final Context mContext;
    private boolean state = false;
    private boolean toggleDnd = false;
    private boolean pauseApps = false;
    private boolean[] selectedDays = new boolean[7];

    public BedtimeScheduleWorker(@NonNull Context context, @NonNull WorkerParameters workerParams) {
        super(context, workerParams);
        Data data = workerParams.getInputData();
        state = data.getBoolean("STATE", false);
        toggleDnd = data.getBoolean("toggleDnd", false);
        pauseApps = data.getBoolean("pauseApps", false);
        selectedDays = data.getBooleanArray("selectedDays");
        mContext = context;
    }

    @NonNull
    @Override
    public Result doWork() {
//        Intent intent = new Intent(mContext, MindfulForegroundService.class);
//        mContext.bindService(intent, mTrackerServiceConnection, Context.BIND_WAIVE_PRIORITY);
        return Result.success();
    }
}
