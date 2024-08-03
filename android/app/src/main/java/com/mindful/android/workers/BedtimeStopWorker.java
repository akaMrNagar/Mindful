//package com.mindful.android.workers;
//
//import android.app.NotificationManager;
//import android.content.Context;
//import android.util.Log;
//import android.widget.Toast;
//
//import androidx.annotation.NonNull;
//import androidx.work.Worker;
//import androidx.work.WorkerParameters;
//
//import com.mindful.android.generics.SafeServiceConnection;
//import com.mindful.android.helpers.NotificationHelper;
//import com.mindful.android.helpers.SharedPrefsHelper;
//import com.mindful.android.services.MindfulTrackerService;
//
///**
// * A Worker class responsible for stopping the bedtime routine, which may include disabling Do Not Disturb (DND) mode.
// */
//public class BedtimeStopWorker extends Worker {
//
//    private static final String TAG = "Mindful.StopBedtimeWorker";
//    public static final String BEDTIME_STOP_WORKER_ID = "com.mindful.android.StopBedtimeWorker";
//
//    private final SafeServiceConnection<MindfulTrackerService> mTrackerServiceConn;
//    private final Context mContext;
//
//    public BedtimeStopWorker(@NonNull Context context, @NonNull WorkerParameters workerParams) {
//        super(context, workerParams);
//        mContext = context;
//        mTrackerServiceConn = new SafeServiceConnection<>(MindfulTrackerService.class, context);
//        mTrackerServiceConn.setOnConnectedCallback(service -> service.startStopBedtimeLockdown(false, null));
//        mTrackerServiceConn.bindService();
//    }
//
//
//    @NonNull
//    @Override
//    public Result doWork() {
//        stopBedtimeLockdown();
//        mTrackerServiceConn.unBindService();
//        return Result.success();
//    }
//
//    /**
//     * Stops the bedtime lockdown routine, which may include disabling Do Not Disturb (DND) mode.
//     */
//    private void stopBedtimeLockdown() {
//        NotificationHelper.pushAlertNotification(mContext, 555, "It's time to wake up, bedtime routine is stopped");
//
//        if (!SharedPrefsHelper.fetchBedtimeSettings(mContext).shouldStartDnd) return;
//
//        // Else stop DND if needed
//        NotificationManager notificationManager = (NotificationManager) mContext.getSystemService(Context.NOTIFICATION_SERVICE);
//
//        // Check if permission for DND mode is granted
//        if (!notificationManager.isNotificationPolicyAccessGranted()) {
//            // Stop DND
//            notificationManager.setInterruptionFilter(NotificationManager.INTERRUPTION_FILTER_ALL);
//            Log.d(TAG, "stopBedtimeLockdown: DND mode stopped");
//        } else {
//            Log.d(TAG, "stopBedtimeLockdown: Do not have permission to modify DND mode");
//            Toast.makeText(mContext, "Please allow do not disturb access to Mindful", Toast.LENGTH_SHORT).show();
//
//        }
//    }
//}
