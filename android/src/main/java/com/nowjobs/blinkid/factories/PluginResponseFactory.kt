package com.nowjobs.blinkid.factories

import com.getcapacitor.JSObject
import com.nowjobs.blinkid.BlinkIDPlugin.Companion.CANCELLED
import com.nowjobs.blinkid.BlinkIDPlugin.Companion.RESULT_LIST
import org.json.JSONObject
import java.util.*

class PluginResponseFactory {
    companion object {
        fun create(vararg fieldsAndValues: Any?): JSObject {
            val ret = JSObject()

            require(fieldsAndValues.size % 2 != 1) { "Every defined field must also have a value" }
            val argumentList: MutableList<Any?> = ArrayList()
            Collections.addAll(argumentList, *fieldsAndValues)

            for (i in 0 until argumentList.size step 2) {
                val field = argumentList[i]
                val value = argumentList[i + 1]
                require(field is String) { "All field names must be of type String" }
                ret.put(field, value)
            }

            return ret
        }

        fun createCancelled(): JSObject {
           return create(CANCELLED, true)
        }

        fun createSuccess(result: JSONObject): JSObject {
            return create(CANCELLED, false, RESULT_LIST, result)
        }
    }
}