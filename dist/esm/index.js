import { registerPlugin } from '@capacitor/core';
const NFCReader = registerPlugin('NFCReader', {
    web: () => import('./web').then((m) => new m.NFCReaderWeb()),
});
export * from './definitions';
export { NFCReader };
//# sourceMappingURL=index.js.map