package com.mindful.android.services.accessibility

import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Handler
import android.os.Looper
import android.provider.Browser
import android.util.Log
import android.view.accessibility.AccessibilityNodeInfo
import android.widget.Toast
import com.mindful.android.R
import com.mindful.android.models.WellBeingSettings
import com.mindful.android.utils.NsfwDomains
import com.mindful.android.utils.ThreadUtils
import com.mindful.android.utils.Utils
import kotlin.math.log

class BrowserManager(
    private val context: Context,
    private val shortsPlatformManager: ShortsPlatformManager,
    private val blockedContentGoBack: () -> Unit,
) {
    private var mLastRedirectedUrl = ""

    /**
     * Blocks access to websites and short-form content based on current settings.
     *
     * @param node        The AccessibilityNodeInfo of the current view.
     * @param packageName The package name of the app.
     */
    fun blockDistraction(
        packageName: String,
        node: AccessibilityNodeInfo,
        settings: WellBeingSettings,
    ) {
        var url = extractBrowserUrl(node, packageName)

        // Return if url is empty or does not contain dot or have space this basically means its not url
        if (url.contains(" ") || !url.contains(".")) return

        // Clean google AMP from the url if found (some site can appear in the AMP container with google's amp domain)
        url = url.replace("google.com/amp/s/amp.", "")

        // Block websites
        val host = Utils.parseHostNameFromUrl(url)
        if (settings.blockedWebsites.contains(host) || nsfwDomains.containsKey(host)) {
            Log.d(TAG, "blockDistraction: Blocked website $host opened in $packageName")
            blockedContentGoBack()
            return
        }

        // Block short form content
        if (shortsPlatformManager.checkAndBlockShortsOnBrowser(settings, url)) {
            return
        }

        // Activate safe search if NSFW is blocked
        if (settings.blockNsfwSites) {
            applySafeSearch(packageName, url, host)
        }
    }

    /**
     * Redirects the user to safe search results by using different techniques on different search engines.
     * Supported search engines are GOOGLE, BRAVE, BING, DUCKDUCKGO
     *
     * @param browserPackage The package name of the browser app.
     * @param url            The url from the browser's search bar.
     * @param hostDomain     The resolved host name for the provided url.
     */
    private fun applySafeSearch(browserPackage: String, url: String, hostDomain: String) {
        // For bing, google use &safe=active flag
        // For brave, duckduckgo switch domain to safe.[SEARCH_ENGINE_DOMAIN]

        // For GOOGLE and BING search engines
        if (!url.contains("safe=active") &&
            (url.contains("google.com/search?") || url.contains("bing.com/search?"))
        ) {
            val safeUrl = url.replace("/search?", "/search?safe=active&")
            redirectUserToUrl(safeUrl, browserPackage)
        } else if (
            !hostDomain.contains("safe.") &&
            (url.contains("search.brave.com/search?") || url.contains("duckduckgo.com/?"))
        ) {
            val safeUrl =
                if (hostDomain.contains("search.brave.com")) url.replace(
                    "search.brave.com",
                    "safe.search.brave.com"
                ) else url.replace("duckduckgo.com", "safe.duckduckgo.com")

            redirectUserToUrl(safeUrl, browserPackage)
        }
    }

    /**
     * Redirects the user to the new url in the specified browser.
     *
     * @param url            The url to which user will be redirected.
     * @param browserPackage The package name of the browser app.
     */
    private fun redirectUserToUrl(url: String, browserPackage: String) {
        // Return if received request for the same URL as previous
        if (mLastRedirectedUrl == url) return
        mLastRedirectedUrl = url

        // Post to the main thread
        ThreadUtils.runOnMainThread {
            val intent = Intent(Intent.ACTION_VIEW, Uri.parse(Utils.validateHttpsProtocol(url)))
            intent.putExtra(Browser.EXTRA_APPLICATION_ID, browserPackage)
            intent.setPackage(browserPackage)
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            if (intent.resolveActivity(context.packageManager) != null) {

                /// Toast
                Toast.makeText(
                    context,
                    context.getString(R.string.toast_redirecting),
                    Toast.LENGTH_SHORT
                ).show()

                /// Redirect
                context.startActivity(intent)
                Log.d(
                    TAG,
                    "Redirecting user to safe search results in $browserPackage for url: $url"
                )

                // Clean redirection url after approximate loading time
                Handler().postDelayed({ mLastRedirectedUrl = "" }, 500L)
            } else {
                Log.e(TAG, "No application found to handle the Intent for URL: $url")
            }
        }
    }


    companion object {
        private const val TAG = "Mindful.BrowserEventsManager"
        private var nsfwDomains: Map<String, Boolean> = mapOf()

        fun initializeNsfwDomains() {
            nsfwDomains = NsfwDomains.init()
        }

        fun clearNsfwDomains() {
            nsfwDomains = mapOf()
        }

        /**
         * List of Ids of URL Bars used by different browsers.
         * These are used to retrieve/extract url from the browsers.
         */
        private val urlBarNodeIds = setOf(
            ":id/url_bar",  // Chrome
            ":id/mozac_browser_toolbar_url_view",  // Firefox
            ":id/url",
            ":id/search",
            ":id/url_field",
            ":id/location_bar_edit_text",
            ":id/addressbarEdit",
            ":id/bro_omnibar_address_title_text",
            ":id/cbn_tv_title" // Quetta Browser
        )


        /**
         * Extracts the URL from the given AccessibilityNodeInfo based on the app package name.
         *
         * @param node        The AccessibilityNodeInfo of the current view.
         * @param packageName The package name of the app.
         * @return The extracted URL as a string.
         */
        private fun extractBrowserUrl(node: AccessibilityNodeInfo, packageName: String): String {
            try {
                // Find by input field class
                if (node.className == "android.widget.EditText") {
                    val txtSequence = node.text
                    if (!txtSequence.isNullOrBlank()) {
                        return txtSequence.toString()
                    }
                }

                // Find by recursive checking
                for (id in urlBarNodeIds) {
                    val urlBarNodes = node.findAccessibilityNodeInfosByViewId(packageName + id)
                    if (urlBarNodes.isNotEmpty()) {
                        val txtSequence = urlBarNodes.first().text
                        if (!txtSequence.isNullOrBlank()) {
                            return txtSequence.toString()
                        }
                    }
                }

            } catch (ignored: Exception) {
            }

            return ""
        }
    }
}