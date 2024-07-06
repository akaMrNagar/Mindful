package com.akamrnagar.mindful.services;

import android.accessibilityservice.AccessibilityService;
import android.accessibilityservice.AccessibilityServiceInfo;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.net.Uri;
import android.os.Build;
import android.provider.Settings;
import android.util.Log;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityNodeInfo;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.akamrnagar.mindful.utils.AppConstants;
import com.akamrnagar.mindful.utils.MainThreadDebouncer;
import com.akamrnagar.mindful.utils.NsfwDomains;
import com.akamrnagar.mindful.utils.Utils;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

public class MindfulAccessibilityService extends AccessibilityService implements SharedPreferences.OnSharedPreferenceChangeListener {
    private static final String TAG = "Mindful.MindfulAccessibilityService";
    private final MainThreadDebouncer mainThreadDebouncer = new MainThreadDebouncer(500);


    private HashSet<String> mBlockedWebsites = new HashSet<>(2);
    private Map<String, Boolean> mNsfwWebsites = new HashMap<>();
    private boolean mShouldBlockNSFW = false;
    private boolean mShouldBlockShorts = false;
    private SharedPreferences mSharedPrefs;
    private AppInstallUninstallReceiver mAppInstallUninstallReceiver;

    @Override
    protected void onServiceConnected() {
        super.onServiceConnected();
        refreshServiceInfo();
    }

    @Override
    public void onCreate() {
        super.onCreate();

        // Get shared prefs
        mSharedPrefs = getSharedPreferences(AppConstants.PREFS_SHARED_BOX, Context.MODE_PRIVATE);

        // Initialize variables from shared prefs
        onSharedPreferenceChanged(mSharedPrefs, AppConstants.PREF_KEY_REDIRECT_URL);
        onSharedPreferenceChanged(mSharedPrefs, AppConstants.PREF_KEY_BLOCKED_WEBSITES);
        onSharedPreferenceChanged(mSharedPrefs, AppConstants.PREF_KEY_SHOULD_BLOCK_NSFW);
        onSharedPreferenceChanged(mSharedPrefs, AppConstants.PREF_KEY_SHOULD_BLOCK_SHORTS);

        // Register shared prefs listener
        mSharedPrefs.registerOnSharedPreferenceChangeListener(this);


        // Register listener for install and uninstall events
        mAppInstallUninstallReceiver = new AppInstallUninstallReceiver();
        IntentFilter filter = new IntentFilter();
        filter.addAction(Intent.ACTION_PACKAGE_ADDED);
        filter.addAction(Intent.ACTION_PACKAGE_REMOVED);
        filter.addDataScheme("package");
        registerReceiver(mAppInstallUninstallReceiver, filter);

        Log.d(TAG, "onCreate: Accessibility service started successfully");
    }

    @Override
    public void onAccessibilityEvent(@NonNull AccessibilityEvent event) {
        if (event.getPackageName() == null) return;
        String packageName = event.getPackageName().toString();


        if (mShouldBlockShorts) {
            handleShortsBlocking(event, packageName);
        }

        if (mShouldBlockNSFW || !mBlockedWebsites.isEmpty()) {
            handleWebsiteBlocking(event, packageName);
        }
    }

    private void handleShortsBlocking(@NonNull AccessibilityEvent event, String activeAppPackage) {

    }

    // Note: If this doesn't work than recursively find text field in the node's children
    // But it will cost performance
    private void handleWebsiteBlocking(@NonNull AccessibilityEvent event, String activeAppPackage) {
        if (event.getEventType() == AccessibilityEvent.TYPE_WINDOW_CONTENT_CHANGED) {
            AccessibilityNodeInfo node = event.getSource();

            // Return if node or classname is null or the node component is not text field
            if (node == null || node.getClassName() == null || node.getText() == null || (!node.getClassName().equals("android.widget.EditText") && !node.getClassName().equals("android.widget.ListView")))
                return;

            // Retrieve input text from input field
            String inputText = node.getText().toString().trim().toLowerCase();

            // If text contains space and does not contain dot then return because it is not a URL
            if (inputText.contains(" ") || !inputText.contains(".")) return;

            // Parse host name
            String host = Utils.parseHostNameFromUrl(inputText).trim();

            // Return if host does not match with blocked sites
            if (!mBlockedWebsites.contains(host) && mNsfwWebsites.get(host) == null) return;

            Log.d(TAG, "Blocked website opened site : " + host + "  in browser: " + activeAppPackage);
            performGlobalAction(GLOBAL_ACTION_BACK);
            mainThreadDebouncer.call(new Runnable() {
                @Override
                public void run() {
                    Toast.makeText(MindfulAccessibilityService.this, "Website blocked!, going back", Toast.LENGTH_SHORT).show();
                }
            });
        }
    }


