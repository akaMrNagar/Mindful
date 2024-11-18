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

public class PurgedReason {
    public final String reasonMsg;
    public final long totalLimit;
    public final long usedLimit;

    public PurgedReason(String reasonMsg, long totalLimit, long usedLimit) {
        this.reasonMsg = reasonMsg;
        this.totalLimit = totalLimit;
        this.usedLimit = usedLimit;
    }

    public PurgedReason(String reasonMsg) {
        this.reasonMsg = reasonMsg;
        this.totalLimit = -1;
        this.usedLimit = -1;
    }
}
