/*
 *
 *  *
 *  *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *  *
 *  *  * This source code is licensed under the GPL-2.0 license license found in the
 *  *  * LICENSE file in the root directory of this source tree.
 *  *
 *
 */

package com.mindful.android.services;

import static com.mindful.android.helpers.ShortsBlockingHelper.FACEBOOK_PACKAGE;
import static com.mindful.android.helpers.ShortsBlockingHelper.INSTAGRAM_PACKAGE;
import static com.mindful.android.helpers.ShortsBlockingHelper.REDDIT_PACKAGE;
import static com.mindful.android.helpers.ShortsBlockingHelper.SNAPCHAT_PACKAGE;
import static com.mindful.android.helpers.ShortsBlockingHelper.YOUTUBE_CLIENT_PACKAGE_PREFIX;
import static com.mindful.android.helpers.ShortsBlockingHelper.YOUTUBE_PACKAGE;
import static com.mindful.android.receivers.alarm.MidnightResetReceiver.ACTION_MIDNIGHT_SERVICE_RESET;

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
import android.os.Handler;
import android.os.Looper;
import android.provider.Browser;
import android.util.Log;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityNodeInfo;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.mindful.android.R;
import com.mindful.android.helpers.SharedPrefsHelper;
import com.mindful.android.helpers.ShortsBlockingHelper;
import com.mindful.android.models.WellBeingSettings;
import com.mindful.android.utils.NsfwDomains;
import com.mindful.android.utils.Utils;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * An AccessibilityService that monitors app usage and blocks access to specified content based on user settings.
 */
public class MindfulAccessibilityService extends AccessibilityService implements SharedPreferences.OnSharedPreferenceChangeListener {
    private static final String TAG = "Mindful.MindfulAccessibilityService";

    /**
     * The minimum interval between every Back Action [BACK PRESS] call from service
     */
    private static final long BACK_ACTION_INVOKE_INTERVAL_MS = 500L;

    /**
     * The minimum interval between saving short content's screen time in shared preferences
     */
    private static final long SHARED_PREF_INVOKE_INTERVAL_MS = 30 * 1000;

    // Max allowed duration for each short content platform (based on the highest short length or duration)
    // If the interval between two short content block event is <= DURATION then it is considered that user is watching short content
    private static final long MAX_ALLOWED_DUR_INSTA = 90 * 1000;
    private static final long MAX_ALLOWED_DUR_YT = 3 * 60 * 1000;
    private static final long MAX_ALLOWED_DUR_SNAP = 60 * 1000;
    private static final long MAX_ALLOWED_DUR_FB = 90 * 1000;
    private static final long MAX_ALLOWED_DUR_REDDIT = 60 * 1000;
    private static final long MAX_ALLOWED_DUR_BROWSER = 30 * 1000;


    /**
     * List of Ids of URL Bars used by different browsers.
     * These are used to retrieve/extract url from the browsers.
     */
    private final HashSet<String> mUrlBarNodeIds = new HashSet<>(Set.of(
            ":id/url_bar",
            ":id/mozac_browser_toolbar_url_view",
            ":id/url",
            ":id/search",
            ":id/url_field",
            ":id/location_bar_edit_text",
            ":id/addressbarEdit",
            ":id/bro_omnibar_address_title_text"
    ));

    // Fixed thread pool for parallel event processing
    private final ExecutorService mExecutorService = Executors.newFixedThreadPool(4);
    private AppInstallUninstallReceiver mAppInstallUninstallReceiver;
    private WellBeingSettings mWellBeingSettings = new WellBeingSettings();
    private Map<String, Boolean> mNsfwWebsites = new HashMap<>();
    private String mLastRedirectedUrl = "";

    private long mLastTimeShortsCheck = 0L;
    private long mLastTimeSharedPrefInvoked = 0L;
    private long mLastTimeBackActionInvoked = 0L;
    private long mTotalShortsScreenTimeMs = 0L;

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        String action = Utils.getActionFromIntent(intent);

