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

import com.akamrnagar.mindful.helpers.SharedPrefsHelper;
import com.akamrnagar.mindful.helpers.ShortsBlockingHelper;
import com.akamrnagar.mindful.models.WellBeingSettings;
import com.akamrnagar.mindful.utils.NsfwDomains;
import com.akamrnagar.mindful.utils.Utils;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

public class MindfulAccessibilityService extends AccessibilityService implements SharedPreferences.OnSharedPreferenceChangeListener {
    // ===================================================================================================================
    // Tested blocking on following browsers => Chrome, Brave, DuckDuckGo, Edge, Vivaldi, FireFox, WaterFox
    // ===================================================================================================================

    private static final String TAG = "Mindful.MindfulAccessibilityService";
    private WellBeingSettings mWellBeingSettings = new WellBeingSettings();
    private Map<String, Boolean> mNsfwWebsites = new HashMap<>();

    //    private SharedPreferences mSharedPrefs;
    private AppInstallUninstallReceiver mAppInstallUninstallReceiver;

    // FIXME: What if device reboots ?
    @Override
    public void onCreate() {
        super.onCreate();
        // Register shared prefs listener
        SharedPrefsHelper.registerListener(this);
        mWellBeingSettings = SharedPrefsHelper.fetchWellBeingSettings(this);

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
        // Return if no need for blocking
        if (mWellBeingSettings.blockedWebsites.isEmpty()
                && !mWellBeingSettings.blockInstaReels
                && !mWellBeingSettings.blockYtShorts
                && !mWellBeingSettings.blockSnapSpotlight
                && !mWellBeingSettings.blockFbReels
                && !mWellBeingSettings.blockNsfwSites
        ) return;


        if (event.getEventType() != AccessibilityEvent.TYPE_WINDOW_CONTENT_CHANGED || event.getPackageName() == null)
            return;
        String packageName = event.getPackageName().toString();
        AccessibilityNodeInfo node = event.getSource();

        // Return if not enough information about node
        if (node == null || node.getClassName() == null) return;

        switch (packageName) {
            case INSTAGRAM_PACKAGE:
                if (mWellBeingSettings.blockInstaReels && ShortsBlockingHelper.isInstaReelsOpen(node)) {
                    goBackWithToast();
                }
                break;
            case YOUTUBE_PACKAGE:
                if (mWellBeingSettings.blockYtShorts && ShortsBlockingHelper.isYoutubeShortsOpen(node)) {
                    goBackWithToast();
                }
                break;
            case SNAPCHAT_PACKAGE:
                if (mWellBeingSettings.blockSnapSpotlight && ShortsBlockingHelper.isSnapchatSpotlightOpen(node)) {
                    goBackWithToast();
                }
                break;
            case FACEBOOK_PACKAGE:
                if (mWellBeingSettings.blockFbReels && ShortsBlockingHelper.isFacebookReelsOpen(node)) {
                    goBackWithToast();
                }
                break;
            default:
                blockDistractionOnBrowsers(node, packageName);
                break;
        }
    }


    private void blockDistractionOnBrowsers(@NonNull AccessibilityNodeInfo node, String packageName) {
        String url = extractBrowserUrl(node, packageName);

        // Return if url is empty or does not contain dot or have space this basically means its not url
        if (url.contains(" ") || !url.contains(".")) return;

        // Block websites
        String host = Utils.parseHostNameFromUrl(url);
        if (mWellBeingSettings.blockedWebsites.contains(host) || mNsfwWebsites.get(host) != null) {
            Log.d(TAG, "blockDistractionOnBrowsers: Blocked website " + host + " opened in " + packageName);
            goBackWithToast();
            return;
        }

        // Block short form content
        if (ShortsBlockingHelper.isShortContentOpenOnBrowser(mWellBeingSettings, url)) {
            Log.d(TAG, "blockDistractionOnBrowsers: Blocked short content " + url + " opened in " + packageName);
            goBackWithToast();
        }

    }

