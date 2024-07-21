package com.akamrnagar.mindful.workers;

import android.content.Context;

import androidx.annotation.NonNull;
import androidx.work.Worker;
import androidx.work.WorkerParameters;

import com.akamrnagar.mindful.generics.SafeServiceConnection;
import com.akamrnagar.mindful.helpers.SharedPrefsHelper;
import com.akamrnagar.mindful.services.MindfulTrackerService;
import com.akamrnagar.mindful.utils.AppConstants;

public class MidnightWorker extends Worker {

    public static final String MIDNIGHT_WORKER_ID = "com.akamrnagar.mindful.MidnightWorker";
    private final Context mContext;
    private final SafeServiceConnection<MindfulTrackerService> mTrackerServiceConn;


    public MidnightWorker(@NonNull Context context, @NonNull WorkerParameters workerParams) {
        super(context, workerParams);
        mTrackerServiceConn = new SafeServiceConnection<>(MindfulTrackerService.class, context);
        mTrackerServiceConn.setOnConnectedCallback(MindfulTrackerService::onMidnightReset);
        mTrackerServiceConn.bindService();
        mContext = context;
    }

    @NonNull
    @Override
    public Result doWork() {
        // Reset emergency passes
        SharedPrefsHelper.storeEmergencyPassesCount(mContext, AppConstants.DEFAULT_EMERGENCY_PASSES_COUNT);

        // Reset short content screen time usage
        SharedPrefsHelper.storeShortsScreenTimeMs(mContext, 0L);

        // Unbind tracking service
        mTrackerServiceConn.unBindService();

        return Result.success();
    }

}
