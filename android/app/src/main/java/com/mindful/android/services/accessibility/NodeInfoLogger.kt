package com.mindful.android.services.accessibility

import android.util.Log
import android.view.accessibility.AccessibilityNodeInfo

object NodeInfoLogger {
    /**
     * Recursively logs information about the accessibility node and its children.
     * This method traverses the accessibility node tree starting from the given parent node,
     * logging the class name, view ID, and text content of each node.
     *
     *
     * Note: This method does not provide any functional capabilities but is helpful
     * for debugging and testing purposes.
     *
     * @param parentNode The root node from which to start logging. This should be the
     * top-level accessibility node to explore its hierarchy.
     */
    private fun logNodeInfoRecursively(parentNode: AccessibilityNodeInfo, level: Int) {
        var currentLevel = level
        logNode(parentNode, currentLevel)
        currentLevel++

        for (i in 0 until parentNode.childCount) {
            parentNode.getChild(i)?.let {
                logNode(it, currentLevel)
                logNodeInfoRecursively(it, currentLevel)
            }
        }
    }

    /**
     * Logs information about a specific accessibility node.
     * This method outputs the class name, view ID, and text content of the given node
     * at the specified hierarchical level.
     *
     *
     * Note: This method does not provide any functional capabilities but is helpful
     * for debugging and testing purposes.
     *
     * @param node  The accessibility node to log. This can be any node in the hierarchy.
     * @param level The hierarchical level of the node in the tree, where 0 represents
     * the root node and higher values indicate deeper levels in the hierarchy.
     */
    private fun logNode(node: AccessibilityNodeInfo?, level: Int) {
        node?.let {
            Log.d(
                "Mindful.NodeInfoLogger",
                "Level: $level Class: ${it.className} Id: ${it.viewIdResourceName} Text: ${it.text}"
            )
        }
    }
}