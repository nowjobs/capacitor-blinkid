declare module "@capacitor/core" {
  interface PluginRegistry {
    BlinkID: BlinkIDPlugin;
  }
}

export interface BlinkIDPlugin {

  show(options?: {}): Promise<{ status: string, message: string, data: any }>;
}
