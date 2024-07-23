package com.mindful.android.helpers;

import android.view.accessibility.AccessibilityNodeInfo;

import androidx.annotation.NonNull;

import com.mindful.android.models.WellBeingSettings;

import org.jetbrains.annotations.Contract;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class ShortsBlockingHelper {

    // APP PACKAGES
    public static final String INSTAGRAM_PACKAGE = "com.instagram.android";
    public static final String YOUTUBE_PACKAGE = "com.google.android.youtube";
    public static final String SNAPCHAT_PACKAGE = "com.snapchat.android";
    public static final String FACEBOOK_PACKAGE = "com.facebook.katana";

    // Possible urls of different short form content platforms
    private static final List<String> instaReelUrls = new ArrayList<>(Arrays.asList("instagram.com/reels/", "m.instagram.com/reels/"));
    private static final List<String> ytShortUrls = new ArrayList<>(Arrays.asList("youtube.com/shorts/", "m.youtube.com/shorts/"));
    private static final List<String> snapSpotlightUrls = new ArrayList<>(Arrays.asList("snapchat.com/spotlight/", "m.snapchat.com/spotlight/", "web.snapchat.com/spotlight/"));
    private static final List<String> fbReelUrls = new ArrayList<>(Arrays.asList("facebook.com/reel/", "m.facebook.com/reel/"));

    public static boolean isInstaReelsOpen(@NonNull AccessibilityNodeInfo parentNode) {
        // NOTE: For instagram lite use 'com.instagram.lite:id/video_view'
        CharSequence parentNodeId = parentNode.getViewIdResourceName();

        // Root node
        if (parentNodeId != null && (parentNodeId.equals("com.instagram.android:id/clips_viewer_view_pager") || parentNodeId.equals("com.instagram.android:id/scrubber"))) {
            return true;
        }

        // Child nodes
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

    public static boolean isYoutubeShortsOpen(@NonNull AccessibilityNodeInfo node) {
        CharSequence nodeId = node.getViewIdResourceName();
        return nodeId != null
                && (nodeId.equals("com.google.android.youtube:id/reel_progress_bar")
                || nodeId.equals("com.google.android.youtube:id/reel_player_page_container")
                || nodeId.equals("com.google.android.youtube:id/reel_recycler")
        );
    }

    public static boolean isSnapchatSpotlightOpen(@NonNull AccessibilityNodeInfo node) {
        // Find by 'spotlight_view_count' id
        List<AccessibilityNodeInfo> nodes = node.findAccessibilityNodeInfosByViewId("com.snapchat.android:id/spotlight_view_count");
        if (nodes != null && !nodes.isEmpty()) {
            CharSequence text = nodes.get(0).getText();
            if (nodes.get(0).getText() != null) return true;
        }

        // Find by node's classname equal to 'opera_content_index'
        String id = node.getViewIdResourceName();
        return id != null && id.equals("com.snapchat.android:id/opera_content_index");
    }

    public static boolean isFacebookReelsOpen(@NonNull AccessibilityNodeInfo node) {
        CharSequence txt = node.getText();
        return txt != null && (txt.equals("Add a comment…") || txt.equals("कमेंट जोड़ें…"));
    }


    /**
     * @param settings WellBeingSettings model for detecting which platforms are blocked
     * @param url      The url text from browser
     * @return Boolean indicating if any blocked short content website is opened or not on the basis of WellBeingSettings
     */
    public static boolean isShortContentOpenOnBrowser(@NonNull WellBeingSettings settings, String url) {
        return (settings.blockInstaReels && doesUrlContainsAnyElement(instaReelUrls, url))
                || (settings.blockYtShorts && doesUrlContainsAnyElement(ytShortUrls, url))
                || (settings.blockSnapSpotlight && doesUrlContainsAnyElement(snapSpotlightUrls, url))
                || (settings.blockFbReels && doesUrlContainsAnyElement(fbReelUrls, url))
                ;
    }


    /**
     * @param urlList List of urls which are iterated to check if the item is in passed Url
     * @param url     The url which may contain any element of urlList
     * @return Boolean indicating if the url contains any of the element from urlList
     */
    @Contract(pure = true)
    private static boolean doesUrlContainsAnyElement(@NonNull List<String> urlList, String url) {
        for (String element : urlList) {
            if (url.contains(element)) return true;
        }
        return false;
    }

}