    private void refreshServiceInfo() {
        // Fetch installed apps which can handle url or are browsers
        Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse("http://www.google.com"));
        PackageManager pm = getPackageManager();
        List<ResolveInfo> browsers = pm.queryIntentActivities(intent, PackageManager.MATCH_ALL);

        HashSet<String> selectedPackages = new HashSet<>();

        for (ResolveInfo browser : browsers) {
            selectedPackages.add(browser.activityInfo.packageName);
        }

        AccessibilityServiceInfo info = new AccessibilityServiceInfo();
        info.eventTypes = AccessibilityEvent.TYPE_WINDOW_CONTENT_CHANGED;
        info.feedbackType = AccessibilityServiceInfo.FEEDBACK_ALL_MASK;
        info.flags = AccessibilityServiceInfo.DEFAULT | AccessibilityServiceInfo.FLAG_INCLUDE_NOT_IMPORTANT_VIEWS | AccessibilityServiceInfo.FLAG_REPORT_VIEW_IDS | AccessibilityServiceInfo.FLAG_RETRIEVE_INTERACTIVE_WINDOWS;
        info.notificationTimeout = 500;

        info.packageNames = selectedPackages.toArray(new String[0]);

        setServiceInfo(info);
        Log.d(TAG, "refreshServiceInfo: Accessibility service updated successfully");
    }


    @Override
    public void onSharedPreferenceChanged(SharedPreferences prefs, @Nullable String changedKey) {
        if (changedKey == null || changedKey.isEmpty()) return;
        Log.d(TAG, "OnSharedPrefsChanged: Key changed = " + changedKey);

        switch (changedKey) {
            case AppConstants.PREF_KEY_IS_DISTRACTION_BLOCKER_ON:
                boolean isBlockerOn = prefs.getBoolean(AppConstants.PREF_KEY_IS_DISTRACTION_BLOCKER_ON, true);
                if (!isBlockerOn) disableAccessibilityService();
                break;

            case AppConstants.PREF_KEY_SHOULD_BLOCK_NSFW:
                mShouldBlockNSFW = prefs.getBoolean(AppConstants.PREF_KEY_SHOULD_BLOCK_NSFW, false);
                mNsfwWebsites = mShouldBlockNSFW ? NsfwDomains.init() : new HashMap<>(0);
                break;

            case AppConstants.PREF_KEY_SHOULD_BLOCK_SHORTS:
                mShouldBlockShorts = prefs.getBoolean(AppConstants.PREF_KEY_SHOULD_BLOCK_NSFW, false);
                refreshServiceInfo();
                break;

            case AppConstants.PREF_KEY_BLOCKED_WEBSITES:
                mBlockedWebsites = Utils.jsonStrToStringHashSet(prefs.getString(AppConstants.PREF_KEY_BLOCKED_WEBSITES, ""));
                break;

            default:
                break;
        }


        Log.d(TAG, "onSharedPreferenceChanged: BlockedWebsites => " + mBlockedWebsites.toString());
    }

    private void disableAccessibilityService() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            disableSelf();
        } else {
            startActivity(new Intent(Settings.ACTION_ACCESSIBILITY_SETTINGS));
            Toast.makeText(this, "Please disable Mindful accessibility service", Toast.LENGTH_LONG).show();
        }
    }

    @Override
    public void onInterrupt() {
    }

    @Override
    public void onDestroy() {
        super.onDestroy();

        // Unregister receivers
        mSharedPrefs.unregisterOnSharedPreferenceChangeListener(this);
        unregisterReceiver(mAppInstallUninstallReceiver);
        Log.d(TAG, "onDestroy: Accessibility service destroyed");
    }

    private class AppInstallUninstallReceiver extends BroadcastReceiver {
        @Override
        public void onReceive(Context context, Intent intent) {
            if (intent == null || intent.getAction() == null) return;
            String action = intent.getAction();

            if (Intent.ACTION_PACKAGE_ADDED.equals(action) || Intent.ACTION_PACKAGE_REMOVED.equals(action)) {
                Log.d(TAG, "onReceive: App install/uninstall event received with action : " + action);
                refreshServiceInfo();
            }
        }
    }
}
