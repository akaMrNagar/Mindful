package com.akamrnagar.mindful.generics;

import static com.akamrnagar.mindful.generics.ServiceBinder.ACTION_START_SERVICE;
import static com.akamrnagar.mindful.generics.ServiceBinder.ACTION_STOP_SERVICE;

import android.app.Service;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.IBinder;

import com.akamrnagar.mindful.helpers.ServicesHelper;

public class SafeServiceConnection<T extends Service> implements ServiceConnection {

    private final Class<T> mServiceClass;
    private T mService = null;
    private boolean mIsBound = false;

    private SuccessCallback<T> mConnectionSuccessCallback = null;

    public SafeServiceConnection(Class<T> serviceClass) {
        mServiceClass = serviceClass;
    }

    @Override
    public void onServiceConnected(ComponentName name, IBinder service) {
        mService = ((ServiceBinder<T>) service).getService();

        if (mService != null) {
            mIsBound = true;
            if(mConnectionSuccessCallback != null) mConnectionSuccessCallback.onSuccess(mService);
        }
    }

    @Override
    public void onServiceDisconnected(ComponentName name) {
        mService = null;
    }

    public T getService() {
        return mService;
    }

    public boolean isConnected() {
        return mService != null;
    }

    public void bindService(Context context) {
        if (!mIsBound && ServicesHelper.isServiceRunning(context, mServiceClass.getName())) {
            context.bindService(new Intent(context, mServiceClass), this, Context.BIND_WAIVE_PRIORITY);
        }
    }

    public void unBindService(Context context) {
        if (mIsBound) {
            context.unbindService(this);
            mIsBound = false;
            mService = null;
        }
    }


    public void startAndBind(Context context) {
        if (!ServicesHelper.isServiceRunning(context, mServiceClass.getName())) {
            context.startService(new Intent(context, mServiceClass).setAction(ACTION_START_SERVICE));
        }
        bindService(context);
    }

    public void stopAndUnBind(Context context) {
        unBindService(context);

        if (ServicesHelper.isServiceRunning(context, mServiceClass.getName())) {
            context.startService(new Intent(context, mServiceClass).setAction(ACTION_STOP_SERVICE));
        }
    }

    public void setOnConnectedCallback(SuccessCallback<T> callback) {
        mConnectionSuccessCallback = callback;
    }
}
