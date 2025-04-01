package com.mindful.android.utils

import java.util.Stack

object Extensions {

    /**
     * Looks at the object at the top of this stack without removing it
     * from the stack.
     *
     * @return  the object at the top of this stack (the last item
     *          of the {@code Vector} object) or null if empty.
     */
    fun <T> Stack<T>.safePeek(): T? = if (isEmpty()) null else peek()

    /**
     * Removes the object at the top of this stack and returns that
     * object as the value of this function.
     *
     * @return  The object at the top of this stack (the last item
     *          of the {@code Vector} object) or null if empty.
     */
    fun <T> Stack<T>.safePop(): T? = if (isEmpty()) null else pop()
}