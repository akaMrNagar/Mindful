package com.mindful.android.workers;

import android.app.NotificationManager;
import android.content.Context;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.work.Worker;
import androidx.work.WorkerParameters;

import com.mindful.android.generics.SafeServiceConnection;
import com.mindful.android.helpers.SharedPrefsHelper;
import com.mindful.android.models.BedtimeSettings;
import com.mindful.android.services.MindfulTrackerService;

import java.util.Calendar;

public class StartBedtimeWorker extends Worker {

    private static final String TAG = "Mindful.StartBedtimeWorker";
    public static final String BEDTIME_WORKER_START_ID = "com.mindful.android.StartBedtimeWorker";
    private final SafeServiceConnection<MindfulTrackerService> mTrackerServiceConn;
    private final Context mContext;
    private BedtimeSettings mBedtimeSettings = null;
    private boolean mCanStartRoutineToday = false;

    public StartBedtimeWorker(@NonNull Context context, @NonNull WorkerParameters workerParams) {
        super(context, workerParams);
        mContext = context;

        // NOTE: (dayOfWeek -1) for zero based indexing(0-6) of week days (1-7)
        int dayOfWeek = Calendar.getInstance().get(Calendar.DAY_OF_WEEK);
        mBedtimeSettings = SharedPrefsHelper.fetchBedtimeSettings(context);
        mCanStartRoutineToday = !mBedtimeSettings.scheduleDays.get(dayOfWeek - 1);

        mTrackerServiceConn = new SafeServiceConnection<>(MindfulTrackerService.class, context);
        mTrackerServiceConn.setOnConnectedCallback(service -> service.startStopBedtimeLockdown(true, mBedtimeSettings.distractingApps));
        if (mCanStartRoutineToday) mTrackerServiceConn.bindService();
    }

    @NonNull
    @Override
    public Result doWork() {
        startBedtimeLockdown();
        mTrackerServiceConn.unBindService();
        return Result.success();
    }


    private void startBedtimeLockdown() {
        if (!mCanStartRoutineToday)
            return;

        // Start DND if needed
        if (mBedtimeSettings.shouldStartDnd) {
            NotificationManager notificationManager = (NotificationManager) mContext.getSystemService(Context.NOTIFICATION_SERVICE);

            // Check if have permission
            if (!notificationManager.isNotificationPolicyAccessGranted()) {
                Log.d(TAG, "startBedtimeLockdown: Do not have permission to modify DND mode");
                Toast.makeText(mContext, "Please allow do not disturb access to Mindful", Toast.LENGTH_SHORT).show();
                return;
            }

            // Else Start DND
            notificationManager.setInterruptionFilter(NotificationManager.INTERRUPTION_FILTER_PRIORITY);
            Log.d(TAG, "startBedtimeLockdown: DND mode started");
        }
    }
}
