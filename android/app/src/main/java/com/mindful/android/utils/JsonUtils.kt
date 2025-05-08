package com.mindful.android.utils

import android.util.Log
import com.mindful.android.models.AppRestriction
import com.mindful.android.models.RestrictionGroup
import org.json.JSONArray
import org.json.JSONException

/**
 * Utility functions for JSON parsing related to app restrictions and restriction groups.
 */
object JsonUtils {
    private const val TAG = "Mindful.JsonUtils"

    /**
     * Parses a JSON array string into a list of integers.
     *
     * @param json JSON array string (e.g., "[1, 2, 3]").
     * @param fallback A list to return in case of parsing failure.
     * @return A list of integers or the fallback list if parsing fails.
     */
    fun parseIntList(
        json: String?,
        fallback: List<Int> = emptyList(),
    ): List<Int> {
        return try {
            val array = JSONArray(json ?: return fallback)
            List(array.length()) { i -> array.optInt(i) }
        } catch (e: Exception) {
            Log.e(TAG, "parseIntList: Failed to parse JSON list of Ints", e)
            fallback
        }
    }

    /**
     * Parses a JSON array string into a list of booleans.
     *
     * @param json JSON array string (e.g., "[true, false, true]").
     * @param fallback A list to return in case of parsing failure.
     * @return A list of booleans or the fallback list if parsing fails.
     */
    fun parseBooleanList(
        json: String?,
        fallback: List<Boolean> = emptyList(),
    ): List<Boolean> {
        return try {
            val array = JSONArray(json ?: return fallback)
            List(array.length()) { i -> array.optBoolean(i, false) }
        } catch (e: Exception) {
            Log.e(TAG, "parseBooleanList: Failed to parse JSON list of Booleans", e)
            fallback
        }
    }

    /**
     * Parses a JSON array string into a list of booleans from integers (1 = true, 0 = false).
     *
     * @param json JSON array string (e.g., "[1, 0, 1]").
     * @param fallback A list to return in case of parsing failure.
     * @return A list of booleans or the fallback list if parsing fails.
     */
    fun parseBooleanListFromInt(
        json: String?,
        fallback: List<Boolean> = emptyList(),
    ): List<Boolean> {
        return try {
            val array = JSONArray(json ?: return fallback)
            List(array.length()) { i -> array.optInt(i, 0) == 1 }
        } catch (e: Exception) {
            Log.e(TAG, "parseBooleanListFromInt: Failed to parse JSON list of Ints to Booleans", e)
            fallback
        }
    }

    /**
     * Parses a JSON array string into a set of strings.
     *
     * @param json JSON array string (e.g., "[\"com.example.app1\", \"com.example.app2\"]").
     * @param fallback A set to return in case of parsing failure.
     * @return A set of strings or the fallback set if parsing fails.
     */
    fun parseStringSet(
        json: String?,
        fallback: Set<String> = emptySet(),
    ): Set<String> {
        return try {
            val array = JSONArray(json ?: return fallback)
            List(array.length()) { i -> array.getString(i) }.toSet()
        } catch (e: Exception) {
            Log.e(TAG, "parseStringSet: Failed to parse JSON set of Strings", e)
            fallback
        }
    }

    /**
     * Deserializes a JSON string into a HashMap mapping app package names to [AppRestriction] objects.
     *
     * @param jsonString The JSON string representing a list of AppRestrictions.
     * @return A HashMap of [AppRestriction] or an empty map if parsing fails.
     */
    fun parseAppRestrictionsMap(jsonString: String?): HashMap<String, AppRestriction> {
        val map = HashMap<String, AppRestriction>()
        if (jsonString.isNullOrBlank()) return map

        return try {
            JSONArray(jsonString).let { jsonArray ->
                for (i in 0 until jsonArray.length()) {
                    val restriction = AppRestriction.fromJson(jsonArray.getString(i))
                    map[restriction.appPackage] = restriction
                }
                map
            }
        } catch (e: JSONException) {
            Log.e(TAG, "jsonStrToAppRestrictionsHashMap: Failed to parse AppRestrictions", e)
            map
        }
    }

    /**
     * Deserializes a JSON string into a HashMap mapping group IDs to [RestrictionGroup] objects.
     *
     * @param jsonString The JSON string representing a list of RestrictionGroups.
     * @return A HashMap of [RestrictionGroup] or an empty map if parsing fails.
     */
    fun parseRestrictionGroupsMap(jsonString: String?): HashMap<Int, RestrictionGroup> {
        val map = HashMap<Int, RestrictionGroup>()
        if (jsonString.isNullOrBlank()) return map

        return try {
            JSONArray(jsonString).let { jsonArray ->
                for (i in 0 until jsonArray.length()) {
                    val group = RestrictionGroup.fromJson(jsonArray.getString(i))
                    map[group.id] = group
                }
                map
            }
        } catch (e: JSONException) {
            Log.e(TAG, "jsonStrToRestrictionGroupsHashMap: Failed to parse RestrictionGroups", e)
            map
        }
    }
}
