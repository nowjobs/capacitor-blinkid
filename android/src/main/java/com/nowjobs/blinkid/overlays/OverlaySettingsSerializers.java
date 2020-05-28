package com.nowjobs.blinkid.overlays;

import android.content.Context;

import com.microblink.entities.recognizers.RecognizerBundle;
import com.microblink.uisettings.UISettings;
import com.nowjobs.blinkid.overlays.serialization.BlinkIdOverlaySettingsSerialization;
import com.nowjobs.blinkid.overlays.serialization.DocumentOverlaySettingsSerialization;
import com.nowjobs.blinkid.overlays.serialization.DocumentVerificationOverlaySettingsSerialization;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;

public enum OverlaySettingsSerializers {
    INSTANCE;

    private HashMap<String, OverlaySettingsSerialization> mByJSONName = new HashMap<>();

    private void registerMapping(OverlaySettingsSerialization overlaySettingsSerialization) {
        mByJSONName.put(overlaySettingsSerialization.getJsonName(), overlaySettingsSerialization);
    }

    OverlaySettingsSerializers() {
        registerMapping(new DocumentOverlaySettingsSerialization());
        registerMapping(new DocumentVerificationOverlaySettingsSerialization());
        registerMapping(new BlinkIdOverlaySettingsSerialization());
    }

    public UISettings getOverlaySettings(Context context, JSONObject jsonOverlaySettings, RecognizerBundle recognizerBundle) {
        try {
            return mByJSONName.get(jsonOverlaySettings.getString("overlaySettingsType")).createUISettings(context, jsonOverlaySettings, recognizerBundle);
        } catch (JSONException e) {
            throw new RuntimeException(e);
        }
    }

    public UISettings getDefaultSettings(Context context, RecognizerBundle recognizerBundle) {
        return new BlinkIdOverlaySettingsSerialization().createUISettings(context, new JSONObject(), recognizerBundle);
    }

}