import Foundation

public struct LineMessageStickerObject: LineMessageEventObject, Codable {
    
    public var id: String
    public var type: LineMessageEventObjectType = .sticker
    public var packageID: String
    public var stickerID: String
    public var stickerResourceType: ResourceType
    public var keywords: [String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case packageID = "packageId"
        case stickerID = "stickerId"
        case stickerResourceType
        case keywords
    }
}

extension LineMessageStickerObject {
    
    public enum ResourceType: String, Codable {
        case `static` = "STATIC"
        case animation = "ANIMATION"
        case sound = "SOUND"
        case animationSound = "ANIMATION_SOUND"
        case popup = "POPUP"
        case popupSound = "POPUP_SOUND"
        case nameText = "NAME_TEXT"
        case perStickerText = "PER_STICKER_TEXT"
    }
}
