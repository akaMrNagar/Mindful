package com.mindful.android.generics;

import android.os.Binder;

/**
 * ServiceBinder is a generic binder class used to provide a reference to a service.
 * It allows the client to retrieve the service instance that is bound to it.
 *
 * @param <T> The type of the service being bound.
 */
public class ServiceBinder<T> extends Binder {
    public static final String ACTION_START_SERVICE = "com.mindful.android.service.START";


    private final T mService;

    /**
     * Constructs a ServiceBinder with the provided service.
     *
     * @param service The service instance to be bound.
     */
    public ServiceBinder(T service) {
        mService = service;
    }

    /**
     * Retrieves the service instance that is bound to this binder.
     *
     * @return The bound service instance.
     */
    public T getService() {
        return mService;
    }
}
