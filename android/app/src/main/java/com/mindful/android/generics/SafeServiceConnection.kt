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
package com.mindful.android.generics

import android.app.Service
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.ServiceConnection
import android.os.IBinder
import android.util.Log
import com.mindful.android.helpers.storage.SharedPrefsHelper
import com.mindful.android.utils.Utils

/**
 * SafeServiceConnection is a generic class that facilitates the connection, binding, and management of an Android Service.
 * It provides methods to start, bind, unbind, and check the connection status of the service.
 *
 * @param <T> The type of Service this class is designed to connect to.</T>
 */
class SafeServiceConnection<T : Service>(
    private val context: Context,
    private val serviceClass: Class<T>,
) : ServiceConnection {

    var service: T? = null
    val isActive: Boolean get() = service != null

    private var mIsBound = false
    private var mOnServiceConnected: ((service: T) -> Unit)? = null

    override fun onServiceConnected(name: ComponentName, binder: IBinder) {
        try {
            val binderService = (binder as ServiceBinder<T>?)?.service

            binderService?.let {
                service = it
                mIsBound = true
                mOnServiceConnected?.invoke(it)
            }
        } catch (ignored: Exception) {
        }
    }

    override fun onServiceDisconnected(name: ComponentName) {
        unBindService()
    }

    /**
     * Checks if the service is currently connected.
     *
     * @return True if the service is connected; false otherwise.
     */
//    val isConnected: Boolean get() = service != null

    /**
     * Binds the service if it is currently running.
     */
    fun bindService(): Boolean {
        if (!mIsBound && Utils.isServiceRunning(context, serviceClass)) {
            try {
                val bindIntent = Intent(context, serviceClass)
                bindIntent.setAction(ServiceBinder.ACTION_BIND_TO_MINDFUL)
                return context.bindService(bindIntent, this, Context.BIND_WAIVE_PRIORITY)
            } catch (e: Exception) {
                SharedPrefsHelper.insertCrashLogToPrefs(context, e)
                Log.e(
                    "Mindful.SafeServiceConnection",
                    "bindService: Failed to bind " + serviceClass.name,
                    e
                )
            }
        }
        return mIsBound && Utils.isServiceRunning(context, serviceClass)
    }

    /**
     * Unbinds the service if it is currently bound.
     */
    fun unBindService() {
        synchronized(this) {
            if (mIsBound) {
                try {
                    context.unbindService(this)
                } catch (e: Exception) {
                    SharedPrefsHelper.insertCrashLogToPrefs(context, e)
                    Log.e(
                        "Mindful.SafeServiceConnection",
                        "unBindService: Failed to unbind " + serviceClass.name,
                        e
                    )
                } finally {
                    mIsBound = false
                    service = null
                }
            }
        }
    }

    /**
     * Starts and binds the service if it is not already running.
     */
    fun startAndBind() {
        if (!Utils.isServiceRunning(context, serviceClass)) {
            context.startService(
                Intent(
                    context,
                    serviceClass
                ).setAction(ServiceBinder.ACTION_START_MINDFUL_SERVICE)
            )
        }
        bindService()
    }

    /**
     * Sets a callback to be invoked when the service successfully connects.
     *
     * @param callback The callback to be triggered upon successful connection.
     */
    fun setOnConnectedCallback(callback: ((service: T) -> Unit)) {
        mOnServiceConnected = callback
    }
}
