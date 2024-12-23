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

package com.mindful.android.generics;

import static com.mindful.android.generics.ServiceBinder.ACTION_BIND_TO_MINDFUL;
import static com.mindful.android.generics.ServiceBinder.ACTION_START_MINDFUL_SERVICE;

import android.app.Service;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.IBinder;
import android.util.Log;

import androidx.annotation.NonNull;

import com.mindful.android.utils.Utils;

/**
 * SafeServiceConnection is a generic class that facilitates the connection, binding, and management of an Android Service.
 * It provides methods to start, bind, unbind, and check the connection status of the service.
 *
 * @param <T> The type of Service this class is designed to connect to.
 */
public class SafeServiceConnection<T extends Service> implements ServiceConnection {
    private final Class<T> mServiceClass;
    private final Context mContext;
    private T mService = null;
    private boolean mIsBound = false;

    private SuccessCallback<T> mConnectionSuccessCallback = null;

    /**
     * Constructs a SafeServiceConnection instance.
     *
     * @param serviceClass The class type of the service to connect to.
     * @param context      The context in which the service is being managed.
     */
    public SafeServiceConnection(Class<T> serviceClass, @NonNull Context context) {
        mServiceClass = serviceClass;
        mContext = context.getApplicationContext();
    }

    @SuppressWarnings("unchecked")
    @Override
    public void onServiceConnected(ComponentName name, IBinder binder) {
        try {
            mService = ((ServiceBinder<T>) binder).getService();

            if (mService != null) {
                mIsBound = true;
                if (mConnectionSuccessCallback != null) {
                    mConnectionSuccessCallback.onSuccess(mService);
                }
            }
        } catch (Exception ignored) {
        }
    }

    @Override
    public void onServiceDisconnected(ComponentName name) {
        unBindService();
    }

    /**
     * Retrieves the currently connected service instance.
     *
     * @return The connected service instance, or null if no service is connected.
     */
    public T getService() {
        return mService;
    }

    /**
     * Checks if the service is currently connected.
     *
     * @return True if the service is connected; false otherwise.
     */
    public boolean isConnected() {
        return mService != null;
    }

    /**
     * Binds the service if it is currently running.
     */
    public void bindService() {
        if (!mIsBound && Utils.isServiceRunning(mContext, mServiceClass.getName())) {
            try {
                Intent bindIntent = new Intent(mContext, mServiceClass);
                bindIntent.setAction(ACTION_BIND_TO_MINDFUL);
                mContext.bindService(bindIntent, this, Context.BIND_WAIVE_PRIORITY);
            } catch (Exception e) {
                Log.e("Mindful.SafeServiceConnection", "bindService: Failed to bind " + mServiceClass.getName(), e);

            }
        }
    }

    /**
     * Unbinds the service if it is currently bound.
     */
    public void unBindService() {
        synchronized (this) {
            if (mIsBound) {
                try {
                    mContext.unbindService(this);
                } catch (Exception e) {
                    Log.e("Mindful.SafeServiceConnection", "unBindService: Failed to unbind " + mServiceClass.getName(), e);
                } finally {
                    mIsBound = false;
                    mService = null;
                }
            }
        }
    }

    /**
     * Starts and binds the service if it is not already running.
     */
    public void startAndBind() {
        if (!Utils.isServiceRunning(mContext, mServiceClass.getName())) {
            mContext.startService(new Intent(mContext, mServiceClass).setAction(ACTION_START_MINDFUL_SERVICE));
        }
        bindService();
    }

    /**
     * Sets a callback to be invoked when the service successfully connects.
     *
     * @param callback The callback to be triggered upon successful connection.
     */
    public void setOnConnectedCallback(SuccessCallback<T> callback) {
        mConnectionSuccessCallback = callback;
    }
}
