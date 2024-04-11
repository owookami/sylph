package com.vs.sylph.sylph;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

public class StopServiceReceiver extends BroadcastReceiver {
    @Override
    public void onReceive(Context context, Intent intent) {
        // Stop the service or perform any action
        Log.d("ServiceStopReceiver", "Received intent to stop the service");
        Intent serviceIntent = new Intent(context, CallMonitoringService.class);
        context.stopService(serviceIntent);
    }

}

