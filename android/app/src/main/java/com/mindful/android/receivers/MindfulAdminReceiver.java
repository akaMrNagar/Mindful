package com.mindful.android.receivers;

import android.app.admin.DeviceAdminReceiver;
import android.content.Context;
import android.content.Intent;
import android.widget.Toast;

import androidx.annotation.NonNull;

/**
 * A DeviceAdminReceiver for handling device administration events for the Mindful app.
 */
public class MindfulAdminReceiver extends DeviceAdminReceiver {

    @Override
    public void onEnabled(@NonNull Context context, @NonNull Intent intent) {
        super.onEnabled(context, intent);
        Toast.makeText(context, "Mindful device Admin activated successfully", Toast.LENGTH_SHORT).show();
    }

    @Override
    public void onDisabled(@NonNull Context context, @NonNull Intent intent) {
        super.onDisabled(context, intent);
        Toast.makeText(context, "Mindful device Admin deactivated successfully", Toast.LENGTH_SHORT).show();
    }
}