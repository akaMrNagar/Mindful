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

import androidx.annotation.NonNull;

import org.json.JSONObject;

import java.util.HashSet;

public class RestrictionGroup {
    public String groupName;
    public int timerSec;
    public HashSet<String> appsPackage;


    public RestrictionGroup(@NonNull JSONObject jsonObject)
    {}
}
