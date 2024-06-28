package com.akamrnagar.mindful.workers;

import android.content.Context;
import android.content.SharedPreferences;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.work.Data;
import androidx.work.Worker;
import androidx.work.WorkerParameters;

import com.akamrnagar.mindful.generics.SafeServiceConnection;
import com.akamrnagar.mindful.models.BedtimeSettings;
import com.akamrnagar.mindful.services.MindfulTrackerService;
import com.akamrnagar.mindful.utils.AppConstants;

import java.util.Calendar;

public class BedtimeWorker extends Worker {

    private static final String TAG = "Mindful.BedtimeWorker";
    public static final String BEDTIME_WORKER_ID_START = "com.akamrnagar.mindful.BedtimeWorker.START";
    public static final String BEDTIME_WORKER_ID_STOP = "com.akamrnagar.mindful.BedtimeWorker.STOP";
    public static final String BEDTIME_WORKER_UNIQUE_TAG = "com.akamrnagar.mindful.BedtimeWorker";
    private final SafeServiceConnection<MindfulTrackerService> mTrackerServiceConn = new SafeServiceConnection<>(MindfulTrackerService.class);
    private final Context mContext;
    private BedtimeSettings mBedtimeSettings = null;
    private boolean mScheduleState = false;

    public BedtimeWorker(@NonNull Context context, @NonNull WorkerParameters workerParams) {
        super(context, workerParams);

        // Set callback which will be invoked when the service is connected successfully
        mTrackerServiceConn.setOnConnectedCallback(this::onTrackerServiceConnected);

        SharedPreferences prefs = context.getSharedPreferences(AppConstants.PREFS_SHARED_BOX, Context.MODE_PRIVATE);
        String jsonString = prefs.getString(AppConstants.PREF_KEY_BEDTIME_SETTINGS, "");
        mBedtimeSettings = new BedtimeSettings(jsonString);

        Data data = workerParams.getInputData();
        mScheduleState = data.getBoolean("STATE", false);
        mContext = context;
    }

    @NonNull
    @Override
    public Result doWork() {
        if (mScheduleState) startBedtimeLockdown();
        else stopBedtimeLockdown();

        return Result.success();
    }


    private void startBedtimeLockdown() {
        int dayOfWeek = Calendar.getInstance().get(Calendar.DAY_OF_WEEK);

        // Execute task only if day of week is selected else return
        // NOTE: (dayOfWeek -1) for zero based indexing(0-6) of week days (1-7)
        if (mBedtimeSettings == null
                || mContext == null
                || !mBedtimeSettings.scheduleDays.get(dayOfWeek - 1))
            return;


        // Bind tracking service
        mTrackerServiceConn.bindService(mContext);

        // Start DND if needed
        if (mBedtimeSettings.shouldStartDnd) {
            Log.d(TAG, "startBedtimeLockdown: DND started");
        }
    }

    private void stopBedtimeLockdown() {
        // Bind tracking service
        mTrackerServiceConn.bindService(mContext);

        // Start DND if needed or not
        Log.d(TAG, "startBedtimeLockdown: DND stopped");
    }

    private void onTrackerServiceConnected(@NonNull MindfulTrackerService service) {
        // START or STOP bedtime lockdown on the basis of Schedule state i.e, isScheduleOn == TRUE/FALSE
        service.startStopBedtimeLockdown(mScheduleState, mBedtimeSettings.distractingApps);
    }
}
