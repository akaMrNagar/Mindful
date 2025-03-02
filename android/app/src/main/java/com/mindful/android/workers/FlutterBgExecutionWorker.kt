package com.mindful.android.workers

import android.content.Context
import android.util.Log
import androidx.annotation.UiThread
import androidx.work.Worker
import androidx.work.WorkerParameters
import com.mindful.android.FgMethodCallHandler
import com.mindful.android.helpers.storage.SharedPrefsHelper
import com.mindful.android.utils.AppConstants
import com.mindful.android.utils.ThreadUtils
import io.flutter.FlutterInjector
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel
import java.util.concurrent.CountDownLatch
import java.util.concurrent.TimeUnit

class FlutterBgExecutionWorker(
    private val context: Context,
    private val workerParams: WorkerParameters,
) : Worker(context, workerParams) {
    companion object {
        private const val TAG = "Mindful.FlutterBgExecutionWorker";
        const val FLUTTER_TASK_ID = "com.mindful.android.flutterTaskId"
    }

    private var flutterEngine: FlutterEngine? = null
    private val latch = CountDownLatch(1)

    override fun doWork(): Result {
        try {
            workerParams.inputData.getString(FLUTTER_TASK_ID)?.let {
                Log.d(TAG, "doWork: Starting task{$it} on native side")
                ThreadUtils.runOnMainThread { startEngineAndExecuteTask(it) }

                // Automatically dispose after 5 minutes if no response from flutter side
                latch.await(5, TimeUnit.MINUTES)

                Log.d(TAG, "doWork: Task{$it} completed on native side")
            }
            return Result.success()
        } catch (e: Exception) {
            SharedPrefsHelper.insertCrashLogToPrefs(context, e)
            Log.e(TAG, "doWork: Failed to complete work", e)
            return Result.failure()
        }
    }


    /**
     * Starts flutter dart vm in background and execute the task with the give [taskId].
     *
     * @param taskId        The name of the method which will be invoked on the flutter side
     *                      on the background method channel
     */
    @UiThread
    private fun startEngineAndExecuteTask(taskId: String) {
        // Initialize FlutterEngine
        flutterEngine = FlutterEngine(context)

        flutterEngine?.let { engine ->

            // Initialize dart VM
            engine.dartExecutor.executeDartEntrypoint(
                DartExecutor.DartEntrypoint(
                    FlutterInjector.instance().flutterLoader().findAppBundlePath(),
                    "initBgExecutorService"
                )
            )

            // Set up MethodChannels to communicate with Dart
            val fgChannel =
                MethodChannel(
                    engine.dartExecutor.binaryMessenger,
                    AppConstants.FLUTTER_METHOD_CHANNEL_FG
                )
            val fgHandler = FgMethodCallHandler(context)
            fgChannel.setMethodCallHandler(fgHandler)


            val bgChannel =
                MethodChannel(
                    engine.dartExecutor.binaryMessenger,
                    AppConstants.FLUTTER_METHOD_CHANNEL_BG
                )
            bgChannel.setMethodCallHandler { call, result ->
                if (call.method == "signalTaskCompleted") {
                    // If failed with error
                    val errorMsg: String? = call.arguments as String?
                    errorMsg?.let {
                        SharedPrefsHelper.insertCrashLogToPrefs(context, Throwable(it))
                        Log.d(
                            TAG,
                            "startExecution: Received task failure signal on native side: $it"
                        )
                    } ?: Log.d(TAG, "startExecution: Received task success signal on native side")

                    // Dispose anyway
                    fgHandler.dispose()
                    dispose()
                    result.success(null)
                }
            }

            // Invoke the task with method name
            bgChannel.invokeMethod(taskId, null)
        }
    }

    private fun dispose() {
        ThreadUtils.runOnMainThread {
            flutterEngine?.destroy();
            flutterEngine = null
        }

        latch.countDown()
        Log.d(TAG, "dispose: Stopping worker")
    }

    override fun onStopped() {
        dispose()
        super.onStopped()
    }
}