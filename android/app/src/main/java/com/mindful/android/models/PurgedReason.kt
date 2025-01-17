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
package com.mindful.android.models

class PurgedReason {
    val reasonMsg: String
    val totalLimit: Long
    val usedLimit: Long
    val remainingTimeMs: Long?

    constructor(reasonMsg: String, totalLimit: Long, usedLimit: Long) {
        this.reasonMsg = reasonMsg
        this.totalLimit = totalLimit
        this.usedLimit = usedLimit
        this.remainingTimeMs = null
    }

    constructor(reasonMsg: String, exhaustInFutureMs: Long) {
        this.reasonMsg = reasonMsg
        this.totalLimit = -1
        this.usedLimit = -1
        this.remainingTimeMs = exhaustInFutureMs
    }

    constructor(reasonMsg: String) {
        this.reasonMsg = reasonMsg
        this.totalLimit = -1
        this.usedLimit = -1
        this.remainingTimeMs = null
    }

}
