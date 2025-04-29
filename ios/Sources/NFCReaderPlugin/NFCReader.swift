import Foundation
import CoreNFC

@objc public class NFCReader: NSObject {
    private var session: NFCTagReaderSession?
    private weak var delegate: NFCReaderDelegate?
    
    @objc public init(delegate: NFCReaderDelegate) {
        super.init()
        self.delegate = delegate
    }
    
    @objc public func isAvailable() -> Bool {
        return NFCTagReaderSession.readingAvailable
    }
    
    @objc public func startScanning() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.session = NFCTagReaderSession(
                pollingOption: [.iso14443, .iso18092],
                delegate: self
            )
            self.session?.alertMessage = "ICカードをスキャンしてください"
            self.session?.begin()
        }
    }
    
    @objc public func stopScanning() {
        session?.invalidate()
    }
}

extension NFCReader: NFCTagReaderSessionDelegate {
    public func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
        guard let tag = tags.first else { return }
        
        let tagInfo = extractTagInfo(from: tag)
        delegate?.didDetectTag(tagInfo)
        
        DispatchQueue.main.async {
            session.invalidate()
        }
    }
    
    public func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: Error) {
        self.session = nil
        
        if let readerError = error as? NFCReaderError {
            if readerError.code != .readerSessionInvalidationErrorUserCanceled {
                delegate?.didEncounterError(error)
            }
        }
    }
    
    public func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {
        // オプションの実装
    }
    
    private func extractTagInfo(from tag: NFCTag) -> NFCTagInfo {
        switch tag {
        case .miFare(let tag):
            return NFCTagInfo(
                id: tag.identifier.map { String(format: "%02X", $0) }.joined(),
                type: .MIFARE
            )
        case .feliCa(let tag):
            return NFCTagInfo(
                id: tag.currentIDm.map { String(format: "%02X", $0) }.joined(),
                type: .FeliCa
            )
        case .iso15693(let tag):
            return NFCTagInfo(
                id: tag.identifier.map { String(format: "%02X", $0) }.joined(),
                type: .ISO15693
            )
        case .iso7816(let tag):
            return NFCTagInfo(
                id: tag.identifier.map { String(format: "%02X", $0) }.joined(),
                type: .ISO7816
            )
        @unknown default:
            return NFCTagInfo(id: "", type: .Unknown)
        }
    }
}
