package com.example.edu360

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        // Register the eSewa plugin
        EsewaFlutterSdk.registerWith(flutterEngine.plugins)
    }
}
