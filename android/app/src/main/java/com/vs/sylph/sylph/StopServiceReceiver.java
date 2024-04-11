package com.vs.sylph.sylph;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

public class StopServiceReceiver extends BroadcastReceiver {
    @Override
    public void onReceive(Context context, Intent intent) {
        // Stop the service or perform any action
        Intent serviceIntent = new Intent(context, CallMonitoringService.class);
        context.stopService(serviceIntent);
    }
}

