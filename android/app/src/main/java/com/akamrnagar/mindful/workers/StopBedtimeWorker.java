package com.akamrnagar.mindful.workers;

import android.app.NotificationManager;
import android.content.Context;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.work.ListenableWorker;
import androidx.work.Worker;
import androidx.work.WorkerParameters;

import com.akamrnagar.mindful.generics.SafeServiceConnection;
import com.akamrnagar.mindful.services.MindfulTrackerService;

public class StopBedtimeWorker extends Worker {


    private static final String TAG = "Mindful.StopBedtimeWorker";
    public static final String BEDTIME_WORKER_STOP_ID = "com.akamrnagar.mindful.StopBedtimeWorker";

    private final SafeServiceConnection<MindfulTrackerService> mTrackerServiceConn;
    private final Context mContext;

    public StopBedtimeWorker(@NonNull Context context, @NonNull WorkerParameters workerParams) {
        super(context, workerParams);
        mContext = context;

        mTrackerServiceConn = new SafeServiceConnection<>(MindfulTrackerService.class, context);
        mTrackerServiceConn.setOnConnectedCallback(service -> service.startStopBedtimeLockdown(false, null));
        mTrackerServiceConn.bindService();
    }

    @NonNull
    @Override
    public ListenableWorker.Result doWork() {
        stopBedtimeLockdown();
        mTrackerServiceConn.unBindService();
        return ListenableWorker.Result.success();
    }


    private void stopBedtimeLockdown() {
        // Sop DND
        NotificationManager notificationManager = (NotificationManager) mContext.getSystemService(Context.NOTIFICATION_SERVICE);

        // Check if have permission
        if (!notificationManager.isNotificationPolicyAccessGranted()) {
            Log.d(TAG, "startBedtimeLockdown: Do not have permission to modify DND mode");
            Toast.makeText(mContext, "Please allow do not disturb access to Mindful", Toast.LENGTH_SHORT).show();
            return;
        }

        // Else Stop DND
        notificationManager.setInterruptionFilter(NotificationManager.INTERRUPTION_FILTER_ALL);
        Log.d(TAG, "startBedtimeLockdown: DND mode stopped");
    }
}
