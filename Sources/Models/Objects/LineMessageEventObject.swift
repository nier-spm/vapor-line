import Foundation

public protocol LineMessageEventObject {
    var id: String { get }
    var type: LineMessageEventObjectType { get }
}

public enum LineMessageEventObjectType: String, Codable {
    case text
    case image
    case video
    case audio
    case file
    case location
    case sticker
}

struct LineMessageEventPrototpye: LineMessageEventObject, Codable {
    
    var id: String
    var type: LineMessageEventObjectType
}
