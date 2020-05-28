# Capacitor BlinkID
A Capacitor plugin for the native Microblink BlinkID SDK.

## Installation

```bash
$ npm i --save capacitor-blinkid
```

## Android configuration

In file `android/app/src/main/java/**/**/MainActivity.java`, add the plugin to the initialization list:

```java
import com.nowjobs.blinkid.BlinkIDPlugin;
[...]
this.init(savedInstanceState, new ArrayList<Class<? extends Plugin>>() {{
  [...]
  add(BlinkIDPlugin.class);
  [...]
}});
```

## iOS configuration

No configuration needed, works out-of-box.

## Usage

```js
import { Plugins } from "@capacitor/core";

const { BlinkIDPlugin } = Plugins;
```

### Set License Key

```js
BlinkIDPlugin.setLicenseKey({ key: license });
```

### Start Scanning

```js
BlinkIDPlugin.startScanning({ recognizers: [idRecognizer, passportRecognizer] })
  .then((scanResult) => {
    console.log('✅ Resolved with result', scanResult)
    resolve(scanResult);
  })
  .catch((err) => {
    console.log('❌ Error', err);
    reject(err);
  }
);
```
