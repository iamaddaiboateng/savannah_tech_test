package com.example.savannah_test

import android.content.Intent
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlin.random.Random

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.startActivity/testChannel").setMethodCallHandler {
            call, result ->
            if(call.method.equals("StartSecondActivity")){
                val flutterCount = call.argument<String>("flutter")
                val kotlinCont = call.argument<String>("kotlin")
                val mainPageCount = call.argument<String>("mainPage")
                Log.d("flutter count", flutterCount.toString())
                Log.d("kotlin count", kotlinCont.toString())
                val intent= Intent(this,ImageActivity::class.java)
                intent.putExtra("flutterCount",flutterCount.toString())
                intent.putExtra("kotlinCount", kotlinCont.toString())
                intent.putExtra("mainPageCount", mainPageCount.toString())
                startActivity(intent)
                result.success("ActivityStarted")
            }
            else {
                result.notImplemented()
            }
        }
    }

}
