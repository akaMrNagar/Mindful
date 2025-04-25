package com.mindful.android.utils

import android.database.Cursor
import java.util.Stack

object Extensions {

    /**
     * Safely returns the element at the top of the stack without removing it.
     *
     * @return The top element of the stack, or `null` if the stack is empty.
     */
    fun <T> Stack<T>.safePeek(): T? = if (isEmpty()) null else peek()

    /**
     * Safely removes and returns the element at the top of the stack.
     *
     * @return The top element of the stack, or `null` if the stack is empty.
     */
    fun <T> Stack<T>.safePop(): T? = if (isEmpty()) null else pop()

    /**
     * Retrieves the integer value for the specified column or returns a default value if
     * the column is missing or the value is invalid.
     *
     * @param column The name of the column to retrieve.
     * @param default The default value to return if the column is not found or fails.
     * @return The integer value of the column or the default.
     */
    fun Cursor.getIntOrDefault(column: String, default: Int = 0): Int {
        return runCatching { getInt(getColumnIndexOrThrow(column)) }.getOrElse { default }
    }

    /**
     * Retrieves the long value for the specified column or returns a default value if
     * the column is missing or the value is invalid.
     *
     * @param column The name of the column to retrieve.
     * @param default The default value to return if the column is not found or fails.
     * @return The long value of the column or the default.
     */
    fun Cursor.getLongOrDefault(column: String, default: Long = 0L): Long {
        return runCatching { getLong(getColumnIndexOrThrow(column)) }.getOrElse { default }
    }

    /**
     * Retrieves the boolean value for the specified column or returns a default value if
     * the column is missing or the value is invalid. The column is expected to be stored as an integer (0 or 1).
     *
     * @param column The name of the column to retrieve.
     * @param default The default value to return if the column is not found or fails.
     * @return The boolean value of the column or the default.
     */
    fun Cursor.getBooleanOrDefault(column: String, default: Boolean = false): Boolean {
        return getIntOrDefault(column, if (default) 1 else 0) == 1
    }

    /**
     * Retrieves the string value for the specified column or returns `null` if
     * the column is missing or an error occurs.
     *
     * @param column The name of the column to retrieve.
     * @return The string value of the column or `null`.
     */
    fun Cursor.getStringOrNull(column: String): String? {
        return runCatching { getString(getColumnIndexOrThrow(column)) }.getOrNull()
    }
}
