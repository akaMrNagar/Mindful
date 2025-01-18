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
package com.mindful.android.services.vpn

import android.content.Intent
import android.content.pm.PackageManager
import android.net.VpnService
import android.os.IBinder
import android.os.ParcelFileDescriptor
import android.util.Log
import com.mindful.android.R
import com.mindful.android.generics.ServiceBinder
import com.mindful.android.helpers.device.NotificationHelper
import com.mindful.android.helpers.storage.SharedPrefsHelper
import com.mindful.android.utils.AppConstants
import java.io.IOException
import java.net.InetSocketAddress
import java.net.SocketAddress
import java.net.SocketException
import java.nio.channels.DatagramChannel
import java.util.concurrent.atomic.AtomicReference


/**
 * A VPN service that manages internet access by blocking specified apps.
 */
class MindfulVpnService : VpnService() {
    companion object {
        private const val TAG = "Mindful.VpnService"
    }

    private val mBinder = ServiceBinder(this@MindfulVpnService)
    private val mAtomicVpnThread = AtomicReference<Thread?>(null)
    private var mBlockedApps: Set<String> = HashSet(0)
    private var mVpnInterface: ParcelFileDescriptor? = null
    private var mIsServiceRunning = false

    override fun onStartCommand(intent: Intent, flags: Int, startId: Int): Int {

        if (intent.action == ServiceBinder.ACTION_START_MINDFUL_SERVICE) {
            startFgService()
            return START_STICKY
        }

        stopAndDisposeService()
        return START_NOT_STICKY
    }


    private fun startFgService() {
        if (mIsServiceRunning) return
        try {
            startForeground(
                AppConstants.VPN_SERVICE_NOTIFICATION_ID,
                NotificationHelper.buildFgServiceNotification(
                    this,
                    getString(R.string.internet_blocker_running_notification_info)
                )
            )
            mIsServiceRunning = true
            Log.d(TAG, "startFgService: VPN service started successfully")
        } catch (e: Exception) {
            Log.e(TAG, "startFgService: Failed to start VPN service", e)
            SharedPrefsHelper.insertCrashLogToPrefs(this, e)
            stopAndDisposeService()
        }
    }

    /**
     * Restarts the VPN connection by disconnecting and then reconnecting the VPN.
     */
    private fun reconnectVpn() {
        disconnectVpn()
        connectVpn()
        Log.d(TAG, "reconnectVpn: VPN reconnected successfully")
    }

    /**
     * Establishes a VPN connection based on blocked apps.
     * If there are no blocked apps, the service will stop itself.
     */
    private fun connectVpn() {
        // Check if no blocked apps then STOP service
        // Necessary if the service starts from Boot Receiver
        if (mBlockedApps.isEmpty()) {
            Log.w(TAG, "connectVpn: Tried to Connect Vpn without any blocked apps, Exiting")
            stopAndDisposeService()
            return
        }

        val newThread = Thread(vpnThread, TAG)
        setVpnThread(newThread)
        newThread.start()
    }

    /**
     * Disconnects the VPN connection if established.
     */
    private fun disconnectVpn() {
        try {
            if (mVpnInterface != null) {
                mVpnInterface!!.close()
                setVpnThread(null)
                Log.d(TAG, "disconnectVpn: VPN disconnected successfully")
            }
        } catch (e: IOException) {
            Log.e(TAG, "disconnectVpn: Failed to disconnect VPN", e)
        }
    }

    /**
     * Stops the foreground service and disconnects the VPN.
     */
    private fun stopAndDisposeService() {
        disconnectVpn()
        stopSelf()
    }

    /**
     * Returns a Runnable that configures and establishes the VPN connection.
     *
     * @return A Runnable that sets up the VPN connection.
     */
    private val vpnThread: Runnable
        get() = Runnable {
            try {
                DatagramChannel.open().use { tunnel ->
                    check(this@MindfulVpnService.protect(tunnel.socket())) { "Cannot protect the vpn socket tunnel" }
                    val serverAddress: SocketAddress = InetSocketAddress("localhost", 0)
                    tunnel.connect(serverAddress)
                    tunnel.configureBlocking(false)

                    val builder = this@MindfulVpnService.Builder()
                    builder.addAddress("192.168.0.0", 24)
                    builder.addRoute("0.0.0.0", 0)

                    // Add blocked app's packages
                    for (packageName in mBlockedApps) {
                        try {
                            builder.addAllowedApplication(packageName)
                        } catch (e: PackageManager.NameNotFoundException) {
                            Log.w(TAG, "getVpnThread: Cannot find app with package $packageName")
                        }
                    }
                    synchronized(this@MindfulVpnService) {
                        mVpnInterface = builder.establish()
                        Log.d(TAG, "getVpnThread: VPN connected successfully")
                    }
                }
            } catch (e: SocketException) {
                Log.e(TAG, "getVpnThread: Cannot use socket for VPN", e)
                SharedPrefsHelper.insertCrashLogToPrefs(this@MindfulVpnService, e)
                stopAndDisposeService()
            } catch (e: IOException) {
                Log.e(TAG, "getVpnThread: VPN connection failed, exiting", e)
                SharedPrefsHelper.insertCrashLogToPrefs(this@MindfulVpnService, e)
                stopAndDisposeService()
            } catch (e: IllegalArgumentException) {
                Log.e(TAG, "getVpnThread: VPN connection failed, exiting", e)
                SharedPrefsHelper.insertCrashLogToPrefs(this@MindfulVpnService, e)
                stopAndDisposeService()
            } catch (e: Exception) {
                Log.e(TAG, "getVpnThread: Something went wrong", e)
                SharedPrefsHelper.insertCrashLogToPrefs(this@MindfulVpnService, e)
                stopAndDisposeService()
            }
        }

    /**
     * Sets the current VPN thread, interrupting the previous thread if necessary.
     *
     * @param thread The new thread to be set.
     */
    private fun setVpnThread(thread: Thread?) {
        val oldThread = mAtomicVpnThread.getAndSet(thread)
        oldThread?.interrupt()
    }

    /**
     * Updates the list of blocked apps and restarts the VPN service if needed.
     */
    fun updateBlockedApps(blockedApps: HashSet<String>) {
        mBlockedApps = blockedApps
        Log.d(TAG, "updateBlockedApps: Internet blocked apps updated successfully")
        if (mBlockedApps.isEmpty()) stopAndDisposeService()
        else reconnectVpn()
    }

    override fun onDestroy() {
        super.onDestroy()
        disconnectVpn()
        stopForeground(STOP_FOREGROUND_REMOVE)
        Log.d(TAG, "onDestroy: VPN service destroyed successfully")
    }

    override fun onBind(intent: Intent): IBinder? {
        return if (intent.action == ServiceBinder.ACTION_BIND_TO_MINDFUL) mBinder else null
    }
}