        if (ACTION_MIDNIGHT_SERVICE_RESET.equals(action)) {
            mTotalShortsScreenTimeMs = 0;
            SharedPrefsHelper.getSetShortsScreenTimeMs(this, 0L);
            Log.d(TAG, "onStartCommand: Midnight reset completed");
        }
        return super.onStartCommand(intent, flags, startId);
    }

    @Override
    protected void onServiceConnected() {
        super.onServiceConnected();

        // Register shared prefs listener and load data
        SharedPrefsHelper.registerUnregisterListener(this, true, this);
        mWellBeingSettings = SharedPrefsHelper.getSetWellBeingSettings(this, null);
        mTotalShortsScreenTimeMs = SharedPrefsHelper.getSetShortsScreenTimeMs(this, null);

        // Register listener for install and uninstall events
        if (mAppInstallUninstallReceiver == null) {
            mAppInstallUninstallReceiver = new AppInstallUninstallReceiver();
            IntentFilter filter = new IntentFilter();
            filter.addAction(Intent.ACTION_PACKAGE_ADDED);
            filter.addAction(Intent.ACTION_PACKAGE_REMOVED);
            filter.addDataScheme("package");
            registerReceiver(mAppInstallUninstallReceiver, filter);
        }

        refreshServiceInfo();
        Log.d(TAG, "onCreate: Accessibility service started successfully");
    }

    @Override
    public void onAccessibilityEvent(@NonNull AccessibilityEvent event) {
        // Minimal checks on the main thread
        if (!shouldBlockContent() || event.getEventType() != AccessibilityEvent.TYPE_WINDOW_CONTENT_CHANGED || event.getPackageName() == null) {
            return;
        }

        // Capture event data for background processing
        String packageName = event.getPackageName().toString();
        AccessibilityNodeInfo node = event.getSource();

        // Return early if node data is insufficient
        if (node == null || node.getClassName() == null) return;

        // Offload the main processing to a background thread
        try {
            if (mExecutorService.isShutdown()) return;
            mExecutorService.submit(() -> processEventInBackground(packageName, node));
        } catch (Exception ignored) {
        }
    }

    /**
     * Processes accessibility event in background thread instead of main thread.
     *
     * @param packageName The package name of the app generating the event.
     * @param node        The accessibility node representing the UI element currently in focus.
     */
    private void processEventInBackground(@NonNull String packageName, AccessibilityNodeInfo node) {
        try {
            // Copy settings for this thread
            WellBeingSettings settings = mWellBeingSettings.makeCopy();

            switch (packageName) {
                case INSTAGRAM_PACKAGE:
                    if (settings.blockInstaReels && ShortsBlockingHelper.isInstaReelsOpen(node)) {
                        checkTimerAndBlockShortContent(MAX_ALLOWED_DUR_INSTA);
                    }
                    break;
                case SNAPCHAT_PACKAGE:
                    if (settings.blockSnapSpotlight && ShortsBlockingHelper.isSnapchatSpotlightOpen(node)) {
                        checkTimerAndBlockShortContent(MAX_ALLOWED_DUR_SNAP);
                    }
                    break;
                case FACEBOOK_PACKAGE:
                    if (settings.blockFbReels && ShortsBlockingHelper.isFacebookReelsOpen(node)) {
                        checkTimerAndBlockShortContent(MAX_ALLOWED_DUR_FB);
                    }
                    break;
                case REDDIT_PACKAGE:
                    if (settings.blockRedditShorts && ShortsBlockingHelper.isRedditShortsOpen(node)) {
                        checkTimerAndBlockShortContent(MAX_ALLOWED_DUR_REDDIT);
                    }
                    break;
                default:
                    if (settings.blockYtShorts && packageName.contains(YOUTUBE_CLIENT_PACKAGE_PREFIX)) {
                        if (ShortsBlockingHelper.isYoutubeShortsOpen(node, packageName)) {
                            checkTimerAndBlockShortContent(MAX_ALLOWED_DUR_YT);
                        }
                    } else {
                        blockDistractionOnBrowsers(node, packageName);
                    }
                    break;
            }
        } catch (Exception ignored) {
        }
    }


    /**
     * Determines whether content should be blocked based on the current settings.
     *
     * @return {@code true} if content should be blocked based on the current settings,
     * {@code false} otherwise.
     */
    private boolean shouldBlockContent() {
        return !mWellBeingSettings.blockedWebsites.isEmpty() ||
                mWellBeingSettings.blockInstaReels ||
                mWellBeingSettings.blockYtShorts ||
                mWellBeingSettings.blockSnapSpotlight ||
                mWellBeingSettings.blockFbReels ||
                mWellBeingSettings.blockNsfwSites;
    }

    /**
     * Blocks access to websites and short-form content based on current settings.
     *
     * @param node        The AccessibilityNodeInfo of the current view.
     * @param packageName The package name of the app.
     */
    private void blockDistractionOnBrowsers(@NonNull AccessibilityNodeInfo node, String packageName) {
        String url = extractBrowserUrl(node, packageName);

        // Return if url is empty or does not contain dot or have space this basically means its not url
        if (url.contains(" ") || !url.contains(".")) return;

        // Clean google AMP from the url if found (some site can appear in the AMP container with google's amp domain)
        url = url.replace("google.com/amp/s/amp.", "");

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
            checkTimerAndBlockShortContent(MAX_ALLOWED_DUR_BROWSER);
            return;
        }

        // Activate safe search if NSFW is blocked
        if (mWellBeingSettings.blockNsfwSites) {
            applySafeSearch(packageName, url, host);
        }
    }

    /**
     * Extracts the URL from the given AccessibilityNodeInfo based on the app package name.
     *
     * @param node        The AccessibilityNodeInfo of the current view.
     * @param packageName The package name of the app.
     * @return The extracted URL as a string.
     */
    @NonNull
    private String extractBrowserUrl(@NonNull AccessibilityNodeInfo node, String packageName) {
        try {
            for (String id : mUrlBarNodeIds) {
                List<AccessibilityNodeInfo> urlBarNodes = node.findAccessibilityNodeInfosByViewId(packageName + id);
                if (!urlBarNodes.isEmpty()) {
                    CharSequence txtSequence = urlBarNodes.get(0).getText();
                    if (txtSequence != null && txtSequence.length() > 1) {
                        return txtSequence.toString();
                    }
                }
            }

            // Find by input field class
            if (node.getClassName().equals("android.widget.EditText")) {
                CharSequence txtSequence = node.getText();
                if (txtSequence != null && txtSequence.length() > 1) {
                    return txtSequence.toString();
                }
            }
        } catch (Exception ignored) {
        }

        return "";
    }

    /**
     * Redirects the user to safe search results by using different techniques on different search engines.
     * Supported search engines are GOOGLE, BRAVE, BING, DUCKDUCKGO
     *
     * @param browserPackage The package name of the browser app.
     * @param url            The url from the browser's search bar.
     * @param hostDomain     The resolved host name for the provided url.
     */
    private void applySafeSearch(String browserPackage, @NonNull String url, String hostDomain) {
        // For bing, google use &safe=active flag
        // For brave, duckduckgo switch domain to safe.[SEARCH_ENGINE_DOMAIN]

        // For GOOGLE and BING search engines
        if (!url.contains("safe=active") && (url.contains("google.com/search?") || url.contains("bing.com/search?"))) {
            String safeUrl = url.replace("/search?", "/search?safe=active&");
            redirectUserToUrl(safeUrl, browserPackage);
        }
        // For DUCKDUCKGO and BRAVE search engines
        else if (!hostDomain.contains("safe.") && (url.contains("search.brave.com/search?") || url.contains("duckduckgo.com/?"))) {
            String safeUrl =
                    hostDomain.contains("search.brave.com") ?
                            url.replace("search.brave.com", "safe.search.brave.com") :
                            url.replace("duckduckgo.com", "safe.duckduckgo.com");

            redirectUserToUrl(safeUrl, browserPackage);
        }
    }

    /**
     * Redirects the user to the new url in the specified browser.
     *
     * @param url            The url to which user will be redirected.
     * @param browserPackage The package name of the browser app.
     */
    private void redirectUserToUrl(String url, String browserPackage) {
        // Return if received request for the same URL as previous
        if (mLastRedirectedUrl.equals(url)) return;
        mLastRedirectedUrl = url;

        // Post to the main thread
        new Handler(Looper.getMainLooper()).post(() -> {
            Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse(Utils.validateHttpsProtocol(url)));
            intent.putExtra(Browser.EXTRA_APPLICATION_ID, browserPackage);
            intent.setPackage(browserPackage);
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);

            if (intent.resolveActivity(getPackageManager()) != null) {
                Toast.makeText(MindfulAccessibilityService.this, getString(R.string.toast_redirecting), Toast.LENGTH_SHORT).show();
                startActivity(intent);
                Log.d(TAG, "Redirecting user to safe search results in " + browserPackage + " for url: " + url);

                // Clean redirection url after approximate loading time
                new Handler().postDelayed(() -> mLastRedirectedUrl = "", 500L);
            } else {
                Log.e(TAG, "No application found to handle the Intent for URL: " + url);
            }
        });
    }

    /**
     * Checks the total screen time for short-form content and blocks access if the allowed time has been exceeded.
     */
    private void checkTimerAndBlockShortContent(long maxAllowedDuration) {
        if (mWellBeingSettings.allowedShortContentTimeMs < 0 || mTotalShortsScreenTimeMs > (mWellBeingSettings.allowedShortContentTimeMs + SHARED_PREF_INVOKE_INTERVAL_MS)) {
            goBackWithToast();
            return;
        }

        // Calculate screen time since last check
        long currentTime = System.currentTimeMillis();
        long elapsedTime = mLastTimeShortsCheck != 0 ? currentTime - mLastTimeShortsCheck : 0;


        // Update only if elapsedTime is less than MAX_ALLOWED_DURATION otherwise user may have closed short content,
        mTotalShortsScreenTimeMs += (elapsedTime <= maxAllowedDuration ? elapsedTime : 0);
        mLastTimeShortsCheck = currentTime;

        // Check if the minimum interval has passed before calling shared preferences
        if ((currentTime - mLastTimeSharedPrefInvoked) > SHARED_PREF_INVOKE_INTERVAL_MS) {
            SharedPrefsHelper.getSetShortsScreenTimeMs(this, mTotalShortsScreenTimeMs);
            mLastTimeSharedPrefInvoked = currentTime;
            Log.d(TAG, "checkTimerAndBlockShortContent: shorts time saved: " + (mTotalShortsScreenTimeMs / 1000L) + " seconds");
        }
    }

    /**
     * Performs the back action and shows a toast message indicating that the content is blocked.
     */
    private void goBackWithToast() {
        long currentTime = System.currentTimeMillis();
        if (currentTime - mLastTimeBackActionInvoked >= BACK_ACTION_INVOKE_INTERVAL_MS) {
            mLastTimeBackActionInvoked = currentTime;

            new Handler(Looper.getMainLooper()).post(() -> {
                // Perform the back action (can be done on background thread)
                performGlobalAction(GLOBAL_ACTION_BACK);

                // Post Toast to main thread
                Toast.makeText(MindfulAccessibilityService.this, getString(R.string.toast_blocked_content), Toast.LENGTH_LONG).show();
            });
        }
    }

    /**
     * Updates the service info with the latest settings and registered packages.
     */
    private void refreshServiceInfo() {
        // Using hashset to avoid duplicates
        HashSet<String> allowedAppPackages = new HashSet<>();
        PackageManager pm = getPackageManager();

        // Fetch installed browser packages
        Intent browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse("http://www.google.com"));
        List<ResolveInfo> browsers = pm.queryIntentActivities(browserIntent, PackageManager.MATCH_ALL);

        for (ResolveInfo browser : browsers) {
            allowedAppPackages.add(browser.activityInfo.packageName);
            Log.d(TAG, "refreshServiceInfo: Browsers found: " + browser.activityInfo.packageName);
        }

        // For short form content blocking on their native apps
        if (mWellBeingSettings.blockInstaReels) allowedAppPackages.add(INSTAGRAM_PACKAGE);
        if (mWellBeingSettings.blockSnapSpotlight) allowedAppPackages.add(SNAPCHAT_PACKAGE);
        if (mWellBeingSettings.blockFbReels) allowedAppPackages.add(FACEBOOK_PACKAGE);
        if (mWellBeingSettings.blockRedditShorts) allowedAppPackages.add(REDDIT_PACKAGE);

        if (mWellBeingSettings.blockYtShorts) {
            // Fetch all the clients available for youtube. It can also include browsers too.
            Intent ytIntent = new Intent(Intent.ACTION_VIEW, Uri.parse("https://www.youtube.com"));
            List<ResolveInfo> ytClients = pm.queryIntentActivities(ytIntent, PackageManager.MATCH_ALL);

            for (ResolveInfo client : ytClients) {
                allowedAppPackages.add(client.activityInfo.packageName);
                Log.d(TAG, "refreshServiceInfo: Youtube clients found: " + client.activityInfo.packageName);
            }

            // Regardless of the results add original youtube package.
            allowedAppPackages.add(YOUTUBE_PACKAGE);
        }

        // Load nsfw website domains if needed
        mNsfwWebsites = mWellBeingSettings.blockNsfwSites ? NsfwDomains.init() : new HashMap<>(0);

        AccessibilityServiceInfo info = new AccessibilityServiceInfo();
        info.eventTypes = AccessibilityEvent.TYPE_WINDOW_CONTENT_CHANGED;
        info.feedbackType = AccessibilityServiceInfo.FEEDBACK_ALL_MASK;
        info.flags = AccessibilityServiceInfo.DEFAULT |
                AccessibilityServiceInfo.FLAG_INCLUDE_NOT_IMPORTANT_VIEWS |
                AccessibilityServiceInfo.FLAG_REPORT_VIEW_IDS |
                AccessibilityServiceInfo.FLAG_RETRIEVE_INTERACTIVE_WINDOWS;
        info.notificationTimeout = 500;
        info.packageNames = allowedAppPackages.toArray(new String[0]);
        setServiceInfo(info);

        Log.d(TAG, "refreshServiceInfo: Accessibility service updated successfully");
    }

    @Override
    public void onSharedPreferenceChanged(SharedPreferences prefs, @Nullable String changedKey) {
        if (changedKey != null && changedKey.equals(SharedPrefsHelper.PREF_KEY_WELLBEING_SETTINGS)) {
            Log.d(TAG, "OnSharedPrefsChanged: Key changed = " + changedKey);
            mWellBeingSettings = SharedPrefsHelper.getSetWellBeingSettings(this, null);
            refreshServiceInfo();
        }
    }

    @Override
    public void onInterrupt() {
        mExecutorService.shutdown();
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        mExecutorService.shutdown();
        // Unregister prefs listener and receiver
        if (mAppInstallUninstallReceiver != null) {
            unregisterReceiver(mAppInstallUninstallReceiver);
            mAppInstallUninstallReceiver = null;
        }
        SharedPrefsHelper.registerUnregisterListener(this, false, this);
        Log.d(TAG, "onDestroy: Accessibility service destroyed");
    }

    /**
     * BroadcastReceiver to listen for app install/uninstall events and update service info accordingly.
     */
    private class AppInstallUninstallReceiver extends BroadcastReceiver {
        @Override
        public void onReceive(Context context, Intent intent) {
            if (intent == null || intent.getAction() == null) return;
            String action = intent.getAction();

            if (Intent.ACTION_PACKAGE_ADDED.equals(action) || Intent.ACTION_PACKAGE_REMOVED.equals(action)) {
                Log.d(TAG, "onReceive: App install/uninstall event received with action : " + action + " for package: " + getPackageName(intent));
                mExecutorService.submit(MindfulAccessibilityService.this::refreshServiceInfo);
            }
        }

        @NonNull
        private String getPackageName(@NonNull Intent intent) {
            Uri uri = intent.getData();
            return uri != null ? uri.getSchemeSpecificPart() : "NULL";
        }
    }


    /**
     * Recursively logs information about the accessibility node and its children.
     * This method traverses the accessibility node tree starting from the given parent node,
     * logging the class name, view ID, and text content of each node.
     *
     * <p>Note: This method does not provide any functional capabilities but is helpful
     * for debugging and testing purposes.</p>
     *
     * @param parentNode The root node from which to start logging. This should be the
     *                   top-level accessibility node to explore its hierarchy.
     */
    private void logNodeInfoRecursively(AccessibilityNodeInfo parentNode, int level) {
        logNode(parentNode, level);
        level++;

        for (int i = 0; i < parentNode.getChildCount(); i++) {
            AccessibilityNodeInfo childNode = parentNode.getChild(i);
            logNode(childNode, level);
            if (childNode == null) continue;
            logNodeInfoRecursively(childNode, level);
        }
    }

    /**
     * Logs information about a specific accessibility node.
     * This method outputs the class name, view ID, and text content of the given node
     * at the specified hierarchical level.
     *
     * <p>Note: This method does not provide any functional capabilities but is helpful
     * for debugging and testing purposes.</p>
     *
     * @param node  The accessibility node to log. This can be any node in the hierarchy.
     * @param level The hierarchical level of the node in the tree, where 0 represents
     *              the root node and higher values indicate deeper levels in the hierarchy.
     */
    private void logNode(AccessibilityNodeInfo node, int level) {
        if (node != null) {
            Log.d(TAG, "Level: " + level +
                    " Class: " + node.getClassName() +
                    " Id: " + node.getViewIdResourceName() +
                    " Text: " + node.getText());
        }
    }
}
