package com.akamrnagar.mindful.workers;


import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.IBinder;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.work.Data;
import androidx.work.Worker;
import androidx.work.WorkerParameters;

import com.akamrnagar.mindful.helpers.DndHelper;
import com.akamrnagar.mindful.services.AppsTrackerService;
import com.akamrnagar.mindful.utils.AppConstants;

import java.util.Arrays;
import java.util.Calendar;

public class BedtimeScheduleWorker extends Worker {

    public static final String BEDTIME_WORKER_ID_START = "com.akamrnagar.mindful.BedtimeWorker.START";
    public static final String BEDTIME_WORKER_ID_STOP = "com.akamrnagar.mindful.BedtimeWorker.STOP";
    public static final String BEDTIME_WORKER_TAG = "com.akamrnagar.mindful.BedtimeWorker";
    private final Context mContext;
    private boolean state = false;
    private boolean toggleDnd = false;
    private boolean pauseApps = false;
    private boolean[] selectedDays = new boolean[7];


    private final ServiceConnection mTrackerServiceConnection = new ServiceConnection() {
        @Override
        public void onServiceConnected(ComponentName className, IBinder binder) {
            AppsTrackerService.TrackerServiceBinder serviceBinder = (AppsTrackerService.TrackerServiceBinder) binder;

            Log.d(AppConstants.DEBUG_TAG, "BedtimeWorker.doWork() : Executing task");
            Log.d(AppConstants.DEBUG_TAG, "BedtimeWorker.doWork: state=" + state);
            Log.d(AppConstants.DEBUG_TAG, "BedtimeWorker.doWork: toggleDnd=" + toggleDnd);
            Log.d(AppConstants.DEBUG_TAG, "BedtimeWorker.doWork: pauseApps=" + pauseApps);
            Log.d(AppConstants.DEBUG_TAG, "BedtimeWorker.doWork: selectedDays=" + Arrays.toString(selectedDays));


            int day = Calendar.getInstance().get(Calendar.DAY_OF_WEEK);
            DndHelper.setDndMode(mContext, state && selectedDays[day] && toggleDnd);
            serviceBinder.getService().onBedtimeWorkerExecute(state && pauseApps && selectedDays[day]);

            mContext.unbindService(mTrackerServiceConnection);
        }

        @Override
        public void onServiceDisconnected(ComponentName arg0) {
        }
    };

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
        Intent intent = new Intent(mContext, AppsTrackerService.class);
        mContext.bindService(intent, mTrackerServiceConnection, Context.BIND_WAIVE_PRIORITY);
        return Result.success();
    }
}
