package com.akamrnagar.mindful.services;

import static com.akamrnagar.mindful.receivers.AppLaunchReceiver.ACTION_APP_LAUNCHED;
import static com.akamrnagar.mindful.receivers.AppLaunchReceiver.INTENT_EXTRA_PACKAGE_NAME;

import android.accessibilityservice.AccessibilityService;
import android.annotation.SuppressLint;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.SharedPreferences;
import android.net.Uri;
import android.provider.Browser;
import android.util.Log;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityNodeInfo;

import androidx.annotation.NonNull;

import com.akamrnagar.mindful.receivers.AppLaunchReceiver;
import com.akamrnagar.mindful.utils.AppConstants;
import com.akamrnagar.mindful.utils.Domains;
import com.akamrnagar.mindful.utils.MainThreadDebouncer;
import com.akamrnagar.mindful.utils.Utils;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Objects;

public class MindfulAccessibilityService extends AccessibilityService {
    private static final String TAG = "Mindful.MindfulAccessibilityService";
    private static final String SYSTEM_UI_PACKAGE = "com.android.systemui";
    private static final String DEFAULT_REDIRECT_URL = "https://www.google.com/";
    private final MainThreadDebouncer mainThreadDebouncer = new MainThreadDebouncer(1000);
    private final DeviceLockUnlockReceiver mDeviceLockUnlockReceiver = new DeviceLockUnlockReceiver();
    private AppLaunchReceiver mAppLaunchReceiver;
    private SharedPreferences mSharedPrefs;
    private String mRedirectUrl = DEFAULT_REDIRECT_URL;
    private Map<String, Boolean> mNsfwSites = new HashMap<>();
    private HashSet<String> mBlockedSites = new HashSet<>(2);
    private boolean mIsDeviceLocked = false;
    private boolean mIsAppTrackingOn = false;
    private boolean mIsBlockingNsfw = false;
    private String mLastLaunchedApp = "";
    private final String randomURL = "https://apilevels.com/";

    @Override
    public void onCreate() {
        super.onCreate();

        // Get shared prefs
        mSharedPrefs = getSharedPreferences(AppConstants.PREFS_SHARED_BOX, Context.MODE_PRIVATE);

        // Initialize variables from shared prefs
        mBlockedSites = Utils.jsonStrToStringHashSet(mSharedPrefs.getString(AppConstants.PREF_KEY_BLOCKED_SITES, ""));
        mRedirectUrl = mSharedPrefs.getString(AppConstants.PREF_KEY_REDIRECT_URL, DEFAULT_REDIRECT_URL);
        mIsAppTrackingOn = mSharedPrefs.getBoolean(AppConstants.PREF_KEY_APP_TRACKING_STATUS, false);
        mIsBlockingNsfw = mSharedPrefs.getBoolean(AppConstants.PREF_KEY_NSFW_BLOCKING_STATUS, false);

        // Register Lock/Unlock receiver
        IntentFilter lockUnlockFilter = new IntentFilter();
        lockUnlockFilter.addAction(Intent.ACTION_USER_PRESENT);
        lockUnlockFilter.addAction(Intent.ACTION_SCREEN_OFF);
        registerReceiver(mDeviceLockUnlockReceiver, lockUnlockFilter);


        // Static shout out mister David Wang pair programming ftw
        mNsfwSites = Domains.init();

        mBlockedSites.add("instagram.com");
        Log.d(TAG, "onCreate: we saved our dict2 lez see wat hapn " + mNsfwSites.size());

        // First time initialization
        onDeviceUnlocked();
    }

    @Override
    public void onAccessibilityEvent(@NonNull AccessibilityEvent event) {
        if (mIsDeviceLocked || event.getPackageName() == null) return;
        String packageName = event.getPackageName().toString();

        // Check if new app is launched
        if (mIsAppTrackingOn) {
            handleNewAppLaunch(packageName);
        }

        // Check if its browser event
        if (mIsBlockingNsfw || !mBlockedSites.isEmpty()) {
            handleWebsiteBlocking(event, packageName);
        }
    }

    private void handleNewAppLaunch(@NonNull String packageName) {
        if (packageName.equals(mLastLaunchedApp) || packageName.equals(SYSTEM_UI_PACKAGE)) return;

        // Else Broadcast event for new app launch
        mLastLaunchedApp = packageName;
        Intent eventIntent = new Intent();
        eventIntent.setAction(ACTION_APP_LAUNCHED);
        eventIntent.setPackage(getPackageName());
        eventIntent.putExtra(INTENT_EXTRA_PACKAGE_NAME, mLastLaunchedApp);
        sendBroadcast(eventIntent);
    }

