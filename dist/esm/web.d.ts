import { WebPlugin } from '@capacitor/core';
import type { NFCReaderPlugin } from './definitions';
export declare class NFCReaderWeb extends WebPlugin implements NFCReaderPlugin {
    initialize(): Promise<{
        value: boolean;
    }>;
    startScanning(): Promise<void>;
    stopScanning(): Promise<void>;
}
