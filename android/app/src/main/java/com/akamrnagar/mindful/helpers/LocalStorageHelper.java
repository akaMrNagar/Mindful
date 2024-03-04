package com.akamrnagar.mindful.helpers;

import android.content.Context;
import android.content.SharedPreferences;

import androidx.annotation.NonNull;

import com.akamrnagar.mindful.utils.AppConstants;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;

import io.flutter.Log;

public class LocalStorageHelper {
    private final SharedPreferences mSharedPrefs;

    public LocalStorageHelper(@NonNull Context context) {
        mSharedPrefs = context.getSharedPreferences(AppConstants.PREFS_FLUTTER_PREFIX, Context.MODE_PRIVATE);
    }

    public HashMap<String, Long> loadAppTimers() {
        String jsonString = mSharedPrefs.getString(AppConstants.PREF_APP_FOCUS_INFOS, "");
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
            Log.d(AppConstants.ERROR_TAG, "Error deserializing JSON to a map: " + e.getMessage());
        }

        return map;
    }

    public HashSet<String> loadProtectedApps() {
        HashSet<String> protectedApps = new HashSet<>(1);
        return protectedApps;
    }
}
