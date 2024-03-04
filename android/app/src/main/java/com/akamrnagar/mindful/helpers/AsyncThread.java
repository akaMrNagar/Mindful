package com.akamrnagar.mindful.helpers;

import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

public class AsyncThread {
    private final ThreadPoolExecutor mthreadPoolExecutor;

    public AsyncThread() {
        BlockingQueue<Runnable> workQueue = new LinkedBlockingQueue<>();
        this.mthreadPoolExecutor = new ThreadPoolExecutor(1, 1, 1, TimeUnit.SECONDS, workQueue);
    }

    public void run(Runnable runnable) {
        mthreadPoolExecutor.execute(runnable);
    }
}
