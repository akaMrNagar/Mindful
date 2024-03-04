package com.akamrnagar.mindful.models;

import androidx.annotation.NonNull;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

public class AndroidApp {

    /// App info
    public String appName;
    public String packageName;
    public int appUid;
    public String appIcon;
    public int category;
    public boolean isImpSysApp;


    /// Usage info
    public ArrayList<Long> screenTimeThisWeek;
    public ArrayList<Long> mobileUsageThisWeek;
    public ArrayList<Long> wifiUsageThisWeek;
    public ArrayList<Long> dataUsageThisWeek;

    public AndroidApp(String appName, String packageName, String appIcon, boolean isImpSysApp, int category, int appUid) {
        this.appName = appName;
        this.packageName = packageName;
        this.appIcon = appIcon;
        this.isImpSysApp = isImpSysApp;
        this.category = category;
        this.appUid = appUid;
        this.screenTimeThisWeek = new ArrayList<>(Collections.nCopies(7, 0L));
        this.mobileUsageThisWeek = new ArrayList<>(Collections.nCopies(7, 0L));
        this.wifiUsageThisWeek = new ArrayList<>(Collections.nCopies(7, 0L));
        this.dataUsageThisWeek = new ArrayList<>(Collections.nCopies(7, 0L));
    }

    private void convertBytesToKB() {
        for (int i = 0; i < 7; i++) {
            if (mobileUsageThisWeek.get(i) > 0) {
                mobileUsageThisWeek.set(i, mobileUsageThisWeek.get(i) / 1024);
            }
            if (wifiUsageThisWeek.get(i) > 0) {
                wifiUsageThisWeek.set(i, wifiUsageThisWeek.get(i) / 1024);
            }

            dataUsageThisWeek.set(i, mobileUsageThisWeek.get(i) + wifiUsageThisWeek.get(i));
        }

    }

    public Map<String, Object> toMap() {
        convertBytesToKB();
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
