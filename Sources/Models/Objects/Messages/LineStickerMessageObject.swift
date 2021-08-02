import Foundation

public struct LineStickerMessageObject: LineMessageObject {
    
    public var type: LineMessageObjectType = .sticker
    public var packageID: String
    public var stickerID: String
    public var quickReply: LineMessageObjectQuickReply?
}

extension LineStickerMessageObject: Codable {
    
    enum CodingKeys: String, CodingKey {
        case type
        case packageID = "packageId"
        case stickerID = "stickerId"
        case quickReply
    }
}
