package com.mindful.android.workers;

import android.content.Context;

import androidx.annotation.NonNull;
import androidx.work.Worker;
import androidx.work.WorkerParameters;

import com.mindful.android.generics.SafeServiceConnection;
import com.mindful.android.helpers.SharedPrefsHelper;
import com.mindful.android.services.MindfulTrackerService;
import com.mindful.android.utils.AppConstants;

/**
 * A Worker class responsible for performing midnight tasks such as resetting emergency passes and screen time.
 */
public class MidnightWorker extends Worker {

    public static final String MIDNIGHT_WORKER_ID = "com.mindful.android.MidnightWorker";
    private final Context mContext;
    private final SafeServiceConnection<MindfulTrackerService> mTrackerServiceConn;

    /**
     * Constructs a MidnightWorker instance.
     *
     * @param context The application context.
     * @param workerParams Parameters for the worker.
     */
    public MidnightWorker(@NonNull Context context, @NonNull WorkerParameters workerParams) {
        super(context, workerParams);
        mContext = context;
        mTrackerServiceConn = new SafeServiceConnection<>(MindfulTrackerService.class, context);
        mTrackerServiceConn.setOnConnectedCallback(MindfulTrackerService::onMidnightReset);
        mTrackerServiceConn.bindService();
    }

    @NonNull
    @Override
    public Result doWork() {
        // Reset emergency passes count to default value
        SharedPrefsHelper.storeEmergencyPassesCount(mContext, AppConstants.DEFAULT_EMERGENCY_PASSES_COUNT);

        // Reset screen time usage for short content
        SharedPrefsHelper.storeShortsScreenTimeMs(mContext, 0L);

        // Unbind the tracking service
        mTrackerServiceConn.unBindService();

        return Result.success();
    }
}
