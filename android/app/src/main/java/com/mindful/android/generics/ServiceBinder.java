package com.mindful.android.generics;


import android.os.Binder;

public class ServiceBinder<T> extends Binder {

    public static final String ACTION_START_SERVICE = "com.mindful.android.service.START";
    public static final String ACTION_STOP_SERVICE = "com.mindful.android.service.STOP";

    T mService;

    public ServiceBinder(T service) {
        mService = service;
    }

    public T getService() {
        return mService;
    }

}
