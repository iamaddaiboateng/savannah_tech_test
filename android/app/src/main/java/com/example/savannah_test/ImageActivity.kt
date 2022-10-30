package com.example.savannah_test

import android.annotation.SuppressLint
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.TextView


class ImageActivity : AppCompatActivity() {
    @SuppressLint("SetTextI18n")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_image)

        val ss: String = intent.getStringExtra("kotlinCount").toString();
        val flutterCounter = intent.getStringExtra("flutterCount").toString()
        val mainPageCounter = intent.getStringExtra("mainPageCount").toString()

//        get kotlin text view and assign the value to it
        val textView: TextView = findViewById(R.id.kotlinActivityCount)
        textView.text = "Opened $ss time(s)"

//      get flutter count text view and assign value to it

        val flutterCounterView: TextView = findViewById(R.id.flutterOpened)
        flutterCounterView.text = "Opened $flutterCounter time(s)"

        val mainPageCountView: TextView = findViewById(R.id.mainPageCount)
        mainPageCountView.text = "Opened $mainPageCounter time(s)"

    }
}