/*
 *
 *  * Copyright (c) 2024 Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

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
