package com.mindful.android.services.accessibility

import android.content.Context
import android.util.Log
import android.view.accessibility.AccessibilityNodeInfo
import com.mindful.android.helpers.SharedPrefsHelper
import com.mindful.android.models.WellBeingSettings
import com.mindful.android.utils.AppConstants.FACEBOOK_PACKAGE
import com.mindful.android.utils.AppConstants.INSTAGRAM_PACKAGE
import com.mindful.android.utils.AppConstants.REDDIT_PACKAGE
import com.mindful.android.utils.AppConstants.SNAPCHAT_PACKAGE
import com.mindful.android.utils.AppConstants.YOUTUBE_CLIENT_PACKAGE_SUFFIX
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

    fun checkAndBlockShortsOnPlatforms(
        packageName: String,
        node: AccessibilityNodeInfo,
        settings: WellBeingSettings,
    ) {
        /// Check if blocking ir enabled for package
        val activeConfigs = blockingConfigs.filter { config ->
            when (config.packageName) {
                INSTAGRAM_PACKAGE -> settings.blockInstaReels
                FACEBOOK_PACKAGE -> settings.blockFbReels
                SNAPCHAT_PACKAGE -> settings.blockSnapSpotlight
                REDDIT_PACKAGE -> settings.blockRedditShorts
                YOUTUBE_CLIENT_PACKAGE_SUFFIX -> settings.blockYtShorts
                else -> false
            }
        }

        /// Verify the blocking
        activeConfigs.firstOrNull { config ->
            if (config.packageName == packageName || packageName.contains(config.packageName)) {
                config.isContentOpen(packageName, node)
            } else {
                false
            }

            /// Update shorts screen time if content is open
        }?.let { updateShortsScreenTime(it.maxAllowedDuration) }
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
            settings.blockInstaReels && doesUrlContainsAnyElement(mInstaReelUrls, url) -> true
            settings.blockYtShorts && doesUrlContainsAnyElement(mYtShortUrls, url) -> true
            settings.blockFbReels && doesUrlContainsAnyElement(mFbReelUrls, url) -> true
            settings.blockSnapSpotlight && doesUrlContainsAnyElement(
                mSnapSpotlightUrls,
                url
            ) -> true

            else -> false
        }.let {
            if (it) {
                updateShortsScreenTime(30 * 1000L)
                return true
            }
        }

        return false
    }

    /**
     * Checks the total screen time for short-form content and blocks access if the allowed time has been exceeded.
     */
    private fun updateShortsScreenTime(
        maxAllowedDuration: Long,
    ) {
        // Check if limit is exhausted
        if (shortContentScreenTime < 0 || shortContentScreenTime > (shortContentScreenTime + SAVING_INTERVAL_MS)) {
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

        private data class BlockConfig(
            val packageName: String,
            val isContentOpen: (String, AccessibilityNodeInfo) -> Boolean,
            // Max allowed duration for each short content platform (based on the highest short length or duration)
            // If the interval between two short content block event is <= DURATION then it is considered that user is watching short content
            val maxAllowedDuration: Long,
        )

        private val blockingConfigs = listOf(
            BlockConfig(INSTAGRAM_PACKAGE, ::isInstaReelsOpen, (90 * 1000L)),
            BlockConfig(SNAPCHAT_PACKAGE, ::isInstaReelsOpen, (60 * 1000L)),
            BlockConfig(FACEBOOK_PACKAGE, ::isInstaReelsOpen, (90 * 1000L)),
            BlockConfig(REDDIT_PACKAGE, ::isInstaReelsOpen, (60 * 1000L)),
            BlockConfig(YOUTUBE_CLIENT_PACKAGE_SUFFIX, ::isYoutubeShortsOpen, (3 * 60 * 1000L)),
        )

        // Possible URLs of different short-form content platforms
        private val mInstaReelUrls = listOf("instagram.com/reels/", "m.instagram.com/reels/")
        private val mYtShortUrls = listOf("youtube.com/shorts/", "m.youtube.com/shorts/")
        private val mFbReelUrls = listOf("facebook.com/reel/", "m.facebook.com/reel/")
        private val mSnapSpotlightUrls = listOf(
            "snapchat.com/spotlight/",
            "m.snapchat.com/spotlight/",
            "web.snapchat.com/spotlight/"
        )

        private val mFbNodeIds = listOf("Add a comment…", "कमेंट जोड़ें…")


        /**
         * Checks if Instagram Reels is currently open based on accessibility node information.
         *
         * @param node The root AccessibilityNodeInfo of the view hierarchy.
         * @return True if Instagram Reels is open, false otherwise.
         */
        private fun isInstaReelsOpen(
            packageName: String,
            node: AccessibilityNodeInfo,
        ): Boolean {
            val nodeId: CharSequence? = node.viewIdResourceName
            // Check root node
            if (nodeId != null && nodeId == "com.instagram.android:id/clips_viewer_view_pager") {
                return true
            }
            return doesNodeByIdExists(node, "com.instagram.android:id/clips_video_container")
        }

        /**
         * Checks if YouTube Shorts is currently open based on accessibility node information.
         *
         * @param node              The AccessibilityNodeInfo of the view.
         * @param clientPackageName The package name of the youtube client which is open.
         * @return True if YouTube Shorts is open, false otherwise.
         */
        private fun isYoutubeShortsOpen(
            clientPackageName: String,
            node: AccessibilityNodeInfo,
        ): Boolean {
            val nodeId: CharSequence? = node.viewIdResourceName
            if (nodeId != null
                && (nodeId == "$clientPackageName:id/reel_progress_bar" || nodeId == "$clientPackageName:id/reel_player_page_container" || nodeId == "$clientPackageName:id/reel_recycler")
            ) {
                return true
            }
            return doesNodeByIdExists(node, "$clientPackageName:id/reel_player_underlay")
        }

        /**
         * Checks if Snapchat Spotlight is currently open based on accessibility node information.
         *
         * @param node The AccessibilityNodeInfo of the view.
         * @return True if Snapchat Spotlight is open, false otherwise.
         */
        private fun isSnapchatSpotlightOpen(
            packageName: String,
            node: AccessibilityNodeInfo,
        ): Boolean {
            return doesNodeByIdExists(node, "com.snapchat.android:id/spotlight_view_count")
        }

        /**
         * Checks if Facebook Reels is currently open based on accessibility node information.
         *
         * @param node The AccessibilityNodeInfo of the view.
         * @return True if Facebook Reels is open, false otherwise.
         */
        private fun isFacebookReelsOpen(
            packageName: String,
            node: AccessibilityNodeInfo,
        ): Boolean {
            // TODO: Add more string translated from different languages for the node text
            //  as user may have set different language for facebook app

            if (doesNodeHaveFbCommentText(node)) return true

            for (i in 0 until node.childCount) {
                val childNode = node.getChild(i) ?: continue
                if (doesNodeHaveFbCommentText(childNode)) return true
            }

            return false
        }

        /**
         * Checks if Reddit Shorts is currently open based on accessibility node information.
         *
         * @param node The AccessibilityNodeInfo of the view.
         * @return True if Reddit Shorts is open, false otherwise.
         */
        private fun isRedditShortsOpen(
            packageName: String,
            node: AccessibilityNodeInfo,
        ): Boolean {
            val nodeId: CharSequence? = node.viewIdResourceName
            return nodeId != null && nodeId == "feed_vertical_pager"
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
            val nodes = node.findAccessibilityNodeInfosByViewId(viewId)
            return nodes != null && nodes.isNotEmpty()
        }

        /**
         * Checks whether the text of the given AccessibilityNodeInfo matches with one of the facebook comment nodes text.
         *
         * @param node The AccessibilityNodeInfo whose text is to be checked.
         * @return `true` if the node's text matches, `false` otherwise.
         */
        private fun doesNodeHaveFbCommentText(node: AccessibilityNodeInfo): Boolean {
            val nodeText = node.text
            return nodeText != null && mFbNodeIds.contains(nodeText.toString())
        }
    }
}