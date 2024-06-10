package com.akamrnagar.mindful.workers;

import android.content.Context;
import android.content.SharedPreferences;

import androidx.annotation.NonNull;
import androidx.work.Data;
import androidx.work.Worker;
import androidx.work.WorkerParameters;

import com.akamrnagar.mindful.models.BedtimeSettings;
import com.akamrnagar.mindful.utils.AppConstants;

public class BedtimeWorker extends Worker {

    private static final String TAG = "Mindful.BedtimeWorker";
    public static final String BEDTIME_WORKER_ID_START = "com.akamrnagar.mindful.BedtimeWorker.START";
    public static final String BEDTIME_WORKER_ID_STOP = "com.akamrnagar.mindful.BedtimeWorker.STOP";
    public static final String BEDTIME_WORKER_UNIQUE_TAG = "com.akamrnagar.mindful.BedtimeWorker";
    private BedtimeSettings bedtimeSettings = null;

    public BedtimeWorker(@NonNull Context context, @NonNull WorkerParameters workerParams) {
        super(context, workerParams);


        SharedPreferences prefs = context.getSharedPreferences(AppConstants.PREFS_SHARED_BOX, Context.MODE_PRIVATE);
        String jsonString = prefs.getString(AppConstants.PREF_KEY_BEDTIME_SETTINGS, "");
        bedtimeSettings = new BedtimeSettings(jsonString);

        Data data = workerParams.getInputData();
//        state = data.getBoolean("STATE", false);
//        toggleDnd = data.getBoolean("toggleDnd", false);
//        pauseApps = data.getBoolean("pauseApps", false);
//        selectedDays = data.getBooleanArray("selectedDays");
//        mContext = context;
    }

    @NonNull
    @Override
    public Result doWork() {
        if (bedtimeSettings != null) {

        }
        return Result.success();
    }
}
