import type { PluginListenerHandle } from '@capacitor/core';
export interface NFCTag {
    id: string;
    type: NFCTagType;
}
export declare enum NFCTagType {
    MIFARE = "MIFARE",
    FeliCa = "FeliCa",
    ISO15693 = "ISO15693",
    ISO7816 = "ISO7816",
    Unknown = "Unknown"
}
export interface NFCError {
    code: string;
    message: string;
}
export interface NFCReaderPlugin {
    initialize(): Promise<{
        value: boolean;
    }>;
    startScanning(): Promise<void>;
    stopScanning(): Promise<void>;
    addListener(eventName: 'nfcTagDetected', listenerFunc: (tag: NFCTag) => void): Promise<PluginListenerHandle>;
    addListener(eventName: 'nfcError', listenerFunc: (error: NFCError) => void): Promise<PluginListenerHandle>;
    removeAllListeners(): Promise<void>;
}
