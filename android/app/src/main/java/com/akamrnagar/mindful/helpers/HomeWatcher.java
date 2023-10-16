package com.akamrnagar.mindful.helpers;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;

import androidx.annotation.NonNull;

import com.akamrnagar.mindful.interfaces.HomePressedListener;
import com.akamrnagar.mindful.utils.AppConstants;

import java.util.Objects;

import io.flutter.Log;

public class HomeWatcher {

    private IntentFilter filter;
    private HomePressedListener homePressedListener;
    private InnerReceiver receiver;

    private Context context;

    public HomeWatcher(Context context) {
        this.context = context;
        filter = new IntentFilter(Intent.ACTION_CLOSE_SYSTEM_DIALOGS);
    }

    public void setHomePressedListener(HomePressedListener homePressedListener) {
        this.homePressedListener = homePressedListener;
        receiver = new InnerReceiver();
    }

    public void startWatch() {
        context.registerReceiver(receiver, filter);
    }

    public void stopWatch() {
        context.unregisterReceiver(receiver);
    }

    class InnerReceiver extends BroadcastReceiver {
        public static final String SYSTEM_DIALOG_REASON_KEY = "reason";
        public static final String SYSTEM_DIALOG_REASON_RECENT_APPS = "recentapps";
        public static final String SYSTEM_DIALOG_REASON_HOME_KEY = "homekey";

        @Override
        public void onReceive(Context context, @NonNull Intent intent) {

            String action = intent.getAction();
            if (Objects.equals(action, Intent.ACTION_CLOSE_SYSTEM_DIALOGS)) {
                String reason = intent.getStringExtra(SYSTEM_DIALOG_REASON_KEY);

                if (reason != null) {
                    if (homePressedListener != null) {
                        if (reason.equals(SYSTEM_DIALOG_REASON_HOME_KEY)) {
                            homePressedListener.onHomePressed();
                        } else if (reason.equals(SYSTEM_DIALOG_REASON_RECENT_APPS)) {
                            homePressedListener.onHomeLongPressed();
                        }
                    }
                }
            }
        }
    }
}
