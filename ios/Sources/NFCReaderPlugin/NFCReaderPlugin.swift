import Foundation
import Capacitor
import CoreNFC


@objc(NFCReaderPlugin)
public class NFCReaderPlugin: CAPPlugin, CAPBridgedPlugin {
    private var implementation: NFCReader?
    
    public let identifier = "NFCReaderPlugin"
    public let jsName = "NFCReader"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "initialize", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "startScanning", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "stopScanning", returnType: CAPPluginReturnPromise)
    ]
    
    override public func load() {
        implementation = NFCReader(delegate: self)
    }
    
    @objc func initialize(_ call: CAPPluginCall) {
        guard let reader = implementation else {
            call.reject("NFCReader not initialized")
            return
        }
        
        call.resolve(["value": reader.isAvailable()])
    }
    
    @objc func startScanning(_ call: CAPPluginCall) {
        guard let reader = implementation else {
            call.reject("NFCReader not initialized")
            return
        }
        
        reader.startScanning()
        call.resolve()
    }
    
    @objc func stopScanning(_ call: CAPPluginCall) {
        implementation?.stopScanning()
        call.resolve()
    }
}

extension NFCReaderPlugin: NFCReaderDelegate {
    public func didDetectTag(_ tag: NFCTagInfo) {
        notifyListeners("nfcTagDetected", data: [
            "id": tag.id,
            "type": tag.typeString
        ])
    }
    
    public func didEncounterError(_ error: Error) {
        notifyListeners("nfcError", data: [
            "code": String(describing: error),
            "message": error.localizedDescription
        ])
    }
}
