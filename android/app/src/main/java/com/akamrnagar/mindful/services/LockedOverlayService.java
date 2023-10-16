package com.akamrnagar.mindful.services;

import android.app.ActionBar;
import android.app.Service;
import android.content.Intent;
import android.graphics.PixelFormat;
import android.os.Build;
import android.os.IBinder;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.WindowManager;
import android.widget.Button;

import androidx.annotation.Nullable;

import com.akamrnagar.mindful.R;
import com.akamrnagar.mindful.utils.AppConstants;

public class LockedOverlayService extends Service {


    private int LAYOUT_FLAG;
    private View overlayView;
    private WindowManager windowManager;
    private boolean isOverlayVisible = false;

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        Log.e(AppConstants.LOG_TAG, "Overlay started");
        drawLockedOverlay();
        return START_STICKY;
    }

    private void drawLockedOverlay() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            LAYOUT_FLAG = WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY;
        } else {
            LAYOUT_FLAG = WindowManager.LayoutParams.TYPE_PHONE;
        }

        overlayView = LayoutInflater.from(this).inflate(R.layout.locked_overlay_view, null);
        WindowManager.LayoutParams layoutParams = new WindowManager.LayoutParams(WindowManager.LayoutParams.MATCH_PARENT,
                ActionBar.LayoutParams.MATCH_PARENT,
                LAYOUT_FLAG,
                WindowManager.LayoutParams.FLAG_BLUR_BEHIND,
                PixelFormat.TRANSLUCENT);

        Button closeButton = overlayView.findViewById(R.id.closeButton);
        closeButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (isOverlayVisible) {
//                    Intent intent = new Intent(getApplicationContext(), LockedOverlayService.class);
//                    getApplicationContext().stopService(intent);
                    stopSelf();
                }
            }
        });
        windowManager = (WindowManager) getSystemService(WINDOW_SERVICE);
        windowManager.addView(overlayView, layoutParams);
        overlayView.setVisibility(View.VISIBLE);
        isOverlayVisible = true;
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        if (isOverlayVisible) {
            overlayView.setVisibility(View.INVISIBLE);
            windowManager.removeView(overlayView);
            isOverlayVisible = false;
        }
    }
}