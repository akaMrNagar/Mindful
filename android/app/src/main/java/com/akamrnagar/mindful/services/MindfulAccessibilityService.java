package com.akamrnagar.mindful.services;

import static com.akamrnagar.mindful.helpers.ShortsBlockingHelper.FACEBOOK_PACKAGE;
import static com.akamrnagar.mindful.helpers.ShortsBlockingHelper.INSTAGRAM_PACKAGE;
import static com.akamrnagar.mindful.helpers.ShortsBlockingHelper.SNAPCHAT_PACKAGE;
import static com.akamrnagar.mindful.helpers.ShortsBlockingHelper.YOUTUBE_PACKAGE;

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
import android.util.Log;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityNodeInfo;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.akamrnagar.mindful.helpers.ShortsBlockingHelper;
import com.akamrnagar.mindful.utils.AppConstants;
import com.akamrnagar.mindful.utils.MainThreadDebouncer;
import com.akamrnagar.mindful.utils.NsfwDomains;
import com.akamrnagar.mindful.utils.Utils;

import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

public class MindfulAccessibilityService extends AccessibilityService implements SharedPreferences.OnSharedPreferenceChangeListener {
    private static final String TAG = "Mindful.MindfulAccessibilityService";
    private final MainThreadDebouncer mainThreadDebouncer = new MainThreadDebouncer(500);

    private final HashSet<String> mShortContentApps = new HashSet<>(Arrays.asList(INSTAGRAM_PACKAGE, YOUTUBE_PACKAGE, SNAPCHAT_PACKAGE, FACEBOOK_PACKAGE));
    private HashSet<String> mBrowserApps = new HashSet<>(1);

    private HashSet<String> mBlockedWebsites = new HashSet<>(2);
    private Map<String, Boolean> mNsfwWebsites = new HashMap<>();

    private boolean mShouldBlockNSFW = false;
    private boolean mShouldBlockShorts = false;

    private boolean mShouldBlockInstaReels = false;
    private boolean mShouldBlockYtShorts = false;
    private boolean mShouldBlockSnapSpotlight = false;
    private boolean mShouldBlockFbReels = false;

    private SharedPreferences mSharedPrefs;
    private AppInstallUninstallReceiver mAppInstallUninstallReceiver;


