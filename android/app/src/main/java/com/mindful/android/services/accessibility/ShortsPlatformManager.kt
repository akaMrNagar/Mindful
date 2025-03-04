package com.mindful.android.services.accessibility

import android.content.Context
import android.util.Log
import android.view.accessibility.AccessibilityNodeInfo
import com.mindful.android.enums.PlatformFeatures
import com.mindful.android.helpers.storage.SharedPrefsHelper
import com.mindful.android.models.WellBeingSettings
import com.mindful.android.utils.AppConstants.FACEBOOK_PACKAGE
import com.mindful.android.utils.AppConstants.INSTAGRAM_PACKAGE
import com.mindful.android.utils.AppConstants.REDDIT_PACKAGE
import com.mindful.android.utils.AppConstants.SNAPCHAT_PACKAGE
import com.mindful.android.utils.AppConstants.YOUTUBE_CLIENT_PACKAGE_SUFFIX
import com.mindful.android.utils.AppConstants.YOUTUBE_PACKAGE
import org.jetbrains.annotations.Contract


class ShortsPlatformManager(
    private val context: Context,
    private val blockedContentGoBack: () -> Unit,
) {

    private var lastTimeShortsEvent = 0L
    private var lastTimeSaved = 0L
    private var shortContentScreenTime = SharedPrefsHelper.getSetShortsScreenTimeMs(context, null)

    fun resetShortsScreenTime() {
        shortContentScreenTime = 0L
        SharedPrefsHelper.getSetShortsScreenTimeMs(context, 0L)
    }

    /**
     * Checks if a blocked short-form content feature is open and applies restrictions.
     *
     * @param packageName The package name of the current app in focus.
     * @param node The root `AccessibilityNodeInfo` of the current screen.
     * @param settings The user's `WellBeingSettings`, including blocked features and time limits.
     */
    fun blockDistraction(
        packageName: String,
        node: AccessibilityNodeInfo,
        settings: WellBeingSettings,
    ) {
        // Use default youtube package for unofficial clients too
        val resolvedPackage =
            if (packageName.contains(YOUTUBE_CLIENT_PACKAGE_SUFFIX)) YOUTUBE_PACKAGE
            else packageName

        val blockedFeatures = settings.blockedFeatures

        /// Check if blocking is enabled for platforms
        val isFeatureOpen = when (resolvedPackage) {
            INSTAGRAM_PACKAGE -> isInstagramFeatureOpen(node, blockedFeatures)
            SNAPCHAT_PACKAGE -> isSnapchatFeatureOpen(node, blockedFeatures)
            FACEBOOK_PACKAGE -> isFacebookFeatureOpen(node, blockedFeatures)
            REDDIT_PACKAGE -> isRedditFeatureOpen(node, blockedFeatures)
            YOUTUBE_PACKAGE -> isYoutubeFeatureOpen(node, blockedFeatures)
            else -> false
        }

        if (isFeatureOpen) {
            maxAllowedDuration[resolvedPackage]?.let {
                updateShortsScreenTime(settings.allowedShortContentTimeMs, it)
            }
        }
    }

    /**
     * Checks if a short-form content website is open in the browser based on WellBeingSettings.
     *
     * @param settings The WellBeingSettings model indicating which platforms are blocked.
     * @param url      The URL text from the browser.
     * @return True if a blocked short-form content website is open, false otherwise.
     */
    fun checkAndBlockShortsOnBrowser(settings: WellBeingSettings, url: String): Boolean {
        when {
            PlatformFeatures.INSTAGRAM_REELS in settings.blockedFeatures
                    && doesUrlContainsAnyElement(mInstaReelUrls, url) -> true

            PlatformFeatures.INSTAGRAM_EXPLORE in settings.blockedFeatures
                    && doesUrlContainsAnyElement(mInstaExploreUrls, url) -> true

            PlatformFeatures.YOUTUBE_SHORTS in settings.blockedFeatures
                    && doesUrlContainsAnyElement(mYtShortUrls, url) -> true

            PlatformFeatures.FACEBOOK_REELS in settings.blockedFeatures
                    && doesUrlContainsAnyElement(mFbReelUrls, url) -> true

            PlatformFeatures.SNAPCHAT_SPOTLIGHT in settings.blockedFeatures
                    && doesUrlContainsAnyElement(mSnapSpotlightUrls, url) -> true

            PlatformFeatures.SNAPCHAT_DISCOVER in settings.blockedFeatures
                    && doesUrlContainsAnyElement(mSnapDiscoverUrls, url) -> true

            else -> false
        }.let {
            if (it) {
                updateShortsScreenTime(settings.allowedShortContentTimeMs)
                return true
            }
        }

        return false
    }

    /**
     * Updates the total screen time spent on short-form content and blocks access if the allowed time is exceeded.
     *
     * @param allowedShortContentTimeMs The maximum time allowed for short-form content.
     * @param maxAllowedDuration The maximum duration considered for a single short-form content session.
     */
    private fun updateShortsScreenTime(
        allowedShortContentTimeMs: Long,
        maxAllowedDuration: Long = 30 * 1000L,
    ) {
        // Check if limit is exhausted
        if (allowedShortContentTimeMs < 0 || shortContentScreenTime > (allowedShortContentTimeMs + SAVING_INTERVAL_MS)) {
            blockedContentGoBack.invoke()
            return
        }

        // Calculate screen time since last check
        val currentTime = System.currentTimeMillis()
        val elapsedTime = if (lastTimeShortsEvent != 0L) currentTime - lastTimeShortsEvent else 0

        // Update only if elapsedTime is less than MAX_ALLOWED_DURATION otherwise user may have closed short content,
        shortContentScreenTime += (if (elapsedTime <= maxAllowedDuration) elapsedTime else 0)
        lastTimeShortsEvent = currentTime

        // Check if the minimum interval has passed before calling shared preferences
        if ((currentTime - lastTimeSaved) > SAVING_INTERVAL_MS) {
            SharedPrefsHelper.getSetShortsScreenTimeMs(context, shortContentScreenTime)
            lastTimeSaved = currentTime
            Log.d(
                TAG,
                "checkTimerAndBlockShortContent: shorts time saved: " + (shortContentScreenTime / 1000L) + " seconds"
            )
        }
    }


    companion object {
        private const val TAG = "Mindful.ShortsPlatformManager"

        // The minimum interval between saving short content's screen time in shared preferences
        private const val SAVING_INTERVAL_MS = (30 * 1000L)

        /**
         * Max allowed duration for each short content platform (based on the highest short length or duration)
         * If the interval between two short content block event is <= DURATION then it is considered that user is watching short content
         **/
        private val maxAllowedDuration = mapOf(
            INSTAGRAM_PACKAGE to (90 * 1000L),
            SNAPCHAT_PACKAGE to (60 * 1000L),
            FACEBOOK_PACKAGE to (90 * 1000L),
            REDDIT_PACKAGE to (60 * 1000L),
            YOUTUBE_PACKAGE to (3 * 60 * 1000L),
        )

        // Possible URLs of different short-form content platforms
        private val mInstaReelUrls = listOf("instagram.com/reels/", "m.instagram.com/reels/")
        private val mInstaExploreUrls = listOf("instagram.com/explore/", "m.instagram.com/explore/")

        private val mYtShortUrls = listOf("youtube.com/shorts/", "m.youtube.com/shorts/")
        private val mFbReelUrls = listOf("facebook.com/reel/", "m.facebook.com/reel/")
        private val mSnapSpotlightUrls = listOf(
            "snapchat.com/spotlight/",
            "m.snapchat.com/spotlight/",
            "web.snapchat.com/spotlight/"
        )
        private val mSnapDiscoverUrls = listOf(
            "snapchat.com/discover/",
            "m.snapchat.com/discover/",
            "web.snapchat.com/discover/"
        )

        private val mFbNodeTexts = listOf("Add a comment", "कमेंट जोड़ें…")


        /**
         * Checks if Instagram features (Reels or Search Feed) are open.
         */
        private fun isInstagramFeatureOpen(
            node: AccessibilityNodeInfo,
            blockedFeatures: Set<PlatformFeatures>,
        ): Boolean {
            return when {
                PlatformFeatures.INSTAGRAM_REELS in blockedFeatures &&
                        doesNodeByIdExists(node, "com.instagram.android:id/clips_video_container")
                -> true

                PlatformFeatures.INSTAGRAM_EXPLORE in blockedFeatures &&
                        doesNodeByIdExists(node, "com.instagram.android:id/action_bar_search_edit_text")
                -> true

                else -> false
            }
        }

        /**
         * Checks if YouTube Shorts is currently open.
         */
        private fun isYoutubeFeatureOpen(
            node: AccessibilityNodeInfo,
            blockedFeatures: Set<PlatformFeatures>,
        ): Boolean {
            return PlatformFeatures.YOUTUBE_SHORTS in blockedFeatures &&
                    doesNodeByIdExists(node, "${node.packageName}:id/reel_player_underlay")
        }

        /**
         * Checks if Snapchat Spotlight or Discover is open.
         */
        private fun isSnapchatFeatureOpen(
            node: AccessibilityNodeInfo,
            blockedFeatures: Set<PlatformFeatures>,
        ): Boolean {

            return when {
                PlatformFeatures.SNAPCHAT_SPOTLIGHT in blockedFeatures &&
                        doesNodeByIdExists(
                            node,
                            "com.snapchat.android:id/spotlight_card_static_thumbnail"
                        )
                -> true

                PlatformFeatures.SNAPCHAT_DISCOVER in blockedFeatures &&
                        doesNodeByIdExists(node, "com.snapchat.android:id/df_large_story")
                -> true

                else -> false
            }
        }

        /**
         * Checks if Facebook Reels is currently open.
         */
        private fun isFacebookFeatureOpen(
            node: AccessibilityNodeInfo,
            blockedFeatures: Set<PlatformFeatures>,
        ): Boolean {
            // TODO: Add more string translated from different languages for the node text
            //  as user may have set different language for facebook app

            if (PlatformFeatures.FACEBOOK_REELS in blockedFeatures) {
                for (text in mFbNodeTexts) {
                    if (node.findAccessibilityNodeInfosByText(text).isNotEmpty()) {
                        return true
                    }
                }
            }

            return false
        }

        /**
         * Checks if Reddit Shorts is open.
         */
        private fun isRedditFeatureOpen(
            node: AccessibilityNodeInfo,
            blockedFeatures: Set<PlatformFeatures>,
        ): Boolean {
            return PlatformFeatures.REDDIT_SHORTS in blockedFeatures && node.viewIdResourceName == "feed_vertical_pager"
        }

        /**
         * Checks if the URL contains any of the elements from the provided list of URLs.
         *
         * @param urlList The list of URL substrings to check against.
         * @param url     The URL to check.
         * @return True if the URL contains any element from the list, false otherwise.
         */
        @Contract(pure = true)
        private fun doesUrlContainsAnyElement(urlList: List<String>, url: String): Boolean {
            for (element in urlList) {
                if (url.contains(element)) return true
            }
            return false
        }

        /**
         * Checks whether an AccessibilityNodeInfo with the specified view ID exists as a descendant
         * of the given node.
         *
         * @param node   The parent AccessibilityNodeInfo to search within. This parameter must not be null.
         * @param viewId The ID of the view to look for.
         * @return `true` if a node with the specified view ID exists, `false` otherwise.
         */
        private fun doesNodeByIdExists(node: AccessibilityNodeInfo, viewId: String): Boolean {
            return node.findAccessibilityNodeInfosByViewId(viewId).isNotEmpty()
        }
    }
}