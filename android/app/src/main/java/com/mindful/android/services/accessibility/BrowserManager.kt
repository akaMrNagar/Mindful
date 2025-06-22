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
import com.mindful.android.models.Wellbeing
import com.mindful.android.utils.NsfwDomains
import com.mindful.android.utils.NsfwKeywords
import com.mindful.android.utils.ThreadUtils
import com.mindful.android.utils.Utils
import com.mindful.android.utils.executors.Throttler

class BrowserManager(
    private val context: Context,
    private val shortsPlatformManager: ShortsPlatformManager,
    private val blockedContentGoBack: () -> Unit,
) {
    private var mLastRedirectedUrl = ""
    private val throttler: Throttler = Throttler(1000L)

    fun getHost(packageName: String, node: AccessibilityNodeInfo): String?
    {
        var url = extractBrowserUrl(node, packageName)
        if (url.contains(" ") || !url.contains(".")) return null
        url = url.replace("google.com/amp/s/amp.", "")
        val host = Utils.parseHostNameFromUrl(url) ?: return null
        return host
    }

    /**
     * Blocks access to websites and short-form content based on current settings.
     *
     * @param node        The AccessibilityNodeInfo of the current view.
     * @param packageName The package name of the app.
     */
    fun blockDistraction(
        packageName: String,
        node: AccessibilityNodeInfo,
        wellbeing: Wellbeing,
    ) {
        var url = extractBrowserUrl(node, packageName)
        val host = getHost(packageName, node) ?: return

        when {
            nsfwDomains[host] ?: false
            -> {
                Log.d(TAG, "blockDistraction: Blocked website $host opened in $packageName")
                blockedContentGoBack.invoke()
            }

            // Block short form content
            shortsPlatformManager.checkAndBlockShortsOnBrowser(wellbeing, url) -> return

            // Activate safe search if NSFW is blocked
            wellbeing.blockNsfwSites -> applySafeSearch(packageName, url, host)
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
        val query = runCatching { Uri.parse(url) }.getOrNull()
            ?.getQueryParameter("q")?.lowercase() ?: url

        // Apply safe search if searching maybe nsfw
        if (NsfwKeywords.keywords.none { query.contains(it) }) return

        val safeUrl = when {
            /// Google search
            !url.contains("safe=active")
                    && (url.contains("google.com/search?") || url.contains("bing.com/search?"))
            -> url.replace("/search?", "/search?safe=active&")

            /// Brave search
            !hostDomain.contains("safe.") && hostDomain.contains("search.brave.com")
            -> url.replace("search.brave.com", "safe.search.brave.com")

            /// DuckDuckGo search
            !hostDomain.contains("safe.") && hostDomain.contains("duckduckgo.com")
            -> url.replace("duckduckgo.com", "safe.duckduckgo.com")

            else -> return
        }

        // Redirect user
        throttler.submit {
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
                .apply {
                    putExtra(Browser.EXTRA_APPLICATION_ID, browserPackage)
                    setPackage(browserPackage)
                    addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                }

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
                Handler(
                    Looper.myLooper() ?: Looper.getMainLooper()
                ).postDelayed({ mLastRedirectedUrl = "" }, 500L)
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
            ":id/omnibarTextInput", // Duck duck go
            ":id/url_field", // Opera
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
                // Return if suggestion box is open for chromium based browsers
                if (node.findAccessibilityNodeInfosByViewId("$packageName:id/omnibox_suggestions_dropdown")
                        .isNotEmpty()
                ) {
                    return ""
                }


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
