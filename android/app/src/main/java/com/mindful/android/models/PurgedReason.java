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

package com.mindful.android.models;

import com.mindful.android.enums.PurgeType;

public class PurgedReason {
    public PurgeType type = PurgeType.AppTimerOut;
    public String groupName = "";

    public PurgedReason(PurgeType type, String groupName) {
        this.type = type;
        this.groupName = groupName;
    }

    public PurgedReason(PurgeType type) {
        this.type = type;
    }

    public PurgedReason() {
    }
}
