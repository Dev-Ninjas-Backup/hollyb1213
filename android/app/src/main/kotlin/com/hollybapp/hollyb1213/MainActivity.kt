package com.hollybdev.readytowork

import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Intent
import android.net.Uri
import android.Manifest
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import android.content.pm.PackageManager

class MainActivity: FlutterFragmentActivity() {
    private val CHANNEL = "com.hollybdev.readytowork/call"
    private val PERMISSION_REQUEST_CODE = 100
    private var pendingPhoneNumber: String? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "makeCall" -> {
                        val phoneNumber = call.argument<String>("phoneNumber")
                        if (phoneNumber != null) {
                            try {
                                // Check if permission is already granted
                                if (ContextCompat.checkSelfPermission(
                                        this,
                                        Manifest.permission.CALL_PHONE
                                    ) == PackageManager.PERMISSION_GRANTED
                                ) {
                                    initiateCall(phoneNumber)
                                    result.success(null)
                                } else {
                                    // Permission not granted, request it
                                    pendingPhoneNumber = phoneNumber
                                    ActivityCompat.requestPermissions(
                                        this,
                                        arrayOf(Manifest.permission.CALL_PHONE),
                                        PERMISSION_REQUEST_CODE
                                    )
                                    result.success(null)
                                }
                            } catch (e: Exception) {
                                result.error("CALL_ERROR", e.message, null)
                            }
                        } else {
                            result.error("INVALID_ARGS", "Phone number is null", null)
                        }
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun initiateCall(phoneNumber: String) {
        val intent = Intent(Intent.ACTION_CALL).apply {
            data = Uri.parse("tel:$phoneNumber")
        }
        startActivity(intent)
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        
        if (requestCode == PERMISSION_REQUEST_CODE) {
            if (grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                // Permission granted, make the call
                if (pendingPhoneNumber != null) {
                    initiateCall(pendingPhoneNumber!!)
                    pendingPhoneNumber = null
                }
            }
        }
    }
}