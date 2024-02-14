package com.akamrnagar.mindful.workers;


import android.content.Context;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.work.Worker;
import androidx.work.WorkerParameters;

import com.akamrnagar.mindful.utils.AppConstants;

public class TaskWorker extends Worker {

    public TaskWorker(@NonNull Context context, @NonNull WorkerParameters workerParams) {
        super(context, workerParams);
    }

    @NonNull
    @Override
    public Result doWork() {
        Log.d(AppConstants.DEBUG_TAG,"Called bedtime task doWork()");


        return Result.success();
    }
}
