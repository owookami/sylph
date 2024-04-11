package com.vs.sylph.sylph;

import android.Manifest;
import android.content.ContentResolver;
import android.content.pm.PackageManager;
import android.net.Uri;

import androidx.annotation.NonNull;
import androidx.core.content.ContextCompat; // Make sure this line is added
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.Result;

import androidx.core.app.ActivityCompat;

public class MainActivity extends FlutterActivity {

    private static final String CHANNEL = "com.vs.sylph.sylph/callLog";
    private static final int REQUEST_CALL_LOG_PERMISSION = 1;

    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("deleteCallLogByNumber")) {
                                String phoneNumber = call.argument("phoneNumber");
                                try {
                                    if (ActivityCompat.checkSelfPermission(this, android.Manifest.permission.WRITE_CALL_LOG) == PackageManager.PERMISSION_GRANTED) {
                                        deleteCallLogByNumber(this, phoneNumber);
                                        result.success("Call log deleted successfully.");
                                    } else {
                                        // Permission not granted
                                        result.error("PERMISSION_DENIED", "WRITE_CALL_LOG permission not granted", null);
                                    }
                                } catch (Exception e) {
                                    // Handle any other exceptions
                                    result.error("ERROR_DELETING_CALL_LOG", "Failed to delete call log: " + e.getMessage(), null);
                                }
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }

    private boolean checkAndRequestPermissions() {
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.READ_CALL_LOG) != PackageManager.PERMISSION_GRANTED || ContextCompat.checkSelfPermission(this, Manifest.permission.WRITE_CALL_LOG) != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.READ_CALL_LOG, Manifest.permission.WRITE_CALL_LOG}, REQUEST_CALL_LOG_PERMISSION);
            return false;
        }
        return true;
    }

    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if (requestCode == REQUEST_CALL_LOG_PERMISSION) {
            if (grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                // Permissions granted, you can proceed with accessing and modifying the call log
            } else {
                // Permissions denied
            }
        }
    }

    public void deleteCallLogByNumber(MainActivity context, String phoneNumber) {
        try {
            ContentResolver resolver = context.getContentResolver();
            Uri uri = Uri.parse("content://call_log/calls");
            String selection = "number=?";

            String[] selectionArgs = new String[]{phoneNumber};

            if (ActivityCompat.checkSelfPermission(context, android.Manifest.permission.WRITE_CALL_LOG) == PackageManager.PERMISSION_GRANTED) {
                resolver.delete(uri, selection, selectionArgs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


}
