package com.akamrnagar.mindful.services;

import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.ParcelFileDescriptor;
import android.util.Log;

import com.akamrnagar.mindful.helpers.NotificationHelper;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.net.SocketAddress;
import java.net.SocketException;
import java.nio.channels.DatagramChannel;
import java.util.HashSet;
import java.util.Set;
import java.util.concurrent.atomic.AtomicReference;


public class MindfulVpnService extends android.net.VpnService {

    public static final String ACTION_START_SERVICE = "com.akamrnagar.mindful.VpnService.START";
    public static final String ACTION_STOP_SERVICE = "com.akamrnagar.mindful.VpnService.STOP";
    public static final int SERVICE_ID = 302;
    private static final int SERVER_PORT = 3030;
//    private static final String SERVER_ADDRESS = "192.168.2.2";
    private static final String SERVER_ADDRESS = "127.0.0.1";
    private static final String DNS_ADDRESS = "192.168.1.1";
    private static final String ROUTE_ADDRESS = "0.0.0.0";
    private static final String TAG = "com.akamrnagar.mindful.VpnService";
    private final AtomicReference<Thread> mVpnThread = new AtomicReference<>();
    private ParcelFileDescriptor mVpnInterface = null;
    private Set<String> mPackages;

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        if (intent != null && ACTION_START_SERVICE.equals(intent.getAction())) {
            connectVpn();
            return START_STICKY;
        } else {
            disconnectVpn();
            return START_NOT_STICKY;
        }
    }

    @Override
    public void onDestroy() {
        disconnectVpn();
    }

    private void connectVpn() {
        mPackages = new HashSet<>();
        mPackages.add("com.instagram.android");
        mPackages.add("app.rvx.android.youtube");


        final Thread newThread = new Thread(getVpnRunnable(), TAG);
        setVpnThread(newThread);
        newThread.start();
        startForeground(SERVICE_ID, NotificationHelper.createTrackingNotification(getApplicationContext()));
    }

    private void disconnectVpn() {
        try {
            if (mVpnInterface != null) {
                mVpnInterface.close();
            }
            setVpnThread(null);
            stopForeground(true);
            stopSelf();
            Log.d(TAG, "disconnectVpn: VPN connection is closed successfully");
        } catch (IOException e) {
            Log.e(TAG, "disconnectVpn: Unable to close VPN connection", e);
        }
    }

    private Runnable getVpnRunnable() {
        return new Runnable() {
            @Override
            public void run() {
                final SocketAddress serverAddress = new InetSocketAddress(SERVER_ADDRESS, SERVER_PORT);

                try (DatagramChannel tunnel = DatagramChannel.open()) {

                    if (!MindfulVpnService.this.protect(tunnel.socket())) {
                        throw new IllegalStateException("Cannot protect the vpn socket tunnel");
                    }

                    tunnel.connect(serverAddress);
                    tunnel.configureBlocking(false);

                    android.net.VpnService.Builder builder = MindfulVpnService.this.new Builder();
                    builder.addAddress(SERVER_ADDRESS, 24);
                    builder.addRoute(ROUTE_ADDRESS, 0);
                    builder.addDnsServer(DNS_ADDRESS);


                    for (String packageName : mPackages) {
                        try {
                            builder.addAllowedApplication(packageName);
                        } catch (PackageManager.NameNotFoundException e) {
                            Log.e(TAG, "getVpnRunnable: Cannot find app with package " + packageName, e);
                        }
                    }

                    synchronized (MindfulVpnService.this) {
                        mVpnInterface = builder.establish();
                        Log.d(TAG, "getVpnRunnable: VPN connected successfully");
                    }

                    // start foreground service and create notification
//                    startForeground(SERVICE_ID, NotificationHelper.createTrackingNotification(getApplicationContext()));

//                    while (true) {
//                        /// created this loop to make sure that vpn service does not stop accidentally.
//                        Thread.sleep(1000);
//                    }


                } catch (SocketException e) {
                    Log.e(TAG, "run: Cannot use socket for VPN", e);
                } catch (IOException | IllegalArgumentException e) {
                    Log.e(TAG, "run: VPN connection failed, exiting", e);
                }
            }
        };
    }


    private void setVpnThread(final Thread thread) {
        final Thread oldThread = mVpnThread.getAndSet(thread);
        if (oldThread != null) {
            oldThread.interrupt();
        }
    }
}