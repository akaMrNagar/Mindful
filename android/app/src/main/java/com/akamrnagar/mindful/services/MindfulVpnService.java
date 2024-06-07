package com.akamrnagar.mindful.services;

import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Binder;
import android.os.IBinder;
import android.os.ParcelFileDescriptor;
import android.util.Log;

import androidx.annotation.NonNull;

import com.akamrnagar.mindful.helpers.NotificationHelper;
import com.akamrnagar.mindful.utils.AppConstants;
import com.akamrnagar.mindful.utils.Utils;

import org.jetbrains.annotations.Contract;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.net.SocketAddress;
import java.net.SocketException;
import java.nio.channels.DatagramChannel;
import java.util.Set;
import java.util.concurrent.atomic.AtomicReference;


public class MindfulVpnService extends android.net.VpnService {

    public static final String ACTION_START_SERVICE = "com.akamrnagar.mindful.VpnService.START";
    public static final String ACTION_STOP_SERVICE = "com.akamrnagar.mindful.VpnService.STOP";
    public static final int SERVICE_ID = 302;
    private static final int SERVER_PORT = 3030;
    private static final String SERVER_ADDRESS = "192.168.2.2";
    private static final String ROUTE_ADDRESS = "0.0.0.0";
    private static final String TAG = "com.akamrnagar.mindful.VpnService";
    private final AtomicReference<Thread> mVpnThread = new AtomicReference<>();
    private ParcelFileDescriptor mVpnInterface = null;
    private Set<String> mBlockedApps;
    private boolean mNeedDataReload = false;

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        if (intent != null && ACTION_START_SERVICE.equals(intent.getAction())) {
            connectVpn();
            return START_STICKY;
        } else {
            disconnectVpn();
            stopSelf();
            return START_NOT_STICKY;
        }
    }

    private void connectVpn() {
        String jsonString = getSharedPreferences(AppConstants.PREFS_SHARED_BOX, Context.MODE_PRIVATE)
                .getString(AppConstants.PREF_KEY_BLOCKED_APPS, "");
        mBlockedApps = Utils.jsonStrToStringHashSet(jsonString);

        // Check if no blocked apps then STOP service
        // Necessary if the service starts from Boot Receiver
        if (mBlockedApps.isEmpty()) {
            Log.w(TAG, "connectVpn: Tried to Connect Vpn without any blocked apps, Exiting");
            stopSelf();
            return;
        }


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
            Log.d(TAG, "disconnectVpn: VPN connection is closed successfully");
        } catch (IOException e) {
            Log.e(TAG, "disconnectVpn: Unable to close VPN connection", e);
        }
    }

    @NonNull
    @Contract(" -> new")
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


                    for (String packageName : mBlockedApps) {
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


    private void restartVpn() {
        disconnectVpn();
        connectVpn();
        Log.d(TAG, "refreshVpnApps: Vpn restarted with refreshed apps");
    }

    public void flagNeedDataReload() {
        mNeedDataReload = true;
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        disconnectVpn();
        Log.d(TAG, "onDestroy: Vpn service is destroyed");
    }

    public void onApplicationStop() {
        if (mNeedDataReload) {
            restartVpn();
            mNeedDataReload = false;
        }
    }

    @Override
    public IBinder onBind(Intent intent) {
        return new VpnServiceBinder();
    }

    public class VpnServiceBinder extends Binder {
        public MindfulVpnService getService() {
            return MindfulVpnService.this;
        }
    }
}