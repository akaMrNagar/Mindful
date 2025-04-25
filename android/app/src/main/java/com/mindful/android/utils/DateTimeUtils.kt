package com.mindful.android.utils

import org.jetbrains.annotations.Contract
import java.util.Calendar
import java.util.Locale
import kotlin.math.abs

object DateTimeUtils {

    /**
     * Formats the total screen usage time into a human-readable string.
     * Example: 02h 43m 09s
     *
     * @param totalSeconds The total screen usage time in seconds.
     * @return A string representing the formatted screen usage time.
     */
    @Contract(pure = true)
    fun secondsToTimeStr(totalSeconds: Int): String {
        val leftHours = (totalSeconds / 3600)
        val leftMinutes = ((totalSeconds % 3600) / 60)
        val leftSeconds = (totalSeconds % 60)

        val timeStr = StringBuilder()

        if (leftHours > 0) {
            timeStr.append(String.format(Locale.ENGLISH, "%02d", leftHours)).append("h ")
        }

        timeStr.append(String.format(Locale.ENGLISH, "%02d", leftMinutes)).append("m ")
        timeStr.append(String.format(Locale.ENGLISH, "%02d", leftSeconds)).append("s")

        return timeStr.toString()
    }

    /**
     * Returns the current day of the week as a zero-based index, where Monday is 0 and Sunday is 6.
     *
     * The `Calendar.DAY_OF_WEEK` values range from `1` (Sunday) to `7` (Saturday).
     * This method shifts the values so that:
     * - Monday → `0`
     * - Tuesday → `1`
     * - Wednesday → `2`
     * - Thursday → `3`
     * - Friday → `4`
     * - Saturday → `5`
     * - Sunday → `6`
     *
     * @return An integer representing the day of the week with Monday as index `0` and Sunday as index `6`.
     */
    @Contract(pure = true)
    fun zeroIndexedDayOfWeek(): Int {
        val javaDayOfWeek = Calendar.getInstance()[Calendar.DAY_OF_WEEK]
        return (javaDayOfWeek + 5) % 7
    }


    /**
     * Create a calender instance from the Time Of Day total minutes.
     * If totalMinutes is negative then the calender is adjusted to previous day
     *
     * @param totalMinutes The total minutes from Time Of Day dart object.
     * @return Calender representing the time of day for today.
     */
    @Contract(pure = true)
    fun todToTodayCal(totalMinutes: Int): Calendar {
        val cal = Calendar.getInstance()
        cal[Calendar.HOUR_OF_DAY] = 0
        cal.add(Calendar.HOUR_OF_DAY, totalMinutes / 60)
        cal[Calendar.MINUTE] = 0
        cal.add(Calendar.MINUTE, totalMinutes % 60)
        cal[Calendar.SECOND] = 0
        cal[Calendar.MILLISECOND] = 0
        return cal
    }

    /**
     * Calculated the difference between time now and future tod minutes.
     *
     * @param futureTotalMinutes The total minutes from Time Of Day dart object.
     * @return The difference in MS. If the difference is negative then return 0
     */
    fun todDifferenceFromNow(futureTotalMinutes: Int): Long {
        val diff = todToTodayCal(futureTotalMinutes).timeInMillis - System.currentTimeMillis()
        return if (diff > 0) diff else 0
    }

    /**
     * Checks if current system time is outside the star and end Time Of Day for today
     *
     * @param startTod The start TOD in minutes
     * @param endTod   The end TOD in minutes
     * @return Boolean indicating if now is outside startTod and endTod
     */
    fun isTimeOutsideTODs(startTod: Int, endTod: Int): Boolean {
        val now = System.currentTimeMillis()
        return !(todToTodayCal(startTod).timeInMillis < now && now < todToTodayCal(endTod).timeInMillis)
    }


    /**
     * Formats the total screen usage time into a human-readable string.
     * Example: 12h 5m
     *
     * @param totalMinutes The total screen usage time in minutes.
     * @return A string representing the formatted screen usage time.
     */
    @Contract(pure = true)
    fun minutesToTimeStr(totalMinutes: Int): String {
        val totalMinutesAbs = abs(totalMinutes)

        return if (totalMinutesAbs > 60
        ) if (totalMinutesAbs % 60 == 0
        ) (totalMinutesAbs / 60).toString() + "h"
        else (totalMinutesAbs / 60).toString() + "h " + totalMinutesAbs % 60 + "m"
        else totalMinutesAbs.toString() + "m"
    }


    /**
     * Formats the total data usage into a human-readable string.
     * Example: 12.35 GB
     *
     * @param totalMBs The total data usage in megabytes (MB).
     * @return A string representing the formatted data usage.
     */
    @Contract(pure = true)
    fun formatDataMBs(totalMBs: Int): String {
        val totalMBsAbs = abs(totalMBs)

        if (totalMBsAbs >= 1024) {
            val GBs = totalMBsAbs / 1024f
            val formattedGBs = String.format(Locale.getDefault(), "%.2f", GBs)
            return "$formattedGBs GB"
        } else {
            return "$totalMBsAbs MB"
        }
    }
}