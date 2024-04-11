package com.vs.sylph.sylph;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.Service;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.Build;
import android.os.IBinder;
import android.telephony.PhoneStateListener;
import android.telephony.TelephonyManager;
import android.util.Log;
import androidx.core.app.ActivityCompat;

import androidx.annotation.Nullable;
import androidx.core.app.NotificationCompat;
import java.util.ArrayList;

public class CallMonitoringService extends Service {
    private TelephonyManager telephonyManager;
    private CallStateListener listener;
    private ArrayList<String> phoneNumbersToMonitor;

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        if (intent != null && intent.getStringArrayListExtra("phoneNumbers") != null) {
            phoneNumbersToMonitor = intent.getStringArrayListExtra("phoneNumbers");
        }

        startForegroundService();
        setupPhoneStateListener();

        return START_STICKY;
    }

    private void setupPhoneStateListener() {
        telephonyManager = (TelephonyManager) getSystemService(TELEPHONY_SERVICE);
        listener = new CallStateListener();
        telephonyManager.listen(listener, PhoneStateListener.LISTEN_CALL_STATE);
    }

    private void startForegroundService() {
        String CHANNEL_ID = "CallMonitoringServiceChannel";
        NotificationChannel channel = new NotificationChannel(CHANNEL_ID, "Call Monitoring Service", NotificationManager.IMPORTANCE_DEFAULT);
        getSystemService(NotificationManager.class).createNotificationChannel(channel);

        Notification notification = new NotificationCompat.Builder(this, CHANNEL_ID)
                .setContentTitle("Sylph")
                .setContentText("")
                .setSmallIcon(R.mipmap.ic_launcher) // Ensure you have a valid icon
                .build();

        startForeground(1, notification);
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        telephonyManager.listen(listener, PhoneStateListener.LISTEN_NONE);
    }

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    private class CallStateListener extends PhoneStateListener {
        @Override
        public void onCallStateChanged(int state, String incomingNumber) {
            super.onCallStateChanged(state, incomingNumber);
            if (state == TelephonyManager.CALL_STATE_IDLE) {
                // Call ended, check the call log and delete matches.
                new handler().postDelayed(() -> {
                    checkAndDeleteMatchingCallLogs();
                },3000);

            }
        }
    }

    private void checkAndDeleteMatchingCallLogs() {
        // Assuming deleteCallLogByNumber method is implemented here or in another helper class.
        for (String number : phoneNumbersToMonitor) {
            deleteCallLogByNumber(this, number);
        }
    }


    private void deleteCallLogByNumber(Context context, String phoneNumber) {
        // 통화 로그에 접근하기 위한 ContentResolver를 가져옵니다.
        ContentResolver resolver = context.getContentResolver();
        // 통화 로그 URI
        Uri callLogUri = Uri.parse("content://call_log/calls");
        // 삭제할 통화 로그의 조건을 지정합니다. 여기서는 전화번호가 일치하는 경우입니다.
        String selection = "number=?";
        String[] selectionArgs = new String[]{phoneNumber};

        try {
            // 통화 로그 쓰기 권한이 있는지 확인합니다.
            if (ActivityCompat.checkSelfPermission(context, android.Manifest.permission.WRITE_CALL_LOG) != PackageManager.PERMISSION_GRANTED) {
                // 권한이 없을 경우 적절히 로그를 남기거나 처리합니다.
                // 서비스 내부이기 때문에, 직접 권한을 요청할 수는 없습니다.
                // 권한은 서비스가 시작되기 전에 처리되어야 합니다.
                return;
            }
            // 조건에 맞는 통화 로그를 삭제하고 삭제된 행의 수를 반환합니다.
            int rowsDeleted = resolver.delete(callLogUri, selection, selectionArgs);
            if (rowsDeleted > 0) {
                // 삭제 성공 시, 선택적으로 성공을 로그로 남깁니다.
                Log.d("CallLogDeletion", "성공적으로 통화 로그를 삭제했습니다. 전화번호: " + phoneNumber);
            } else {
                // 실패하거나 일치하는 기록이 없을 경우, 선택적으로 로그를 남깁니다.
                Log.d("CallLogDeletion", "해당 전화번호에 맞는 통화 로그 기록을 찾을 수 없습니다: " + phoneNumber);
            }
        } catch (Exception e) {
            // 삭제 과정에서 발생할 수 있는 예외를 처리합니다.
            Log.e("CallLogDeletion", "통화 로그 삭제 중 오류 발생: ", e);
        }
    }

    // Implement deleteCallLogByNumber similar to your MainActivity method, adapted for use in the service.
}

