package com.nowjobs.blinkid

import android.app.Activity
import android.content.Intent
import android.util.Log
import com.getcapacitor.*
import com.microblink.MicroblinkSDK
import com.microblink.entities.recognizers.Recognizer
import com.microblink.entities.recognizers.RecognizerBundle
import com.microblink.intent.IntentDataTransferMode
import com.microblink.recognition.InvalidLicenceKeyException
import com.microblink.uisettings.UISettings
import com.nowjobs.blinkid.extensions.guard
import com.nowjobs.blinkid.factories.PluginResponseFactory.Companion.create
import com.nowjobs.blinkid.factories.PluginResponseFactory.Companion.createCancelled
import com.nowjobs.blinkid.factories.PluginResponseFactory.Companion.createSuccess
import com.nowjobs.blinkid.mock.MockData
import com.nowjobs.blinkid.overlays.OverlaySettingsSerializers
import com.nowjobs.blinkid.recognizers.RecognizerSerializers
import com.nowjobs.blinkid.utils.DeviceUtil
import org.json.JSONArray
import org.json.JSONException
import org.json.JSONObject

@NativePlugin(
        requestCodes= [1337]
)
class BlinkIDPlugin : Plugin() {
    private val TAG = "BlinkIDPlugin"
    private var licenseKey = ""

    @PluginMethod
    fun setLicenseKey(call: PluginCall) {
        licenseKey = call.getString("key")
        try {
            MicroblinkSDK.setLicenseKey(licenseKey, context)
        } catch (ex: InvalidLicenceKeyException) {
            Log.d(TAG, "Invalid BlinkID license key: ${ex.message}")
            call.reject("Please provide a license key")
            return
        } catch (ex: Exception) {
            Log.d(TAG, "Exception: " + ex.message)
            call.reject("Unexpected license key error: ${ex.message}")
            return
        }
        MicroblinkSDK.setIntentDataTransferMode(IntentDataTransferMode.PERSISTED_OPTIMISED)
        call.success(create("data", "This is the received license key $licenseKey \uD83D\uDD11"))
    }
    @PluginMethod
    fun startScanning(call: PluginCall) {
        if(licenseKey.isNullOrEmpty()) {
            Log.d(TAG, "No license key - please call `setLicenseKey` first")
            call.reject("No license key - please call `setLicenseKey` first")
            return
        }
        val recognizersData = call.getArray("recognizers").guard {
            Log.d(TAG, "Please provide a list of recognizers")
            call.reject("Please provide a list of recognizers")
            return
        }

        if (DeviceUtil.isEmulator) {
            MockData.start(context, call)
            return
        }

        mCallbackContext = call

        try {
            mRecognizerBundle = RecognizerSerializers.INSTANCE.deserializeRecognizerCollectionArray(recognizersData)
            val overlaySettings: UISettings<*> = OverlaySettingsSerializers.INSTANCE.getDefaultSettings(this.context, mRecognizerBundle)
            val intent = Intent(this.context, overlaySettings.targetActivity)
            overlaySettings.saveToIntent(intent)
            this.startActivityForResult(call, intent, REQUEST_CODE)
        } catch (e: JSONException) {
            mCallbackContext?.error("JSON error: " + e.message)
        }
    }

    override fun handleOnActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if (requestCode == REQUEST_CODE) {
            val callbackContext = mCallbackContext.guard {
                mCallbackContext?.reject("Callback context is null")
                return
            }

            when (resultCode) {
                Activity.RESULT_OK -> {
                    val resultData = data.guard {
                        callbackContext.reject("BlinkID data is null")
                        return
                    }

                    val recognizerBundle = mRecognizerBundle.guard {
                        callbackContext.reject("Recognizer bundle is null")
                        return
                    }

                    recognizerBundle.loadFromIntent(resultData)
                    val result: JSObject
                    try {
                        val resultList: JSONArray = RecognizerSerializers.INSTANCE.serializeRecognizerResults(recognizerBundle.recognizers)
                        var validItem: JSONObject? = null
                        for (i in 0 until resultList.length()) {
                            val item = resultList.getJSONObject(i)
                            val state = item["resultState"]
                            if (state is Int && state == (Recognizer.Result.State.Valid.ordinal + 1)) {
                                validItem = item
                                break
                            }
                        }

                        val item = validItem.guard {
                            callbackContext.reject("Scanning failed: no valid result")
                            return
                        }

                        result = createSuccess(item)
                    } catch (e: JSONException) {
                        throw RuntimeException(e)
                    }

                    callbackContext.success(JSObject.fromJSONObject(result))
                }
                Activity.RESULT_CANCELED -> {
                    callbackContext.success(JSObject.fromJSONObject(createCancelled()))
                }
                else -> {
                    callbackContext.error("Unexpected error")
                }
            }
        }
    }

    companion object
    {
        val REQUEST_CODE: Int = 1337
        val CANCELLED = "cancelled"
        val RESULT_LIST = "data"
        var mCallbackContext: PluginCall? = null
        var mRecognizerBundle: RecognizerBundle? = null
    }
}