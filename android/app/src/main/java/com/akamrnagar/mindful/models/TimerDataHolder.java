package com.akamrnagar.mindful.models;

import java.io.Serializable;
import java.util.HashMap;

public class TimerDataHolder implements Serializable {
    private HashMap<String, Long> appsTimer;

    public TimerDataHolder(HashMap<String, Long> appsTimer) {
        this.appsTimer = appsTimer;
    }

    public HashMap<String, Long> getAppsTimer() {
        return appsTimer;
    }
}
