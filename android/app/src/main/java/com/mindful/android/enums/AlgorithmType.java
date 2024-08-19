package com.mindful.android.enums;

public enum AlgorithmType {
    UsageStates,
    UsageEvents;


    public static AlgorithmType fromInteger(int x) {
        switch (x) {
            case 0:
                return AlgorithmType.UsageStates;
            case 1:
                return AlgorithmType.UsageEvents;
        }
        return AlgorithmType.UsageStates;
    }

    public int toInteger() {
        switch (this) {
            case UsageStates:
                return 0;
            case UsageEvents:
                return 1;
        }
        return 0;
    }
}