package com.mindful.android.utils

import org.json.JSONArray

object JsonUtils {
    fun parseIntList(
        json: String?,
        fallback: List<Int> = emptyList(),
    ): List<Int> {
        return try {
            val array = JSONArray(json ?: return fallback)
            List(array.length()) { i -> array.optInt(i) }
        } catch (e: Exception) {
            fallback
        }
    }

    fun parseBooleanList(
        json: String?,
        fallback: List<Boolean> = emptyList(),
    ): List<Boolean> {
        return try {
            val array = JSONArray(json ?: return fallback)
            List(array.length()) { i -> array.optBoolean(i, false) }
        } catch (e: Exception) {
            fallback
        }
    }

    fun parseBooleanListFromInt(
        json: String?,
        fallback: List<Boolean> = emptyList(),
    ): List<Boolean> {
        return try {
            val array = JSONArray(json ?: return fallback)
            List(array.length()) { i -> array.optInt(i, 0) == 1 }
        } catch (e: Exception) {
            fallback
        }
    }

    fun parseStringSet(json: String?, fallback: Set<String> = emptySet()): Set<String> {
        return try {
            val array = JSONArray(json ?: return fallback)
            List(array.length()) { i -> array.getString(i) }.toSet()
        } catch (e: Exception) {
            fallback
        }
    }
}