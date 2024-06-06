package com.akamrnagar.mindful.helpers;

import android.content.SharedPreferences;
import android.util.Log;

import androidx.annotation.NonNull;

import com.akamrnagar.mindful.utils.AppConstants;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;


public class SharedPrefsHelper {

    private static final String TAG = "Mindful.SharedPrefsHelper";

    public HashMap<String, Long> loadAppTimers(@NonNull SharedPreferences prefs) {
        String jsonString = prefs.getString(AppConstants.PREF_KEY_APP_TIMERS, "");
        HashMap<String, Long> map = new HashMap<>();
        if (jsonString.isEmpty()) return map;

        try {
            JSONObject mapObj = new JSONObject(jsonString);

            for (Iterator<String> it = mapObj.keys(); it.hasNext(); ) {
                String key = it.next();
                JSONObject info = new JSONObject(mapObj.getString(key));
                map.put(key, info.getLong("timer"));
            }
        } catch (JSONException e) {
            Log.e(TAG, "loadAppTimers: Error while deserializing JSON to a map ",e);
        }

        return map;
    }

    public HashSet<String> loadProtectedApps() {
        HashSet<String> protectedApps = new HashSet<>(1);
        return protectedApps;
    }
}
