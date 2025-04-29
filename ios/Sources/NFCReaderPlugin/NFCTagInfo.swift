import Foundation

@objc public class NFCTagInfo: NSObject {
    @objc public let id: String
    @objc public let typeString: String
    
    @objc public init(id: String, typeString: String) {
        self.id = id
        self.typeString = typeString
        super.init()
    }
    
    // Swift用の便利イニシャライザ
    public convenience init(id: String, type: NFCTagType) {
        self.init(id: id, typeString: type.rawValue)
    }
}

public enum NFCTagType: String {
    case MIFARE
    case FeliCa
    case ISO15693
    case ISO7816
    case Unknown
    
    public var rawValue: String {
        switch self {
        case .MIFARE: return "MIFARE"
        case .FeliCa: return "FeliCa"
        case .ISO15693: return "ISO15693"
        case .ISO7816: return "ISO7816"
        case .Unknown: return "Unknown"
        }
    }
}

// Objective-C用のヘルパーメソッド
@objc public extension NFCTagInfo {
    static func getTypeString(_ type: String) -> String {
        guard let nfcType = NFCTagType(rawValue: type) else {
            return NFCTagType.Unknown.rawValue
        }
        return nfcType.rawValue
    }
}