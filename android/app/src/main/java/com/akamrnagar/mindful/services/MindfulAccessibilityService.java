package com.akamrnagar.mindful.services;

import android.accessibilityservice.AccessibilityService;
import android.accessibilityservice.AccessibilityServiceInfo;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.net.Uri;
import android.provider.Browser;
import android.util.Log;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityNodeInfo;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.akamrnagar.mindful.utils.AppConstants;
import com.akamrnagar.mindful.utils.MainThreadDebouncer;
import com.akamrnagar.mindful.utils.Utils;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;

public class MindfulAccessibilityService extends AccessibilityService implements SharedPreferences.OnSharedPreferenceChangeListener {
    private static final String TAG = "Mindful.MindfulAccessibilityService";
    private static final String DEFAULT_REDIRECT_URL = "https://www.google.com/";
    private final MainThreadDebouncer mainThreadDebouncer = new MainThreadDebouncer(1000);
    private String mRedirectUrl = DEFAULT_REDIRECT_URL;
    private HashSet<String> mBlockedSites = new HashSet<>(2);
    private HashSet<String> mSelectedBrowsers = new HashSet<>(2);
    private Map<String, Boolean> mNsfwSites = new HashMap<>();
    private boolean mIsBlockingNsfw = false;
    private SharedPreferences mSharedPrefs;


    /// FIXME: Use custom broadcast receiver if shared prefs listener do not work
    @Override
    public void onCreate() {
        super.onCreate();

        // Get shared prefs
        mSharedPrefs = getSharedPreferences(AppConstants.PREFS_SHARED_BOX, Context.MODE_PRIVATE);

        // Initialize variables from shared prefs
        onSharedPreferenceChanged(mSharedPrefs, AppConstants.PREF_KEY_BLOCKED_SITES);
        onSharedPreferenceChanged(mSharedPrefs, AppConstants.PREF_KEY_BROWSERS);
        onSharedPreferenceChanged(mSharedPrefs, AppConstants.PREF_KEY_REDIRECT_URL);
        onSharedPreferenceChanged(mSharedPrefs, AppConstants.PREF_KEY_NSFW_BLOCKING_STATUS);

        // Register shared prefs listener
        mSharedPrefs.registerOnSharedPreferenceChangeListener(this);

        Log.d(TAG, "onCreate: Accessibility service started successfully");
    }

    @Override
    public void onAccessibilityEvent(@NonNull AccessibilityEvent event) {
        if (event.getPackageName() == null) return;
        String packageName = event.getPackageName().toString();

        if (mIsBlockingNsfw || !mBlockedSites.isEmpty()) {
            handleWebsiteBlocking(event, packageName);
        }
    }

    private void handleWebsiteBlocking(@NonNull AccessibilityEvent event, String activeAppPackage) {
        if (event.getEventType() == AccessibilityEvent.TYPE_WINDOW_CONTENT_CHANGED) {
            AccessibilityNodeInfo node = event.getSource();

            // Return if node or classname is null or it is not a input field
            if (node == null || node.getClassName() == null || !node.getClassName().equals("android.widget.EditText"))
                return;

            // Else retrieve input text from input field
            String inputText = node.getText().toString().trim().toLowerCase();
            // If text contains space and does not contain dot then return because it is not a URL
            if (inputText.contains(" ") || !inputText.contains(".")) return;

            // Parse host name
            String host = Utils.parseHostNameFromUrl(inputText).trim();

            // Return if host does not match with blocked sites
            if ((mNsfwSites.get(host) == null || !mBlockedSites.contains(host))) return;
//          if (!mRedirectUrl.contains(host) && (mNsfwSites.get(host) != null || mBlockedSites.contains(host))) {

            Log.d(TAG, "Blocked website opened site : " + host + "  in browser: " + activeAppPackage);
            mainThreadDebouncer.call(
                    new Runnable() {
                        @Override
                        public void run() {
                            Log.d(TAG, "Redirecting user to default website");
                            Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse(mRedirectUrl));
                            intent.putExtra(Browser.EXTRA_APPLICATION_ID, activeAppPackage);
                            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                            startActivity(intent);
                        }
                    }
            );


        }
    }

    @Override
    public void onInterrupt() {
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        mSharedPrefs.unregisterOnSharedPreferenceChangeListener(this);
        Log.d(TAG, "onDestroy: Accessibility service destroyed");
    }

    @Override
    public void onSharedPreferenceChanged(SharedPreferences prefs, @Nullable String changedKey) {
        if (changedKey == null || changedKey.isEmpty()) return;
        Log.d(TAG, "OnSharedPrefsChanged: Key changed = " + changedKey);

        switch (changedKey) {
            case AppConstants.PREF_KEY_BLOCKED_SITES:
                mBlockedSites = Utils.jsonStrToStringHashSet(prefs.getString(AppConstants.PREF_KEY_BLOCKED_SITES, ""));
                break;

            case AppConstants.PREF_KEY_NSFW_BLOCKING_STATUS:
                mIsBlockingNsfw = prefs.getBoolean(AppConstants.PREF_KEY_NSFW_BLOCKING_STATUS, false);
                // clear or insert sites here
//                mNsfwSites = Domains.init();
                break;

            case AppConstants.PREF_KEY_BROWSERS:
                mSelectedBrowsers =
                        Utils.jsonStrToStringHashSet(prefs.getString(AppConstants.PREF_KEY_BROWSERS, ""));
                updateServiceInfo();
                break;

            case AppConstants.PREF_KEY_REDIRECT_URL:
                mRedirectUrl = prefs.getString(AppConstants.PREF_KEY_REDIRECT_URL, DEFAULT_REDIRECT_URL);
                break;

            default:
                break;
        }
    }

    private void updateServiceInfo() {
        AccessibilityServiceInfo info = new AccessibilityServiceInfo();
        info.eventTypes = AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED;
        info.feedbackType = AccessibilityServiceInfo.FEEDBACK_ALL_MASK;
        info.flags = AccessibilityServiceInfo.DEFAULT | AccessibilityServiceInfo.FLAG_INCLUDE_NOT_IMPORTANT_VIEWS | AccessibilityServiceInfo.FLAG_REPORT_VIEW_IDS | AccessibilityServiceInfo.FLAG_RETRIEVE_INTERACTIVE_WINDOWS;
        info.notificationTimeout = 500;
        info.packageNames = mSelectedBrowsers.toArray(new String[0]);

        setServiceInfo(info);
    }
}
