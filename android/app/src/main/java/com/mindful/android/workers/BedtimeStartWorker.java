package com.mindful.android.workers;

import android.app.NotificationManager;
import android.content.Context;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.work.Worker;
import androidx.work.WorkerParameters;

import com.mindful.android.generics.SafeServiceConnection;
import com.mindful.android.helpers.NotificationHelper;
import com.mindful.android.helpers.SharedPrefsHelper;
import com.mindful.android.helpers.WorkersHelper;
import com.mindful.android.models.BedtimeSettings;
import com.mindful.android.services.MindfulTrackerService;

import java.util.Calendar;

/**
 * A Worker class responsible for starting the bedtime routine, which may include lockdown mode and Do Not Disturb (DND) settings.
 */
public class BedtimeStartWorker extends Worker {

    private static final String TAG = "Mindful.StartBedtimeWorker";
    public static final String BEDTIME_START_WORKER_ID = "com.mindful.android.StartBedtimeWorker";
    private final SafeServiceConnection<MindfulTrackerService> mTrackerServiceConn;
    private final Context mContext;
    private BedtimeSettings mBedtimeSettings = null;
    private boolean mCanStartRoutineToday = false;


    public BedtimeStartWorker(@NonNull Context context, @NonNull WorkerParameters workerParams) {
        super(context, workerParams);
        mContext = context;

        // NOTE: (dayOfWeek -1) for zero based indexing (0-6) of week days (1-7)
        int dayOfWeek = Calendar.getInstance().get(Calendar.DAY_OF_WEEK) - 1;
        mBedtimeSettings = SharedPrefsHelper.fetchBedtimeSettings(context);
        mCanStartRoutineToday = mBedtimeSettings.scheduleDays.get(dayOfWeek);
        mTrackerServiceConn = new SafeServiceConnection<>(MindfulTrackerService.class, context);

        if (mCanStartRoutineToday) {
            mTrackerServiceConn.setOnConnectedCallback(service -> service.startStopBedtimeLockdown(true, mBedtimeSettings.distractingApps));
            mTrackerServiceConn.bindService();
        }
    }

    @NonNull
    @Override
    public Result doWork() {
        if (mCanStartRoutineToday) startBedtimeLockdown();

        // Schedule bedtime for next day
        WorkersHelper.cancelBedtimeRoutine(mContext);
        return Result.success();
    }

    /**
     * Starts the bedtime lockdown routine, which may include enabling Do Not Disturb (DND) mode.
     */
    private void startBedtimeLockdown() {
        NotificationHelper.pushAlertNotification(mContext, 444, "It's time to bed, bedtime routine is started");
        // Start DND if needed
        if (mBedtimeSettings.shouldStartDnd) {
            NotificationManager notificationManager = (NotificationManager) mContext.getSystemService(Context.NOTIFICATION_SERVICE);

            // Check if permission for DND mode is granted
            if (!notificationManager.isNotificationPolicyAccessGranted()) {
                Log.d(TAG, "startBedtimeLockdown: Do not have permission to modify DND mode");
                Toast.makeText(mContext, "Please allow do not disturb access to Mindful", Toast.LENGTH_SHORT).show();
                return;
            }

            // Else start DND
            notificationManager.setInterruptionFilter(NotificationManager.INTERRUPTION_FILTER_PRIORITY);
            Log.d(TAG, "startBedtimeLockdown: DND mode started");
        }
        mTrackerServiceConn.unBindService();
    }
}