    @Override
    public void onCreate() {
        super.onCreate();

        // Get shared prefs
        mSharedPrefs = getSharedPreferences(AppConstants.PREFS_SHARED_BOX, Context.MODE_PRIVATE);

        // Initialize variables from shared prefs
        mShouldBlockNSFW = mSharedPrefs.getBoolean(AppConstants.PREF_KEY_SHOULD_BLOCK_NSFW, false);
        mShouldBlockShorts = mSharedPrefs.getBoolean(AppConstants.PREF_KEY_SHOULD_BLOCK_SHORTS, false);
        mBlockedWebsites = Utils.jsonStrToStringHashSet(mSharedPrefs.getString(AppConstants.PREF_KEY_BLOCKED_WEBSITES, ""));

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
    protected void onServiceConnected() {
        super.onServiceConnected();
        refreshServiceInfo();
    }

    @Override
    public void onAccessibilityEvent(@NonNull AccessibilityEvent event) {
        if (event.getEventType() != AccessibilityEvent.TYPE_WINDOW_CONTENT_CHANGED || event.getPackageName() == null)
            return;
        String packageName = event.getPackageName().toString();
        AccessibilityNodeInfo node = event.getSource();

        // Return if not enough information about node
        if (node == null || node.getClassName() == null) return;

        switch (packageName) {
            case INSTAGRAM_PACKAGE:
                if (mShouldBlockInstaReels) ShortsBlockingHelper.blockInstagramReels(node);
                break;
            case YOUTUBE_PACKAGE:
                if (mShouldBlockYtShorts) ShortsBlockingHelper.blockYoutubeShorts(node);
                break;
            case SNAPCHAT_PACKAGE:
                if (mShouldBlockSnapSpotlight) ShortsBlockingHelper.blockSnapchatSpotlight(node);
                break;
            case FACEBOOK_PACKAGE:
                if (mShouldBlockFbReels) ShortsBlockingHelper.blockFacebookReels(node);
                break;
            default:
                blockDistractionOnBrowsers(node, packageName);
                break;
        }
    }

    private void blockDistractionOnBrowsers(AccessibilityNodeInfo node, String appPackage) {
    }


    // Note: If this doesn't work than recursively find text field in the node's children
    // But it will cost performance
    private void handleWebsiteBlocking(@NonNull AccessibilityNodeInfo node, String activeAppPackage) {

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
        goBackWithToast("Website blocked!, going back");

    }

    private void goBackWithToast(String toastMsg) {
        performGlobalAction(GLOBAL_ACTION_BACK);
        mainThreadDebouncer.call(new Runnable() {
            @Override
            public void run() {
                Toast.makeText(MindfulAccessibilityService.this, toastMsg, Toast.LENGTH_SHORT).show();
            }
        });
    }


    @Override
    public void onSharedPreferenceChanged(SharedPreferences prefs, @Nullable String changedKey) {
        if (changedKey == null || changedKey.isEmpty()) return;
        Log.d(TAG, "OnSharedPrefsChanged: Key changed = " + changedKey);

        switch (changedKey) {
            case AppConstants.PREF_KEY_IS_DISTRACTION_BLOCKER_ON:
                boolean isBlockerOn = prefs.getBoolean(AppConstants.PREF_KEY_IS_DISTRACTION_BLOCKER_ON, true);
                if (!isBlockerOn) {
                    disableSelf();
                    return;
                }
                break;

            case AppConstants.PREF_KEY_SHOULD_BLOCK_NSFW:
                mShouldBlockNSFW = prefs.getBoolean(AppConstants.PREF_KEY_SHOULD_BLOCK_NSFW, false);
                mNsfwWebsites = mShouldBlockNSFW ? NsfwDomains.init() : new HashMap<>(0);
                break;

            case AppConstants.PREF_KEY_SHOULD_BLOCK_SHORTS:
                mShouldBlockShorts = prefs.getBoolean(AppConstants.PREF_KEY_SHOULD_BLOCK_SHORTS, false);
                break;

            case AppConstants.PREF_KEY_BLOCKED_WEBSITES:
                mBlockedWebsites = Utils.jsonStrToStringHashSet(prefs.getString(AppConstants.PREF_KEY_BLOCKED_WEBSITES, ""));
                break;

            default:
                break;
        }

        // Refresh
        refreshServiceInfo();
    }

    private void refreshServiceInfo() {
        HashSet<String> allowedAppPackages = new HashSet<>();

        // For websites blocking
        if (mShouldBlockNSFW || !mBlockedWebsites.isEmpty()) {
            // Fetch installed browsers
            Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse("http://www.google.com"));
            PackageManager pm = getPackageManager();
            List<ResolveInfo> browsers = pm.queryIntentActivities(intent, PackageManager.MATCH_ALL);

            for (ResolveInfo browser : browsers) {
                mBrowserApps.add(browser.activityInfo.packageName);
            }
            allowedAppPackages.addAll(mBrowserApps);
        }

        // For short form content blocking
        if (mShouldBlockShorts) allowedAppPackages.addAll(mShortContentApps);


        AccessibilityServiceInfo info = new AccessibilityServiceInfo();
        info.eventTypes = AccessibilityEvent.TYPE_WINDOW_CONTENT_CHANGED;
        info.feedbackType = AccessibilityServiceInfo.FEEDBACK_ALL_MASK;
        info.flags = AccessibilityServiceInfo.DEFAULT | AccessibilityServiceInfo.FLAG_INCLUDE_NOT_IMPORTANT_VIEWS | AccessibilityServiceInfo.FLAG_REPORT_VIEW_IDS | AccessibilityServiceInfo.FLAG_RETRIEVE_INTERACTIVE_WINDOWS;
        info.notificationTimeout = 500;
        info.packageNames = allowedAppPackages.toArray(new String[0]);
        setServiceInfo(info);

        Log.d(TAG, "refreshServiceInfo: Accessibility service updated successfully");
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
