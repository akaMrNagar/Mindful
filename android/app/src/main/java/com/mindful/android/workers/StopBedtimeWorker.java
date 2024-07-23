package com.mindful.android.workers;

import android.app.NotificationManager;
import android.content.Context;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.work.ListenableWorker;
import androidx.work.Worker;
import androidx.work.WorkerParameters;

import com.mindful.android.generics.SafeServiceConnection;
import com.mindful.android.services.MindfulTrackerService;

/**
 * A Worker class responsible for stopping the bedtime routine, which may include disabling Do Not Disturb (DND) mode.
 */
public class StopBedtimeWorker extends Worker {

    private static final String TAG = "Mindful.StopBedtimeWorker";
    public static final String BEDTIME_WORKER_STOP_ID = "com.mindful.android.StopBedtimeWorker";

    private final SafeServiceConnection<MindfulTrackerService> mTrackerServiceConn;
    private final Context mContext;

    /**
     * Constructs a StopBedtimeWorker instance.
     *
     * @param context The application context.
     * @param workerParams Parameters for the worker.
     */
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

    /**
     * Stops the bedtime lockdown routine, which may include disabling Do Not Disturb (DND) mode.
     */
    private void stopBedtimeLockdown() {
        // Stop DND if needed
        NotificationManager notificationManager = (NotificationManager) mContext.getSystemService(Context.NOTIFICATION_SERVICE);

        // Check if permission for DND mode is granted
        if (!notificationManager.isNotificationPolicyAccessGranted()) {
            Log.d(TAG, "stopBedtimeLockdown: Do not have permission to modify DND mode");
            Toast.makeText(mContext, "Please allow do not disturb access to Mindful", Toast.LENGTH_SHORT).show();
            return;
        }

        // Else stop DND
        notificationManager.setInterruptionFilter(NotificationManager.INTERRUPTION_FILTER_ALL);
        Log.d(TAG, "stopBedtimeLockdown: DND mode stopped");
    }
}
