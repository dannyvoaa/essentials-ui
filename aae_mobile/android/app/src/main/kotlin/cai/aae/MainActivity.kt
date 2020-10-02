package cai.aae

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import com.google.firebase.analytics.FirebaseAnalytics
import com.google.firebase.crashlytics.FirebaseCrashlytics

class MainActivity : FlutterActivity() {

    // firebase Analytics
    private lateinit var firebaseAnalytics: FirebaseAnalytics

    private val CHANNEL = "aae.cai/channel"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
        FirebaseCrashlytics.getInstance().setCrashlyticsCollectionEnabled(true)

    }
}
