/*
 *
 *  *
 *  *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *  *
 *  *  * This source code is licensed under the GPL-2.0 license license found in the
 *  *  * LICENSE file in the root directory of this source tree.
 *  *
 *
 */

package com.mindful.android.utils;

import android.util.Log;

import androidx.annotation.NonNull;

import com.mindful.android.models.AppRestrictions;
import com.mindful.android.models.RestrictionGroup;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;

public class JsonDeserializer {
    private static final String TAG = "Mindful.JsonDeserializer";

    /**
     * Deserializes a JSON string into a HashMap of String keys and Long values.
     *
     * @param jsonString The JSON string to deserialize.
     * @return A HashMap containing the deserialized data.
     */
    @NonNull
    public static HashMap<String, Long> jsonStrToStringLongHashMap(@NonNull String jsonString) {
        HashMap<String, Long> map = new HashMap<>();
        if (jsonString.isEmpty()) return map;

        try {
            JSONObject jsonObject = new JSONObject(jsonString);

            for (Iterator<String> it = jsonObject.keys(); it.hasNext(); ) {
                String key = it.next();
                Long value = jsonObject.getLong(key);
                map.put(key, value);
            }
        } catch (JSONException e) {
            Log.e(TAG, "jsonStrToAppTimersMap: Error deserializing JSON to timers map ", e);
        }
        return map;
    }

    /**
     * Deserializes a JSON string into a HashSet of String.
     *
     * @param jsonString The JSON string to deserialize.
     * @return A HashSet containing the deserialized data.
     */
    @NonNull
    public static HashSet<String> jsonStrToStringHashSet(@NonNull String jsonString) {
        HashSet<String> set = new HashSet<>();
        if (jsonString.isEmpty()) return set;

        try {
            JSONArray jsonArray = new JSONArray(jsonString);
            for (int i = 0; i < jsonArray.length(); i++) {
                set.add(jsonArray.getString(i));
            }
        } catch (JSONException e) {
            Log.e(TAG, "jsonStrToLockedAppsSet: Error deserializing JSON to locked apps hashset ", e);
        }
        return set;
    }



    @NonNull
    public static HashMap<String, AppRestrictions> jsonStrToAppRestrictionsHashMap(@NonNull String jsonString) {
        HashMap<String, AppRestrictions> map = new HashMap<>();
        if (jsonString.isEmpty()) return map;

        try {
            JSONArray jsonArray = new JSONArray(jsonString);
            for (int i = 0; i < jsonArray.length(); i++) {
                JSONObject jsonObj = jsonArray.getJSONObject(i);
                AppRestrictions restrictions = new AppRestrictions(jsonObj);
                map.put(restrictions.appPackage, restrictions);
            }
        } catch (JSONException e) {
            Log.e(TAG, "jsonStrToAppRestrictionsHashMap: Error deserializing JSON to App Restrictions map ", e);
        }
        return map;
    }

    @NonNull
    public static HashMap<Integer, RestrictionGroup> jsonStrToRestrictionGroupsHashMap(@NonNull String jsonString) {
        HashMap<Integer, RestrictionGroup> map = new HashMap<>();
        if (jsonString.isEmpty()) return map;

        try {
            JSONArray jsonArray = new JSONArray(jsonString);
            for (int i = 0; i < jsonArray.length(); i++) {
                JSONObject jsonObj = jsonArray.getJSONObject(i);
                RestrictionGroup restrictions = new RestrictionGroup(jsonObj);
                map.put(i, restrictions);
            }
        } catch (JSONException e) {
            Log.e(TAG, "jsonStrToGroupRestrictionsHashMap: Error deserializing JSON to App Restrictions map ", e);
        }
        return map;
    }
}
