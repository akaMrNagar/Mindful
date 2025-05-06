package com.mindful.android.generics

/**
 * A generic time-aware Least Recently Used (LRU) cache.
 *
 * It stores key-value pairs with a fixed capacity (`maxSize`) and evicts:
 * - The least recently used items when capacity is exceeded.
 * - Entries older than a specified time-to-live (`maxAgeMs`).
 *
 * @param K The type of keys maintained by this cache.
 * @param V The type of mapped values.
 * @property maxSize The maximum number of items to retain.
 * @property maxAgeMs Maximum age (in milliseconds) an entry can be stored before being expired.
 */
class SmartCacheBox<K, V>(
    private val maxSize: Int,
    private val maxAgeMs: Long,
) {

    private data class TimedValue<V>(val value: V, var timestamp: Long)

    private val cache = LinkedHashMap<K, TimedValue<V>>()

    /**
     * Inserts or updates an entry in the cache.
     *
     * @param key The key with which the specified value is to be associated.
     * @param value The value to be associated with the key.
     */
    @Synchronized
    fun put(key: K, value: V) {
        cache[key] = TimedValue(value, now())
        evictExpired()
        evictOverflow()
    }

    /**
     * Returns the value associated with the specified key if present and not expired.
     *
     * @param key The key whose associated value is to be returned.
     * @return The value to which the specified key is mapped, or `null` if not present or expired.
     */
    @Synchronized
    fun get(key: K): V? = cache[key]?.value


    /**
     * Checks whether the cache contains the specified key and that it is not expired.
     *
     * @param key The key whose presence is to be tested.
     * @return `true` if the key exists and is valid; `false` otherwise.
     */
    @Synchronized
    fun contains(key: K): Boolean = get(key) != null

    /**
     * Removes the mapping for a key from this cache if present.
     *
     * @param key The key whose mapping is to be removed.
     */
    @Synchronized
    fun remove(key: K) {
        cache.remove(key)
    }

    /**
     * Removes all entries from the cache.
     */
    @Synchronized
    fun clear() {
        cache.clear()
    }

    /**
     * Returns the number of currently valid (non-expired) items in the cache.
     *
     * @return The count of non-expired entries.
     */
    @Synchronized
    fun size(): Int {
        return cache.size
    }

    /**
     * Returns the current system time in milliseconds.
     */
    private fun now(): Long = System.currentTimeMillis()

    /**
     * Removes all expired entries based on the TTL (`maxAgeMs`).
     */
    private fun evictExpired() {
        val iterator = cache.entries.iterator()
        val currentTime = now()
        while (iterator.hasNext()) {
            val entry = iterator.next()
            if (currentTime - entry.value.timestamp > maxAgeMs) {
                iterator.remove()
            }
        }
    }

    /**
     * Removes least recently used entries if the cache exceeds its size limit (`maxSize`).
     */
    private fun evictOverflow() {
        while (cache.size > maxSize) {
            val iterator = cache.entries.iterator()
            if (iterator.hasNext()) {
                iterator.next()
                iterator.remove()
            }
        }
    }
}
