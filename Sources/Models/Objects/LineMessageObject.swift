import Foundation

public protocol LineMessageObject {
    var type: LineMessageObjectType { get }
    var quickReply: LineMessageObjectQuickReply? { get set }
}

public struct LineMessageObjectQuickReply: Codable {
    public var items: [LineMessageObjectReplyItem]
}

public enum LineMessageObjectType: String, Codable {
    case text
    case sticker
    case image
    case video
    case audio
    case location
    case imagemap
    case template
    case flex
}
