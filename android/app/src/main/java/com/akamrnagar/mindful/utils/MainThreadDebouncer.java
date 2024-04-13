package com.akamrnagar.mindful.utils;

import android.os.Handler;
import android.os.Looper;

public class MainThreadDebouncer {

    private final long delayMillis;
    private final Handler handler;


    public MainThreadDebouncer(long delayMillis) {
        this.delayMillis = delayMillis;
        this.handler = new Handler(Looper.getMainLooper());
    }

    public void call(Runnable task) {
        handler.removeCallbacks(task);
        handler.postDelayed(task, delayMillis);
    }
}
