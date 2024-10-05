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

public class AggregatedUsage {
    public final int totalScreenUsageMins;
    public final int totalMobileUsageMBs;
    public final int totalWifiUsageMBs;

    public AggregatedUsage(int totalScreenUsageMins, int totalMobileUsageMBs, int totalWifiUsageMBs) {
        this.totalScreenUsageMins = totalScreenUsageMins;
        this.totalMobileUsageMBs = totalMobileUsageMBs;
        this.totalWifiUsageMBs = totalWifiUsageMBs;
    }
}