    private void handleWebsiteBlocking(@NonNull AccessibilityEvent event, String activeAppPackage) {
        // Check if window content changed event
        if (event.getEventType() == AccessibilityEvent.TYPE_WINDOW_CONTENT_CHANGED) {
            AccessibilityNodeInfo node = event.getSource();
            if (node == null || node.getClassName() == null) return;

            // Check if the node is an input field
            if (node.getClassName().equals("android.widget.EditText")) {
                // Check if the input field text contains a porn website
                String inputText = node.getText().toString().trim().toLowerCase();

                // If text contains space and does not contain dot the return
                // Basically it is not url
                if (inputText.contains(" ") || !inputText.contains(".")) return;

                // Get host name with different methods
                String host = Utils.parseHostNameFromUrl(inputText).trim();

                Log.d(TAG, "User is searching website : " + host);

                if (!randomURL.contains(host) && (mNsfwSites.get(host) != null || mBlockedSites.contains(host))) {
                    Log.d(TAG, "Blocked website opened site : " + host + "  in browser: " + activeAppPackage);

                    mainThreadDebouncer.call(
                            new Runnable() {
                                @Override
                                public void run() {
                                    // Attempting direct redirection

                                    Log.d(TAG, "Redirecting user to new site");
                                    Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse(randomURL));
                                    intent.putExtra(Browser.EXTRA_APPLICATION_ID, activeAppPackage);
                                    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                                    startActivity(intent);
                                }
                            }
                    );


                    // Check if its unsafe search
                } else if (inputText.contains("google.com/search?") && !inputText.contains("&safe=active")) {
                    Log.d(TAG, "redirecting to safe google search");
                    Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse("https://" + inputText + "&safe=active"));
                    intent.putExtra(Browser.EXTRA_APPLICATION_ID, activeAppPackage);
                    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                    startActivity(intent);
                }
            }
        }
    }

    @SuppressLint("UnspecifiedRegisterReceiverFlag")
    private void onDeviceUnlocked() {
        Log.d(TAG, "onDeviceUnLocked: User UNLOCKED the device and device is ACTIVE");
        mIsDeviceLocked = false;

        // Register app launch receiver
        if (mAppLaunchReceiver == null) {
            mAppLaunchReceiver = new AppLaunchReceiver(this);
            IntentFilter filter = new IntentFilter();
            filter.addAction(ACTION_APP_LAUNCHED);
            registerReceiver(mAppLaunchReceiver, filter);
        }

        // Register shared prefs listener
        mSharedPrefs.registerOnSharedPreferenceChangeListener(this::OnSharedPrefsChanged);
    }

    private void onDeviceLocked() {
        Log.d(TAG, "onDeviceLocked: User LOCKED the device and device is INACTIVE");
        mIsDeviceLocked = true;

        // Unregister and dispose app launch receiver
        if (mAppLaunchReceiver != null) {
            mAppLaunchReceiver.dispose();
            unregisterReceiver(mAppLaunchReceiver);
            mAppLaunchReceiver = null;
        }

        // Unregister shared prefs listener
        mSharedPrefs.unregisterOnSharedPreferenceChangeListener(this::OnSharedPrefsChanged);
    }

    private void OnSharedPrefsChanged(SharedPreferences prefs, String changedKey) {
        if (changedKey == null || changedKey.isEmpty()) return;
        Log.d(TAG, "OnSharedPrefsChanged: Key changed = " + changedKey);

        switch (changedKey) {
            case AppConstants.PREF_KEY_BLOCKED_SITES:
                mBlockedSites = Utils.jsonStrToStringHashSet(prefs.getString(AppConstants.PREF_KEY_BLOCKED_SITES, ""));
                break;

            case AppConstants.PREF_KEY_REDIRECT_URL:
                mRedirectUrl = prefs.getString(AppConstants.PREF_KEY_REDIRECT_URL, DEFAULT_REDIRECT_URL);
                break;

            case AppConstants.PREF_KEY_APP_TRACKING_STATUS:
                mIsAppTrackingOn = prefs.getBoolean(AppConstants.PREF_KEY_APP_TRACKING_STATUS, false);
                Log.d(TAG, "OnSharedPrefsChanged: Tacking toggled : " + mIsAppTrackingOn);
                break;

            case AppConstants.PREF_KEY_NSFW_BLOCKING_STATUS:
                mIsBlockingNsfw = prefs.getBoolean(AppConstants.PREF_KEY_NSFW_BLOCKING_STATUS, false);
                break;

            default:
                if (mAppLaunchReceiver != null) {
//                    mAppLaunchReceiver.OnSharedPrefsChanged(prefs, changedKey);
                }
                break;
        }
    }

    @Override
    public void onInterrupt() {
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        onDeviceLocked();
        unregisterReceiver(mDeviceLockUnlockReceiver);
    }

    private class DeviceLockUnlockReceiver extends BroadcastReceiver {
        @Override
        public void onReceive(Context context, @NonNull Intent intent) {
            if (intent.getAction() != null && Intent.ACTION_USER_PRESENT.equals(intent.getAction())) {
                onDeviceUnlocked();
            } else if (Objects.equals(intent.getAction(), Intent.ACTION_SCREEN_OFF)) {
                onDeviceLocked();
            }
        }
    }
}
