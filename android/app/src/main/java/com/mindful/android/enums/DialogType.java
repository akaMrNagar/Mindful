package com.mindful.android.enums;

public enum DialogType {
    FocusSession,
    BedtimeRoutine,
    TimerOut;


    public static DialogType fromInteger(int x) {
        switch (x) {
            case 0:
                return DialogType.FocusSession;
            case 1:
                return DialogType.BedtimeRoutine;
            case 2:
                return DialogType.TimerOut;
        }
        return DialogType.TimerOut;
    }

    public int toInteger() {
        switch (this) {
            case FocusSession:
                return 0;
            case BedtimeRoutine:
                return 1;
            case TimerOut:
                return 2;
        }
        return 2;
    }
}
