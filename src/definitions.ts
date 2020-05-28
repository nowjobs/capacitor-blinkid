declare module "@capacitor/core" {
  interface PluginRegistry {
    BlinkID: BlinkIDPlugin;
  }
}

export interface BlinkIDPlugin {
  setLicenseKey(licenseKey: string): Promise<void>;
  startScanning(options: { recognizers: Recognizer[] }): Promise<ScanningStatus>;
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
