import { WebPlugin } from '@capacitor/core';
export class NFCReaderWeb extends WebPlugin {
    async initialize() {
        throw this.unimplemented('Not implemented on web.');
    }
    async startScanning() {
        throw this.unimplemented('Not implemented on web.');
    }
    async stopScanning() {
        throw this.unimplemented('Not implemented on web.');
    }
}
//# sourceMappingURL=web.js.map