    @NonNull
    private String extractBrowserUrl(@NonNull AccessibilityNodeInfo node, String packageName) {

        // Find by id 'url_bar' on chromium based browsers
        List<AccessibilityNodeInfo> chromiumUrlNodes = node.findAccessibilityNodeInfosByViewId(packageName + ":id/url_bar");
        if (chromiumUrlNodes != null && !chromiumUrlNodes.isEmpty()) {
            CharSequence txtSequence = chromiumUrlNodes.get(0).getText();
            if (txtSequence != null) {
                return txtSequence.toString();
            }
        }

        // Find by id 'mozac_browser_toolbar_url_view' on non chromium browsers
        List<AccessibilityNodeInfo> nonChromiumUrlNodes = node.findAccessibilityNodeInfosByViewId(packageName + ":id/mozac_browser_toolbar_url_view");
        if (nonChromiumUrlNodes != null && !nonChromiumUrlNodes.isEmpty()) {
            CharSequence txtSequence = nonChromiumUrlNodes.get(0).getText();
            if (txtSequence != null) {
                return txtSequence.toString();
            }
        }

        // Find by input field class
        if (node.getClassName().equals("android.widget.EditText")) {
            CharSequence txtSequence = node.getText();
            if (txtSequence != null) {
                return txtSequence.toString();
            }
        }


        return "";
    }

    private void goBackWithToast() {
        performGlobalAction(GLOBAL_ACTION_BACK);
        Toast.makeText(MindfulAccessibilityService.this, "Content blocked!, going back", Toast.LENGTH_SHORT).show();
    }

    private void refreshServiceInfo() {
        HashSet<String> allowedAppPackages = new HashSet<>();

        // Fetch installed browser packages
        Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse("http://www.google.com"));
        PackageManager pm = getPackageManager();
        List<ResolveInfo> browsers = pm.queryIntentActivities(intent, PackageManager.MATCH_ALL);

        for (ResolveInfo browser : browsers) {
            allowedAppPackages.add(browser.activityInfo.packageName);
        }

        // For short form content blocking on their native apps
        if (mWellBeingSettings.blockInstaReels) allowedAppPackages.add(INSTAGRAM_PACKAGE);
        if (mWellBeingSettings.blockYtShorts) allowedAppPackages.add(YOUTUBE_PACKAGE);
        if (mWellBeingSettings.blockSnapSpotlight) allowedAppPackages.add(SNAPCHAT_PACKAGE);
        if (mWellBeingSettings.blockFbReels) allowedAppPackages.add(FACEBOOK_PACKAGE);

        // Load nsfw website domains if needed
        mNsfwWebsites = mWellBeingSettings.blockNsfwSites ? NsfwDomains.init() : new HashMap<>(0);


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
    public void onSharedPreferenceChanged(SharedPreferences prefs, @Nullable String changedKey) {
        if (changedKey != null && changedKey.equals(SharedPrefsHelper.PREF_KEY_WELLBEING_SETTINGS)) {
            Log.d(TAG, "OnSharedPrefsChanged: Key changed = " + changedKey);
            mWellBeingSettings = SharedPrefsHelper.fetchWellBeingSettings(this);
            refreshServiceInfo();
        }
    }

    @Override
    public void onInterrupt() {
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        // Remove prefs listener and Unregister receivers
        SharedPrefsHelper.unregisterListener(this);
        unregisterReceiver(mAppInstallUninstallReceiver);
        Log.d(TAG, "onDestroy: Accessibility service destroyed");
    }

    private class AppInstallUninstallReceiver extends BroadcastReceiver {
        @Override
        public void onReceive(Context context, Intent intent) {
            if (intent == null || intent.getAction() == null) return;
            String action = intent.getAction();

            if (Intent.ACTION_PACKAGE_ADDED.equals(action) || Intent.ACTION_PACKAGE_REMOVED.equals(action)) {
                Log.d(TAG, "onReceive: App install/uninstall event received with action : " + action
                        + " for package: " + getPackageName(intent)
                );
                refreshServiceInfo();
            }
        }


        @NonNull
        private String getPackageName(@NonNull Intent intent) {
            Uri uri = intent.getData();
            return uri != null ? uri.getSchemeSpecificPart() : "NULL";
        }
    }
}
