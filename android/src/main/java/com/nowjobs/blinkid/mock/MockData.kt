package com.nowjobs.blinkid.mock

import android.content.Context
import androidx.appcompat.app.AlertDialog
import com.getcapacitor.JSObject
import com.getcapacitor.PluginCall
import com.louisdebaere.demo.plugin.demo.R
import com.nowjobs.blinkid.factories.PluginResponseFactory.Companion.createCancelled
import com.nowjobs.blinkid.factories.PluginResponseFactory.Companion.createSuccess

class MockData {
    companion object {
        fun start(context: Context, call: PluginCall) {
            AlertDialog.Builder(context)
                    .setTitle("Scan")
                    .setMessage("What should be the result?")
                    .setPositiveButton("Fail") { dialog, _ ->
                        fail(call)
                        dialog.dismiss()
                    }
                    .setNegativeButton("User closed") { dialog, _ ->
                        close(call)
                        dialog.dismiss()
                    }
                    .setNeutralButton("Success") { dialog, _ ->
                        success(context, call)
                        dialog.dismiss()
                    }
                    .show()
        }

        private fun success(context: Context, call: PluginCall) {
            val json = context.resources.openRawResource(R.raw.passport).bufferedReader().use { it.readText() }
            call.success(createSuccess(JSObject(json)))
        }

        private fun fail(call: PluginCall) {
            call.reject("Scanning failed: no valid result")
        }

        private fun close(call: PluginCall) {
            call.success(JSObject.fromJSONObject(createCancelled()))
        }
    }
}