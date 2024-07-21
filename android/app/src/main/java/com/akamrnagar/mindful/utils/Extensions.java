package com.akamrnagar.mindful.utils;

import androidx.annotation.NonNull;

import java.util.Map;

// FIXME: Replace with new api getOrDefault() method
public class Extensions {
    public static <K, V> V getOrDefault(@NonNull Map<K, V> map, K key, V defaultValue) {
        return map.containsKey(key) ? map.get(key) : defaultValue;
    }
}
