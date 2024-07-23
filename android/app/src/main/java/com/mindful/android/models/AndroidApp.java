package com.mindful.android.models;

import androidx.annotation.NonNull;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

/**
 * Represents an Android application with its usage statistics and metadata.
 */
public class AndroidApp {

    // App info
    public String appName;
    public String packageName;
    public int appUid;
    public String appIcon;
    public int category;
    public boolean isImpSysApp;

    // Usage info
    public ArrayList<Long> screenTimeThisWeek;
    public ArrayList<Long> mobileUsageThisWeek;
    public ArrayList<Long> wifiUsageThisWeek;
    public ArrayList<Long> dataUsageThisWeek;

    /**
     * Constructs an AndroidApp instance with specified parameters.
     *
     * @param appName       The name of the application.
     * @param packageName   The package name of the application.
     * @param appIcon       The icon of the application.
     * @param isImpSysApp   Indicates if the application is an important system app.
     * @param category      The category of the application.
     * @param appUid        The UID of the application.
     */
    public AndroidApp(String appName, String packageName, String appIcon, boolean isImpSysApp, int category, int appUid) {
        this.appName = appName;
        this.packageName = packageName;
        this.appIcon = appIcon;
        this.isImpSysApp = isImpSysApp;
        this.category = category;
        this.appUid = appUid;
        // Initialize usage arrays with 7 days worth of data, defaulting to 0
        this.screenTimeThisWeek = new ArrayList<>(Collections.nCopies(7, 0L));
        this.mobileUsageThisWeek = new ArrayList<>(Collections.nCopies(7, 0L));
        this.wifiUsageThisWeek = new ArrayList<>(Collections.nCopies(7, 0L));
        this.dataUsageThisWeek = new ArrayList<>(Collections.nCopies(7, 0L));
    }

    /**
     * Converts usage data from bytes to kilobytes for mobile and wifi usage.
     * Updates the dataUsageThisWeek as the sum of mobile and wifi usage.
     */
    private void convertBytesToKB() {
        for (int i = 0; i < 7; i++) {
            if (mobileUsageThisWeek.get(i) > 0) {
                mobileUsageThisWeek.set(i, mobileUsageThisWeek.get(i) / 1024);
            }
            if (wifiUsageThisWeek.get(i) > 0) {
                wifiUsageThisWeek.set(i, wifiUsageThisWeek.get(i) / 1024);
            }

            // Calculate total data usage as the sum of mobile and wifi usage
            dataUsageThisWeek.set(i, mobileUsageThisWeek.get(i) + wifiUsageThisWeek.get(i));
        }
    }

    /**
     * Converts the AndroidApp object to a map of string keys to object values.
     * The map can be used for serialization or other purposes.
     *
     * @return A map representing the AndroidApp object.
     */
    public Map<String, Object> toMap() {
        convertBytesToKB(); // Ensure data is in kilobytes
        Map<String, Object> appMap = new HashMap<>();
        appMap.put("appName", appName);
        appMap.put("packageName", packageName);
        appMap.put("appIcon", appIcon);
        appMap.put("isImpSysApp", isImpSysApp);
        appMap.put("category", category);
        appMap.put("screenTimeThisWeek", screenTimeThisWeek);
        appMap.put("mobileUsageThisWeek", mobileUsageThisWeek);
        appMap.put("wifiUsageThisWeek", wifiUsageThisWeek);
        appMap.put("dataUsageThisWeek", dataUsageThisWeek);
        return appMap;
    }

    /**
     * Provides a string representation of the AndroidApp object.
     *
     * @return A string representation of the AndroidApp object.
     */
    @NonNull
    @Override
    public String toString() {
        return "AndroidApp{" +
                "appName='" + appName + '\'' +
                ", packageName='" + packageName + '\'' +
                ", appUid=" + appUid +
                ", isImpSysApp=" + isImpSysApp +
                ", category=" + category +
                ", screenTimeThisWeek=" + screenTimeThisWeek +
                ", mobileUsageThisWeek=" + mobileUsageThisWeek +
                ", wifiUsageThisWeek=" + wifiUsageThisWeek +
                ", dataUsageThisWeek=" + dataUsageThisWeek +
                '}';
    }
}
