package com.akamrnagar.mindful.helpers;

import android.util.Log;
import android.view.accessibility.AccessibilityNodeInfo;


// TODO: Remove this class if not needed
public class TestHelper {

    private static final String TAG = "Mindful.Test";

    public static void logNodeInfoRecursively(AccessibilityNodeInfo parentNode) {
        logNode(parentNode, 0);

        for (int i = 0; i < parentNode.getChildCount(); i++) {

            AccessibilityNodeInfo childNode = parentNode.getChild(i);
            logNode(childNode, 1);
            if (childNode == null) continue;

            for (int j = 0; j < childNode.getChildCount(); j++) {
                AccessibilityNodeInfo nthChildNode = childNode.getChild(j);
                logNode(nthChildNode, 2);
                if (nthChildNode == null) continue;

                for (int k = 0; k < nthChildNode.getChildCount(); k++) {
                    AccessibilityNodeInfo leafNode = nthChildNode.getChild(k);
                    logNode(leafNode, 3);
                }
            }
        }
    }


    private static void logNode(AccessibilityNodeInfo node, int level) {
        if (node != null) {
            Log.d(TAG, "Level: " + level + " Class: " + node.getClassName() + " Id: " + node.getViewIdResourceName() + " Text: " + node.getText());
        }
    }
}
