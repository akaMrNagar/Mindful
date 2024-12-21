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

import android.app.Service;
import android.os.Binder;

/**
 * ServiceBinder is a generic binder class used to provide a reference to a service.
 * It allows the client to retrieve the service instance that is bound to it.
 *
 * @param <T> The type of the service being bound.
 */
public class ServiceBinder<T extends Service> extends Binder {

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
