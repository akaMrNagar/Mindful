package com.mindful.android.services.timer

import android.app.Notification
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import androidx.core.app.NotificationCompat
import com.mindful.android.R
import com.mindful.android.utils.CountDownExecutor
import java.util.concurrent.TimeUnit

/**
 * A helper class to manage countdown or count-up timers with notifications.
 * It updates a notification to show the timer's progress and handles specific
 * actions on timer ticks, completion, and forced stops.
 *
 * @property context The application context used to create and display notifications.
 * @property ongoingPendingIntent The pending intent for ongoing notifications.
 * @property finishedPendingIntent The pending intent fon success notification. If this is null the [ongoingPendingIntent] will be used.
 * @property title The title of the notification displayed during the timer's operation.
 * @property isFinite Flag indicating if this timer is finite if TRUE else infinite (max 24 hours).
 * @property timerDurationSeconds The total duration of the timer in SECONDS. Set -1 for possible infinite timer.
 * @property alreadyElapsedTimeSecond The total time in SECONDS that is already passed.
 * @property notificationId The unique identifier for the notification.
 * @property notificationChannelId The ID of the notification channel for this notification.
 * @property onTicked Callback invoked on every timer tick. Accepts the current progress (in seconds) and returns a string to update the notification content.
 * @property onFinished Callback invoked when the timer finishes. Returns a string to update the final notification content.
 * @property onDispose Callback invoked when the timer is forcibly stopped or disposed.
 */
class NotificationTimer(
    private val context: Context,
    private val ongoingPendingIntent: PendingIntent,
    private val finishedPendingIntent: PendingIntent? = null,
    private val title: String,
    private val isFinite: Boolean = true,
    private val timerDurationSeconds: Long,
    private val alreadyElapsedTimeSecond: Long = 0,
    private val notificationId: Int,
    private val notificationChannelId: String,
    private val onTicked: (progress: Int) -> String,
    private val onFinished: () -> String,
    private val onDispose: () -> Unit,
) {
    private val notificationManager: NotificationManager =
        context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

    /**
     * Returns the initial notification object, which can be used to start the service in the foreground.
     */
    val getInitialNotification: Notification get() = notificationBuilder.build()

    private val notificationBuilder: NotificationCompat.Builder =
        NotificationCompat.Builder(context, notificationChannelId)
            .setSmallIcon(R.drawable.ic_notification)
            .setOngoing(true)
            .setOnlyAlertOnce(true)
            .setContentIntent(ongoingPendingIntent)
            .setContentTitle(title)

    private val countDownExecutor: CountDownExecutor = CountDownExecutor(
        duration = timerDurationSeconds,
        interval = 1L,
        timeUnit = TimeUnit.SECONDS,
        onTick = { elapsedSeconds ->
            val totalElapsedSeconds = elapsedSeconds + alreadyElapsedTimeSecond
            val progressSeconds =
                if (isFinite) (timerDurationSeconds - totalElapsedSeconds).toInt()
                else totalElapsedSeconds.toInt()

            // Update the notification with the progress.
            val contentText = onTicked.invoke(progressSeconds)
            pushNotification(contentText, progressSeconds)
        },
        onFinish = {
            // When the timer finishes, invoke the onFinished callback and show the final notification.
            val contentText = onFinished.invoke()
            showFinishNotification(contentText)
        }
    )


    /**
     * Updates the notification with the current progress.
     *
     * @param contentText The content to display in the notification.
     * @param progress The current progress in seconds.
     */
    private fun pushNotification(contentText: String, progress: Int) {
        notificationBuilder.setContentText(contentText)

        // Set progress if the timer is finite
        if (isFinite) notificationBuilder.setProgress(
            (timerDurationSeconds).toInt(),
            progress,
            false
        )

        // Notify the system to update the displayed notification.
        notificationManager.notify(notificationId, notificationBuilder.build())
    }

    /**
     * Displays the final notification when the timer finishes or is stopped.
     *
     * @param contentText The content to display in the final notification.
     */
    private fun showFinishNotification(contentText: String) {
        notificationBuilder
            .setContentText(contentText)
            .setOngoing(false)
            .setAutoCancel(true)
            .setProgress(0, 0, false)
            .setContentIntent(finishedPendingIntent ?: ongoingPendingIntent)
            .setStyle(NotificationCompat.BigTextStyle().bigText(contentText))

        // Invoke the onDispose callback to handle any cleanup.
        onDispose.invoke()

        notificationManager.notify(notificationId, notificationBuilder.build())
    }

    /**
     * Start the timer on the basis of provided data.
     */
    fun startTimer() {
        countDownExecutor.start()
    }

    /**
     * Forces the timer to stop immediately and displays a notification with the reason.
     *
     * @param reason The reason to display in the final notification.
     */
    fun forceDisposeTimer(reason: String) {
        // Cancel the active timer to stop further ticks.
        countDownExecutor.cancel()

        // Show the final notification with the provided reason.
        showFinishNotification(reason)
    }
}
