'use strict';

var core = require('@capacitor/core');

exports.NFCTagType = void 0;
(function (NFCTagType) {
    NFCTagType["MIFARE"] = "MIFARE";
    NFCTagType["FeliCa"] = "FeliCa";
    NFCTagType["ISO15693"] = "ISO15693";
    NFCTagType["ISO7816"] = "ISO7816";
    NFCTagType["Unknown"] = "Unknown";
})(exports.NFCTagType || (exports.NFCTagType = {}));

const NFCReader = core.registerPlugin('NFCReader', {
    web: () => Promise.resolve().then(function () { return web; }).then((m) => new m.NFCReaderWeb()),
});

class NFCReaderWeb extends core.WebPlugin {
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

var web = /*#__PURE__*/Object.freeze({
    __proto__: null,
    NFCReaderWeb: NFCReaderWeb
});

exports.NFCReader = NFCReader;
//# sourceMappingURL=plugin.cjs.js.map
