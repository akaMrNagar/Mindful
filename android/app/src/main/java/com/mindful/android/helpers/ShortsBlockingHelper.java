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
    public static final String SNAPCHAT_PACKAGE = "com.snapchat.android";
    public static final String FACEBOOK_PACKAGE = "com.facebook.katana";

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
     * @param node The AccessibilityNodeInfo of the view.
     * @return True if YouTube Shorts is open, false otherwise.
     */
    public static boolean isYoutubeShortsOpen(@NonNull AccessibilityNodeInfo node) {
        CharSequence nodeId = node.getViewIdResourceName();
        return nodeId != null
                && (nodeId.equals("com.google.android.youtube:id/reel_progress_bar")
                || nodeId.equals("com.google.android.youtube:id/reel_player_page_container")
                || nodeId.equals("com.google.android.youtube:id/reel_recycler"));
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
            if (text != null) return true;
        }

        // Find by node's classname equal to 'opera_content_index'
        String id = node.getViewIdResourceName();
        return id != null && id.equals("com.snapchat.android:id/opera_content_index");
    }

    /**
     * Checks if Facebook Reels is currently open based on accessibility node information.
     *
     * @param node The AccessibilityNodeInfo of the view.
     * @return True if Facebook Reels is open, false otherwise.
     */
    public static boolean isFacebookReelsOpen(@NonNull AccessibilityNodeInfo node) {
        CharSequence txt = node.getText();
        return txt != null && (txt.equals("Add a comment…") || txt.equals("कमेंट जोड़ें…"));
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
