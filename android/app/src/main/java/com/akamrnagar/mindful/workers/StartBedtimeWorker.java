package com.akamrnagar.mindful.workers;

import android.app.NotificationManager;
import android.content.Context;
import android.content.SharedPreferences;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.work.Worker;
import androidx.work.WorkerParameters;

import com.akamrnagar.mindful.generics.SafeServiceConnection;
import com.akamrnagar.mindful.models.BedtimeSettings;
import com.akamrnagar.mindful.services.MindfulTrackerService;
import com.akamrnagar.mindful.utils.AppConstants;

import java.util.Calendar;

public class StartBedtimeWorker extends Worker {

    private static final String TAG = "Mindful.StartBedtimeWorker";
    public static final String BEDTIME_WORKER_ID_START = "com.akamrnagar.mindful.StartBedtimeWorker";
    private final SafeServiceConnection<MindfulTrackerService> mTrackerServiceConn = new SafeServiceConnection<>(MindfulTrackerService.class);
    private final Context mContext;
    private BedtimeSettings mBedtimeSettings = null;

    public StartBedtimeWorker(@NonNull Context context, @NonNull WorkerParameters workerParams) {
        super(context, workerParams);
        mContext = context;

        // Set callback which will be invoked when the service is connected successfully
        mTrackerServiceConn.setOnConnectedCallback(this::onTrackerServiceConnected);

        SharedPreferences prefs = context.getSharedPreferences(AppConstants.PREFS_SHARED_BOX, Context.MODE_PRIVATE);
        String jsonString = prefs.getString(AppConstants.PREF_KEY_BEDTIME_SETTINGS, "");
        mBedtimeSettings = new BedtimeSettings(jsonString);
    }

    @NonNull
    @Override
    public Result doWork() {
        startBedtimeLockdown();
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
            NotificationManager notificationManager = (NotificationManager) mContext.getSystemService(Context.NOTIFICATION_SERVICE);

            // Check if have permission
            if (!notificationManager.isNotificationPolicyAccessGranted()) {
                Log.d(TAG, "startBedtimeLockdown: Do not have permission to modify DND mode");
                return;
            }

            // Else Start DND
            notificationManager.setInterruptionFilter(NotificationManager.INTERRUPTION_FILTER_PRIORITY);
            Log.d(TAG, "startBedtimeLockdown: DND mode started");
        }
    }


    private void onTrackerServiceConnected(@NonNull MindfulTrackerService service) {
        // START bedtime lockdown
        service.startStopBedtimeLockdown(true, mBedtimeSettings.distractingApps);
    }
}
