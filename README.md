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

### Example

```js
import { Plugins } from "@capacitor/core";

const { BlinkIDPlugin } = Plugins;

enum ScanningStatus {
  Cancelled,
  Succeeded
}

enum RecognizerDocument {
  ID,
  Passport,
  Combined
}

enum ResultState {
  Empty,
  Valid
}

class Recognizer {
  document: RecognizerDocument;
  returnFullDocumentImage = true;
  returnFaceImage = true;
  allowUnverifiedResults = false;
  allowUnparsedResults = false;
  result: ResultState;

  constructor(document: RecognizerDocument) {
    this.document = document;
    this.result = ResultState.Empty;
  }
}

const idRecognizer = new Recognizer(RecognizerDocument.ID);
const passportRecognizer = new Recognizer(RecognizerDocument.Passport);

BlinkIDPlugin.setLicenseKey({ key: license });

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
