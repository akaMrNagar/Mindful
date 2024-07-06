package com.akamrnagar.mindful.generics;


import android.os.Binder;

public class ServiceBinder<T> extends Binder {

    public static final String ACTION_START_SERVICE = "com.akamrnagar.mindful.service.START";
    public static final String ACTION_STOP_SERVICE = "com.akamrnagar.mindful.service.STOP";

    T mService;

    public ServiceBinder(T service) {
        mService = service;
    }

    public T getService() {
        return mService;
    }

}
