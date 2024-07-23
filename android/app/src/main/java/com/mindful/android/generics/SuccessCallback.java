package com.mindful.android.generics;

/**
 * SuccessCallback is a generic interface for handling success events.
 * It defines a callback method to be invoked when an operation is successful.
 *
 * @param <T> The type of the result that is returned upon success.
 */
public interface SuccessCallback<T> {
    /**
     * Method to be called when the operation is successful.
     *
     * @param result The result of the successful operation.
     */
    void onSuccess(T result);
}
