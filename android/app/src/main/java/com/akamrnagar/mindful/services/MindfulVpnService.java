package com.akamrnagar.mindful.services;

import static com.akamrnagar.mindful.generics.ServiceBinder.ACTION_START_SERVICE;
import static com.akamrnagar.mindful.generics.ServiceBinder.ACTION_STOP_SERVICE;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.os.IBinder;
import android.os.ParcelFileDescriptor;
import android.util.Log;

import androidx.annotation.NonNull;

import com.akamrnagar.mindful.generics.ServiceBinder;
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
    public static final int SERVICE_ID = 302;
    private static final String TAG = "com.akamrnagar.mindful.VpnService";
    private final AtomicReference<Thread> mVpnThread = new AtomicReference<>();
    private ParcelFileDescriptor mVpnInterface = null;
    private Set<String> mBlockedApps;

    private boolean mShouldRestartVpn = false;

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        if (intent == null) return START_NOT_STICKY;
        String action = intent.getAction();

        if (ACTION_START_SERVICE.equals(action)) {
            connectVpn();
            return START_STICKY;
        } else if (ACTION_STOP_SERVICE.equals(action)) {
            stopAndDisposeService();
        }

        return START_NOT_STICKY;
    }

    private void restartVpnService() {
        disconnectVpn();
        connectVpn();
        Log.d(TAG, "restartVpnService: Vpn restarted successfully");
    }

    private void connectVpn() {
        SharedPreferences sharedPrefs = getSharedPreferences(AppConstants.PREFS_SHARED_BOX, Context.MODE_PRIVATE);
        String jsonString = sharedPrefs.getString(AppConstants.PREF_KEY_BLOCKED_APPS, "");
        mBlockedApps = Utils.jsonStrToStringHashSet(jsonString);

        // Check if no blocked apps then STOP service
        // Necessary if the service starts from Boot Receiver
        if (mBlockedApps.isEmpty()) {
            Log.w(TAG, "connectVpn: Tried to Connect Vpn without any blocked apps, Exiting");
            stopAndDisposeService();
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
            Log.d(TAG, "disconnectVpn: VPN connection is closed successfully");
            setVpnThread(null);
        } catch (IOException e) {
            Log.e(TAG, "disconnectVpn: Unable to close VPN connection", e);
        }
    }

    private void stopAndDisposeService() {
        disconnectVpn();
        stopForeground(true);
        stopSelf();
    }

    @NonNull
    @Contract(" -> new")
    private Runnable getVpnRunnable() {
        return new Runnable() {
            @Override
            public void run() {
                try (DatagramChannel tunnel = DatagramChannel.open()) {

                    if (!MindfulVpnService.this.protect(tunnel.socket())) {
                        throw new IllegalStateException("Cannot protect the vpn socket tunnel");
                    }

                    final SocketAddress serverAddress = new InetSocketAddress("localhost", 0);
                    tunnel.connect(serverAddress);
                    tunnel.configureBlocking(false);

                    android.net.VpnService.Builder builder = MindfulVpnService.this.new Builder();
                    builder.addAddress("192.168.0.0", 24);
                    builder.addRoute("0.0.0.0", 0);

                    // Add blocked app's packages
                    for (String packageName : mBlockedApps) {
                        try {
                            builder.addAllowedApplication(packageName);
                        } catch (PackageManager.NameNotFoundException e) {
                            Log.w(TAG, "getVpnRunnable: Cannot find app with package " + packageName);
                        }
                    }

                    synchronized (MindfulVpnService.this) {
                        mVpnInterface = builder.establish();
                        Log.d(TAG, "getVpnRunnable: VPN connected successfully");
                    }


                } catch (SocketException e) {
                    Log.e(TAG, "run: Cannot use socket for VPN", e);
                    stopAndDisposeService();
                } catch (IOException | IllegalArgumentException e) {
                    Log.e(TAG, "run: VPN connection failed, exiting", e);
                    stopAndDisposeService();
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


    public void flagVpnServiceRestart() {
        mShouldRestartVpn = true;
    }

    public void onApplicationStop() {
        if (mShouldRestartVpn) {
            restartVpnService();
            mShouldRestartVpn = false;
        }
    }


    @Override
    public void onDestroy() {
        super.onDestroy();
        disconnectVpn();
        Log.d(TAG, "onDestroy: Vpn service is destroyed");
    }

    @Override
    public IBinder onBind(Intent intent) {
        return new ServiceBinder<MindfulVpnService>(MindfulVpnService.this);
    }

}