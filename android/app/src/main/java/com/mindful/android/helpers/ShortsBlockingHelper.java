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

package com.mindful.android.helpers;

import android.view.accessibility.AccessibilityNodeInfo;

import androidx.annotation.NonNull;

import com.mindful.android.models.WellBeingSettings;

import org.jetbrains.annotations.Contract;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Helper class to handle blocking of short-form content platforms
 * and detect when such content is open based on accessibility node information.
 */
public class ShortsBlockingHelper {

    // App package names
    public static final String INSTAGRAM_PACKAGE = "com.instagram.android";
    public static final String YOUTUBE_PACKAGE = "com.google.android.youtube";
    public static final String YOUTUBE_CLIENT_PACKAGE_PREFIX = ".android.youtube";
    public static final String SNAPCHAT_PACKAGE = "com.snapchat.android";
    public static final String FACEBOOK_PACKAGE = "com.facebook.katana";
    public static final String REDDIT_PACKAGE = "com.reddit.frontpage";

    // Possible URLs of different short-form content platforms
    private static final List<String> instaReelUrls = new ArrayList<>(Arrays.asList("instagram.com/reels/", "m.instagram.com/reels/"));
    private static final List<String> ytShortUrls = new ArrayList<>(Arrays.asList("youtube.com/shorts/", "m.youtube.com/shorts/"));
    private static final List<String> snapSpotlightUrls = new ArrayList<>(Arrays.asList("snapchat.com/spotlight/", "m.snapchat.com/spotlight/", "web.snapchat.com/spotlight/"));
    private static final List<String> fbReelUrls = new ArrayList<>(Arrays.asList("facebook.com/reel/", "m.facebook.com/reel/"));

    /**
     * Checks if Instagram Reels is currently open based on accessibility node information.
     *
     * @param parentNode The root AccessibilityNodeInfo of the view hierarchy.
     * @return True if Instagram Reels is open, false otherwise.
     */
    public static boolean isInstaReelsOpen(@NonNull AccessibilityNodeInfo parentNode) {
        CharSequence parentNodeId = parentNode.getViewIdResourceName();

        // Check root node
        if (parentNodeId != null && (parentNodeId.equals("com.instagram.android:id/clips_viewer_view_pager") || parentNodeId.equals("com.instagram.android:id/scrubber"))) {
            return true;
        }

        // Check child nodes
        for (int i = 0; i < parentNode.getChildCount(); i++) {
            AccessibilityNodeInfo childNode = parentNode.getChild(i);
            if (childNode == null) continue;

            CharSequence childNodeId = childNode.getViewIdResourceName();

            if (childNodeId != null && childNodeId.equals("com.instagram.android:id/reels_touchable_background")) {
                return true;
            }
        }

        return false;
    }

    /**
     * Checks if YouTube Shorts is currently open based on accessibility node information.
     *
     * @param node              The AccessibilityNodeInfo of the view.
     * @param clientPackageName The package name of the youtube client which is open.
     * @return True if YouTube Shorts is open, false otherwise.
     */
    public static boolean isYoutubeShortsOpen(@NonNull AccessibilityNodeInfo node, @NonNull String clientPackageName) {
        CharSequence nodeId = node.getViewIdResourceName();
        return nodeId != null
                && (nodeId.equals(clientPackageName + ":id/reel_progress_bar")
                || nodeId.equals(clientPackageName + ":id/reel_player_page_container")
                || nodeId.equals(clientPackageName + ":id/reel_recycler"));
    }

    /**
     * Checks if Snapchat Spotlight is currently open based on accessibility node information.
     *
     * @param node The AccessibilityNodeInfo of the view.
     * @return True if Snapchat Spotlight is open, false otherwise.
     */
    public static boolean isSnapchatSpotlightOpen(@NonNull AccessibilityNodeInfo node) {
        // Find by 'spotlight_view_count' id
        List<AccessibilityNodeInfo> nodes = node.findAccessibilityNodeInfosByViewId("com.snapchat.android:id/spotlight_view_count");
        if (nodes != null && !nodes.isEmpty()) {
            CharSequence text = nodes.get(0).getText();
            return text != null;
        }

        return false;
    }

    /**
     * Checks if Facebook Reels is currently open based on accessibility node information.
     *
     * @param node The AccessibilityNodeInfo of the view.
     * @return True if Facebook Reels is open, false otherwise.
     */
    public static boolean isFacebookReelsOpen(@NonNull AccessibilityNodeInfo node) {
        CharSequence txt = node.getText();
        // TODO: Add more string translated from different languages for the node text
        //  as user may have set different language for facebook app
        return txt != null && (txt.equals("Add a comment…") || txt.equals("कमेंट जोड़ें…"));
    }

    /**
     * Checks if Reddit Shorts is currently open based on accessibility node information.
     *
     * @param node The AccessibilityNodeInfo of the view.
     * @return True if Reddit Shorts is open, false otherwise.
     */
    public static boolean isRedditShortsOpen(@NonNull AccessibilityNodeInfo node) {
        CharSequence nodeId = node.getViewIdResourceName();
        return nodeId != null && nodeId.equals("feed_vertical_pager");
    }

    /**
     * Checks if a short-form content website is open in the browser based on WellBeingSettings.
     *
     * @param settings The WellBeingSettings model indicating which platforms are blocked.
     * @param url      The URL text from the browser.
     * @return True if a blocked short-form content website is open, false otherwise.
     */
    public static boolean isShortContentOpenOnBrowser(@NonNull WellBeingSettings settings, String url) {
        return (settings.blockInstaReels && doesUrlContainsAnyElement(instaReelUrls, url))
                || (settings.blockYtShorts && doesUrlContainsAnyElement(ytShortUrls, url))
                || (settings.blockSnapSpotlight && doesUrlContainsAnyElement(snapSpotlightUrls, url))
                || (settings.blockFbReels && doesUrlContainsAnyElement(fbReelUrls, url));
    }

    /**
     * Checks if the URL contains any of the elements from the provided list of URLs.
     *
     * @param urlList The list of URL substrings to check against.
     * @param url     The URL to check.
     * @return True if the URL contains any element from the list, false otherwise.
     */
    @Contract(pure = true)
    private static boolean doesUrlContainsAnyElement(@NonNull List<String> urlList, String url) {
        for (String element : urlList) {
            if (url.contains(element)) return true;
        }
        return false;
    }
}
