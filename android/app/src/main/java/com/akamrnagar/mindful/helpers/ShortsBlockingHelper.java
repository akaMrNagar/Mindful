package com.akamrnagar.mindful.helpers;

import android.view.accessibility.AccessibilityNodeInfo;

public class ShortsBlockingHelper {

    // ========================================================================================================================================
    // =================================== ACCESSIBILITY SERVICE CONSTANTS ====================================================================
    // ========================================================================================================================================

    // APP PACKAGES
    public static final String INSTAGRAM_PACKAGE = "com.instagram.android";
    public static final String YOUTUBE_PACKAGE = "com.google.android.youtube";
    public static final String SNAPCHAT_PACKAGE = "com.snapchat.android";
    public static final String FACEBOOK_PACKAGE = "com.facebook.katana";

    // APP SHORTS CONTENT SECTION IDS
    public static final String INSTAGRAM_SECTION_ID = INSTAGRAM_PACKAGE + ":id/clips_viewer_view_pager";
    public static final String YOUTUBE_SECTION_ID = YOUTUBE_PACKAGE + ":id/reel_recycler";
    public static final String SNAPCHAT_SECTION_ID = SNAPCHAT_PACKAGE + ":id/opera_content_index";
    public static final String FACEBOOK_SECTION_ID = FACEBOOK_PACKAGE + ":id/clips_viewer_view_pager";


    public static void blockInstagramReels(AccessibilityNodeInfo node){}
    public static void blockSnapchatSpotlight(AccessibilityNodeInfo node){}
    public static void blockYoutubeShorts(AccessibilityNodeInfo node){}
    public static void blockFacebookReels(AccessibilityNodeInfo node){}


    private void snap() {
        //com.snapchat.android:id/spotlight_card_carousel

//        ArrayList<String> ids = new ArrayList<>();
//
//        String parentId = node.getViewIdResourceName();
//        if (parentId != null) ids.add(parentId);
//
//
//        for (int i = 0; i < node.getChildCount(); i++) {
//            AccessibilityNodeInfo nthChild = node.getChild(i);
//            String childId = nthChild.getViewIdResourceName();
//            if (childId != null) ids.add(childId);
//
//
//            for (int j = 0; j < nthChild.getChildCount(); j++) {
//                String child2Id = nthChild.getChild(j).getViewIdResourceName();
//                if (child2Id != null) {
//                    ids.add(child2Id);
//                    if (child2Id.equals("com.snapchat.android:id/spotlight_view_count")) {
//                        goBackWithToast("going back");
//                    }
//                }
//            }
//        }
    }
}


// yt shorts node => "com.google.android.youtube:id/reel_player_underlay"
// "app.revanced.android.youtube:id/reel_player_underlay"
// "com.google.android.youtube:id/reel_main_title"

// Instagram reel node => "com.instagram.android:id/clips_video_container"
// "com.instagram.android:id/clips_viewer_view_pager" // manual

// Snapchat spotlight node => "com.snapchat.android:id/spotlight_view_count"
// "com.snapchat.android:id/view_profile"
// "com.snapchat.android:id/spotlight_view_count"


// Tiktok  => "com.zhiliaoapp.musically:id/desc"