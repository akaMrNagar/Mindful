package com.akamrnagar.mindful.services;

import android.accessibilityservice.AccessibilityService;
import android.content.Intent;
import android.net.Uri;
import android.provider.Browser;
import android.util.Log;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityNodeInfo;

import com.akamrnagar.mindful.utils.Domains;
import com.akamrnagar.mindful.utils.MainThreadDebouncer;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;

public class MindfulAccessibilityService extends AccessibilityService {
    public static Map<String, Boolean> nsfwSites = new HashMap<>();
    static String TAG = "MindfulAccessibilityService";
    private final String randomURL = "https://apilevels.com/";
    private static HashSet<String> blockedSites = new HashSet<>(2);

    private final MainThreadDebouncer mainThreadDebouncer = new MainThreadDebouncer(1000);

    // TODO: call setServiceInfo() in onServiceConnected to set packages name for better performance
    @Override
    public void onCreate() {
        super.onCreate();
        // Static shout out mister David Wang pair programming ftw
        nsfwSites = Domains.init();

        blockedSites.add("instagram.com");
        Log.d(TAG, "onCreate: we saved our dict2 lez see wat hapn " + nsfwSites.size());
    }


    @Override
    public void onAccessibilityEvent(AccessibilityEvent event) {
        if (event.getPackageName() == null) return;

        // Check if its browser event if not return
        String activeAppPackage = event.getPackageName().toString();
        if (!isBrowserEvent(activeAppPackage)) return;


        // Check if window content changed event
        if (event.getEventType() == AccessibilityEvent.TYPE_WINDOW_CONTENT_CHANGED) {
            AccessibilityNodeInfo node = event.getSource();
            if (node == null || node.getClassName() == null) return;

            // Check if the node is an input field
            if (node.getClassName().equals("android.widget.EditText")) {
                // Check if the input field text contains a porn website
                String inputText = node.getText().toString().trim().toLowerCase();

                // If text contains space and does not contain dot the return
                // Basically it is not url
                if (inputText.contains(" ") || !inputText.contains(".")) return;

                // Get host name with different methods
                String host = getHostName(inputText).trim();


                Log.d(TAG, "User is searching website : " + host);

                if (!randomURL.contains(host) && (nsfwSites.get(host) != null || blockedSites.contains(host))) {
                    Log.d(TAG, "Blocked website opened site : " + host + "  in browser: " + activeAppPackage);

                    mainThreadDebouncer.call(
                            new Runnable() {
                                @Override
                                public void run() {
                                    // Attempting direct redirection

                                    Log.d(TAG, "Redirecting user to new site");
                                    Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse(randomURL));
                                    intent.putExtra(Browser.EXTRA_APPLICATION_ID, activeAppPackage);
                                    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                                    startActivity(intent);
                                }
                            }
                    );


                    // Check if its unsafe search
                } else if (inputText.contains("google.com/search?") && !inputText.contains("&safe=active")) {
                    Log.d(TAG, "redirecting to safe google search");
                    Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse("https://" + inputText + "&safe=active"));
                    intent.putExtra(Browser.EXTRA_APPLICATION_ID, activeAppPackage);
                    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                    startActivity(intent);
                }


            }
        }
    }


    public String getHostName(String url) {
        URI uri;

        try {
            uri = new URI(url);
        } catch (URISyntaxException e) {
            e.printStackTrace();
            return url;
        }

        String hostName = uri.getHost();

        // If null, then hostname = the original url ?
        if (hostName == null) {
            hostName = url;
        }

        hostName = hostName.replace("https://", "").replace("http://", "").replace("www.", "");


        if (hostName.contains("www.")) {
            hostName = hostName.substring(4);
        }

        // Fuck you websites that use mobile prefix and break my hashmap
        if (hostName.contains("mobile.")) {
            hostName = hostName.substring(7);
        } else if (hostName.contains("m.") && hostName.indexOf("m.") < 3) {
            // medium.com => dium.com smh todo?
            hostName = hostName.substring(2);
        }

        // Fuck you no path allowed
        if (hostName.contains("/")) {
            return hostName.substring(0, hostName.indexOf("/"));
        }

//        Log.d(TAG, "getHostName: url++ = " + hostName);
        return hostName;
    }

    boolean isBrowserEvent(String packageName) {
        return packageName.equals("com.brave.browser");
    }


    @Override
    public void onInterrupt() {
    }
}
