package com.nowjobs.blinkid.recognizers;

import com.getcapacitor.JSArray;
import com.microblink.entities.recognizers.Recognizer;
import com.microblink.entities.recognizers.RecognizerBundle;
import com.nowjobs.blinkid.recognizers.serialization.BlinkIdCombinedRecognizerSerialization;
import com.nowjobs.blinkid.recognizers.serialization.BlinkIdRecognizerSerialization;
import com.nowjobs.blinkid.recognizers.serialization.DocumentFaceRecognizerSerialization;
import com.nowjobs.blinkid.recognizers.serialization.IdBarcodeRecognizerSerialization;
import com.nowjobs.blinkid.recognizers.serialization.MrtdCombinedRecognizerSerialization;
import com.nowjobs.blinkid.recognizers.serialization.MrtdRecognizerSerialization;
import com.nowjobs.blinkid.recognizers.serialization.PassportRecognizerSerialization;
import com.nowjobs.blinkid.recognizers.serialization.SuccessFrameGrabberRecognizerSerialization;
import com.nowjobs.blinkid.recognizers.serialization.UsdlCombinedRecognizerSerialization;
import com.nowjobs.blinkid.recognizers.serialization.UsdlRecognizerSerialization;
import com.nowjobs.blinkid.recognizers.serialization.VisaRecognizerSerialization;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;

public enum RecognizerSerializers {
    INSTANCE;

    private HashMap<String, RecognizerSerialization> mByJSONName = new HashMap<>();
    private HashMap<Integer, RecognizerSerialization> mByJSONDocumentId = new HashMap<>();
    private HashMap<Class<?>, RecognizerSerialization> mByClass = new HashMap<>();

    private void registerMapping( RecognizerSerialization recognizerSerialization ) {
        mByJSONName.put(recognizerSerialization.getJsonName(), recognizerSerialization);
        mByJSONDocumentId.put(recognizerSerialization.getDocumentId(), recognizerSerialization);
        mByClass.put(recognizerSerialization.getRecognizerClass(), recognizerSerialization);
    }

    RecognizerSerializers() {
        registerMapping(new SuccessFrameGrabberRecognizerSerialization());
        registerMapping(new BlinkIdCombinedRecognizerSerialization());
        registerMapping(new BlinkIdRecognizerSerialization());
        registerMapping(new DocumentFaceRecognizerSerialization());
        registerMapping(new IdBarcodeRecognizerSerialization());
        registerMapping(new MrtdCombinedRecognizerSerialization());
        registerMapping(new MrtdRecognizerSerialization());
        registerMapping(new PassportRecognizerSerialization());
        registerMapping(new VisaRecognizerSerialization());
        registerMapping(new UsdlRecognizerSerialization());
        registerMapping(new UsdlCombinedRecognizerSerialization());
        
    }

    public RecognizerSerialization getRecognizerSerialization(JSONObject jsonRecognizer) throws JSONException {
        return mByJSONName.get(jsonRecognizer.getString("recognizerType"));
    }

    public RecognizerSerialization getRecognizerSerializationFromDocument(JSONObject jsonRecognizer) throws JSONException {
        return mByJSONDocumentId.get(jsonRecognizer.getInt("document"));
    }

    public RecognizerSerialization getRecognizerSerialization(Recognizer<?> recognizer) {
        return mByClass.get(recognizer.getClass());
    }

    public RecognizerBundle deserializeRecognizerCollection(JSONObject jsonRecognizerCollection) {
        try {
            JSONArray recognizerArray = jsonRecognizerCollection.getJSONArray("recognizerArray");
            int numRecognizers = recognizerArray.length();
            Recognizer<?>[] recognizers = new Recognizer[numRecognizers];
            for (int i = 0; i < numRecognizers; ++i) {
                recognizers[ i ] = getRecognizerSerialization(recognizerArray.getJSONObject(i)).createRecognizer(recognizerArray.getJSONObject(i));
            }
            RecognizerBundle recognizerBundle = new RecognizerBundle(recognizers);
            recognizerBundle.setAllowMultipleScanResultsOnSingleImage(jsonRecognizerCollection.optBoolean("allowMultipleResults", false));
            recognizerBundle.setNumMsBeforeTimeout(jsonRecognizerCollection.optInt("milisecondsBeforeTimeout", 10000));

            return recognizerBundle;
        } catch (JSONException e) {
            throw new RuntimeException(e);
        }
    }

    public RecognizerBundle deserializeRecognizerCollectionArray(JSArray jsonRecognizerCollection) {
        try {
            int numRecognizers = jsonRecognizerCollection.length();
            Recognizer<?>[] recognizers = new Recognizer[numRecognizers];
            for (int i = 0; i < numRecognizers; ++i) {
                recognizers[ i ] = getRecognizerSerializationFromDocument(jsonRecognizerCollection.getJSONObject(i)).createRecognizer(jsonRecognizerCollection.getJSONObject(i));
            }
            RecognizerBundle recognizerBundle = new RecognizerBundle(recognizers);
            //recognizerBundle.setAllowMultipleScanResultsOnSingleImage(jsonRecognizerCollection.optBoolean("allowMultipleResults", false));
            //recognizerBundle.setNumMsBeforeTimeout(jsonRecognizerCollection.optInt("milisecondsBeforeTimeout", 10000));

            return recognizerBundle;
        } catch (JSONException e) {
            throw new RuntimeException(e);
        }
    }

    public JSONArray serializeRecognizerResults(Recognizer<?>[] recognizers) {
        JSONArray jsonArray = new JSONArray();

        for (Recognizer<?> recognizer : recognizers) {
            jsonArray.put(getRecognizerSerialization(recognizer).serializeResult(recognizer));
        }

        return jsonArray;
    }

}