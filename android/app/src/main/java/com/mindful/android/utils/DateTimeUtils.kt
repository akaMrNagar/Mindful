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
     * Calculated Time Of Day total minutes for the now calender.
     *
     * @return Time of Day total minutes for today now.
     */
    fun todayCalToTod(): Int {
        val calendar = Calendar.getInstance()
        return (calendar.get(Calendar.HOUR_OF_DAY) * 60) + calendar.get(Calendar.MINUTE)
    }

    /**
     * Calculated the difference between time now and future tod minutes.
     *
     * @param futureTod The total minutes from Time Of Day dart object.
     * @return The difference in MS. If the difference is negative then return 0
     */
    fun todDifferenceFromNow(futureTod: Int): Long {
        val now = System.currentTimeMillis()
        val futureCal = todToTodayCal(futureTod)

        // If the future time already passed today, move to tomorrow
        if (futureTod < todayCalToTod()) {
            futureCal.add(Calendar.DAY_OF_YEAR, 1)
        }

        val diff = futureCal.timeInMillis - now
        return if (diff > 0) diff else 0
    }

    /**
     * Checks if current system time is outside the start and end Time Of Day
     *
     * @param startTod The start TOD in minutes
     * @param endTod   The end TOD in minutes
     * @return Boolean indicating if now is outside startTod and endTod
     */
    fun isTimeOutsideTODs(startTod: Int, endTod: Int): Boolean {
        val nowTod = todayCalToTod()

        // Different days
        return if (endTod < startTod) {
            // now=3 is between end=2 start=5 then outside
            nowTod in endTod until startTod
        }
        // Same day
        else {
            // now=3 is not between start=2 end=5 then outside
            nowTod !in startTod until endTod
        }
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
}