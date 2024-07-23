package com.mindful.android.utils;

import java.util.Timer;
import java.util.TimerTask;

public class BgThreadDebouncer {
    private final long delayMillis;
    private Timer timer;

    public BgThreadDebouncer(long delayMillis) {
        this.delayMillis = delayMillis;
    }

    public void call(Runnable task) {
        cancel();
        timer = new Timer();
        timer.schedule(new TimerTask() {
            @Override
            public void run() {
                task.run();
                timer = null;
            }
        }, delayMillis);
    }

    public void cancel() {
        if (timer != null) {
            timer.cancel();
            timer = null;
        }
    }
}
