declare module "@capacitor/core" {
  interface PluginRegistry {
    BlinkID: BlinkIDPlugin;
  }
}

export interface BlinkIDPlugin {
  setLicenseKey(licenseKey: string): Promise<void>;
  startScanning(): Promise<ScanningResult>;
  stopScanning(): Promise<void>;
}

export interface ScanningResult {
  status: ScanningStatus;
  image?: string;
}

export enum ScanningStatus {
  Cancelled,
  Succeeded
}

export interface Recognizer {
  type: RecognizerType;
  returnFullDocumentImage: boolean;
  returnFaceImage: boolean;
  allowUnverifiedResults: boolean;
  allowUnparsedResults: boolean;
}

export enum RecognizerType {
  ID,
  Passport,
  Combined
}
