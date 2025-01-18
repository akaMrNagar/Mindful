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
package com.mindful.android.utils

import android.content.Intent
import android.util.Log
import com.mindful.android.models.AppRestrictions
import com.mindful.android.models.RestrictionGroup
import org.json.JSONArray
import org.json.JSONException
import org.json.JSONObject

object JsonDeserializer {
    private const val TAG = "Mindful.JsonDeserializer"

    /**
     * Deserializes a JSON string into a HashMap of String keys and Long values.
     *
     * @param jsonString The JSON string to deserialize.
     * @return A HashMap containing the deserialized data.
     */
    //FIXME: Remove if not needed
    fun jsonStrToStringLongHashMap(jsonString: String): HashMap<String, Long> {
        val map = HashMap<String, Long>()
        if (jsonString.isEmpty()) return map

        try {
            val jsonObject = JSONObject(jsonString)

            val it = jsonObject.keys()
            while (it.hasNext()) {
                val key = it.next()
                val value = jsonObject.getLong(key)
                map[key] = value
            }
        } catch (e: JSONException) {
            Log.e(TAG, "jsonStrToAppTimersMap: Error deserializing JSON to timers map ", e)
        }
        return map
    }

    /**
     * Deserializes a JSON string into a HashSet of String.
     *
     * @param jsonString The JSON string to deserialize.
     * @return A HashSet containing the deserialized data.
     */
    fun jsonStrToStringHashSet(jsonString: String?): HashSet<String> {
        val set = HashSet<String>()
        if (jsonString.isNullOrBlank()) return set

        try {
            val jsonArray = JSONArray(jsonString)
            for (i in 0 until jsonArray.length()) {
                set.add(jsonArray.getString(i))
            }
        } catch (e: JSONException) {
            Log.e(TAG, "jsonStrToLockedAppsSet: Error deserializing JSON to STRING hashset ", e)
        }
        return set
    }

    /**
     * Deserializes a JSON string into a HashSet of Integers.
     *
     * @param jsonString The JSON string to deserialize.
     * @return A HashSet containing the deserialized data.
     */
    fun jsonStrToIntegerHashSet(jsonString: String?): HashSet<Int> {
        val set = HashSet<Int>()
        if (jsonString.isNullOrBlank()) return set

        try {
            val jsonArray = JSONArray(jsonString)
            for (i in 0 until jsonArray.length()) {
                set.add(jsonArray.getInt(i))
            }
        } catch (e: JSONException) {
            Log.e(TAG, "jsonStrToIntegerHashSet: Error deserializing JSON to INTEGER hashset ", e)
        }
        return set
    }


    /**
     * Safely retrieves a HashSet of Strings from an Intent.
     *
     * @param intent The Intent to retrieve data from.
     * @param key    The key for the data in the Intent.
     * @return A HashSet of strings, or an empty set if data is null.
     */
    //FIXME: Remove if not needed
    fun getStringHashSetFromIntent(intent: Intent?, key: String?): HashSet<String> {
        val set = HashSet<String>(0)
        if (intent == null) return set

        val intentData = intent.getStringArrayListExtra(key)
        return if (intentData == null) set else HashSet(intentData)
    }


    /**
     * Converts a JSON string to a HashMap with String keys and AppRestrictions values.
     *
     * @param jsonString The JSON string to convert.
     * @return A HashMap with deserialized AppRestrictions, or an empty map on error.
     */
    fun jsonStrToAppRestrictionsHashMap(jsonString: String?): HashMap<String, AppRestrictions> {
        val map = HashMap<String, AppRestrictions>()
        if (jsonString.isNullOrBlank()) return map

        try {
            val jsonArray = JSONArray(jsonString)
            for (i in 0 until jsonArray.length()) {
                val jsonObj = jsonArray.getJSONObject(i)
                val restrictions = AppRestrictions(jsonObj)
                map[restrictions.appPackage] = restrictions
            }
        } catch (e: JSONException) {
            Log.e(
                TAG,
                "jsonStrToAppRestrictionsHashMap: Error deserializing JSON to App Restrictions map ",
                e
            )
        }
        return map
    }

    /**
     * Converts a JSON string to a HashMap with Integer keys and RestrictionGroup values.
     *
     * @param jsonString The JSON string to convert.
     * @return A HashMap with deserialized RestrictionGroups, or an empty map on error.
     */
    fun jsonStrToRestrictionGroupsHashMap(jsonString: String?): HashMap<Int, RestrictionGroup> {
        val map = HashMap<Int, RestrictionGroup>()
        if (jsonString.isNullOrBlank()) return map

        try {
            val jsonArray = JSONArray(jsonString)
            for (i in 0 until jsonArray.length()) {
                val jsonObj = jsonArray.getJSONObject(i)
                val group = RestrictionGroup(jsonObj)
                map[group.id] = group
            }
        } catch (e: JSONException) {
            Log.e(
                TAG,
                "jsonStrToGroupRestrictionsHashMap: Error deserializing JSON to App Restrictions map ",
                e
            )
        }
        return map
    }
}
