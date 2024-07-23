package com.mindful.android.generics;

import static com.mindful.android.generics.ServiceBinder.ACTION_START_SERVICE;

import android.app.Service;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.IBinder;

import com.mindful.android.helpers.ServicesHelper;

public class SafeServiceConnection<T extends Service> implements ServiceConnection {

    private final Class<T> mServiceClass;
    private final Context mContext;
    private T mService = null;
    private boolean mIsBound = false;

    private SuccessCallback<T> mConnectionSuccessCallback = null;

    public SafeServiceConnection(Class<T> serviceClass, Context context) {
        mServiceClass = serviceClass;
        mContext = context;
    }

    @Override
    public void onServiceConnected(ComponentName name, IBinder service) {
        mService = ((ServiceBinder<T>) service).getService();

        if (mService != null) {
            mIsBound = true;
            if (mConnectionSuccessCallback != null) mConnectionSuccessCallback.onSuccess(mService);
        }
    }

    @Override
    public void onServiceDisconnected(ComponentName name) {
        unBindService();
    }

    public T getService() {
        return mService;
    }

    public boolean isConnected() {
        return mService != null;
    }

    public void bindService() {
        if (!mIsBound && ServicesHelper.isServiceRunning(mContext, mServiceClass.getName())) {
            mContext.bindService(new Intent(mContext, mServiceClass), this, Context.BIND_WAIVE_PRIORITY);
        }
    }

    public void unBindService() {
        if (mIsBound) {
            mContext.unbindService(this);
            mIsBound = false;
            mService = null;
        }
    }


    public void startOnly() {
        if (!ServicesHelper.isServiceRunning(mContext, mServiceClass.getName())) {
            mContext.startService(new Intent(mContext, mServiceClass).setAction(ACTION_START_SERVICE));
        }
    }

    public void startAndBind() {
        if (!ServicesHelper.isServiceRunning(mContext, mServiceClass.getName())) {
            mContext.startService(new Intent(mContext, mServiceClass).setAction(ACTION_START_SERVICE));
        }
        bindService();
    }

    public void setOnConnectedCallback(SuccessCallback<T> callback) {
        mConnectionSuccessCallback = callback;
    }
}
