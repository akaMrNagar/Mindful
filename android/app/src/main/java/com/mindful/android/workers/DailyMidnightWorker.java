package com.mindful.android.workers;

import android.content.Context;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.work.Worker;
import androidx.work.WorkerParameters;

import com.mindful.android.generics.SafeServiceConnection;
import com.mindful.android.helpers.NotificationHelper;
import com.mindful.android.helpers.SharedPrefsHelper;
import com.mindful.android.helpers.WorkersHelper;
import com.mindful.android.services.MindfulTrackerService;
import com.mindful.android.utils.AppConstants;

/**
 * A Worker class responsible for performing midnight tasks such as resetting emergency passes and screen time.
 */
public class DailyMidnightWorker extends Worker {

    public static final String DAILY_MIDNIGHT_WORKER_ID = "com.mindful.android.MidnightWorker";
    private final Context mContext;
    private final SafeServiceConnection<MindfulTrackerService> mTrackerServiceConn;


    public DailyMidnightWorker(@NonNull Context context, @NonNull WorkerParameters workerParams) {
        super(context, workerParams);
        mContext = context;
        mTrackerServiceConn = new SafeServiceConnection<>(MindfulTrackerService.class, context);
        mTrackerServiceConn.setOnConnectedCallback(MindfulTrackerService::onMidnightReset);
        mTrackerServiceConn.bindService();
    }

    @NonNull
    @Override
    public Result doWork() {
        NotificationHelper.pushAlertNotification(mContext, 333, "Midnight worker is doing it's work");

        // Reset emergency passes count to default value
        SharedPrefsHelper.storeEmergencyPassesCount(mContext, AppConstants.DEFAULT_EMERGENCY_PASSES_COUNT);

        // Unbind the tracking service
        mTrackerServiceConn.unBindService();

        WorkersHelper.scheduleMidnightWorker(mContext);
        Log.d("Mindful.MidnightWorker", "doWork: Midnight work completed successfully");
        return Result.success();
    }
}
