import Foundation

/**
 [StickerList]: https://developers.line.biz/en/docs/messaging-api/sticker-list/
 
 Message object which contains the sticker data sent from the source.
 
 For a list of basic LINE stickers and sticker IDs, see [List of available stickers][StickerList].
 
 - `id`: Message ID.
 - `type`: `sticker`
 - `packageID`: Package ID.
 - `stickerID`: Sticker ID.
 - `stickerResourceType`: Sticker resource type. See **ResourceType**.
 - `keywords`: List of up to 15 keywords describing the sticker. If a sticker has 16 or more keywords, a random selection of 15 keywords will be returned. The keyword selection is random for each event, so different keywords may be returned for the same sticker.
 
 # About keywords
 
 The `keywords` property is currently in an experimental phase and discontinuation or spec changes may occur in the future.
 */
public struct LineMessageStickerObject: LineMessageEventObject {
    
    public var id: String
    public var type: LineMessageEventObjectType = .sticker
    public var packageID: String
    public var stickerID: String
    public var stickerResourceType: ResourceType
    public var keywords: [String]
}

// MARK: - ResourceType
extension LineMessageStickerObject {
    
    /**
     - `static`: **STATIC**. Still image
     - `animation`: **ANIMATION**. Animated sticker
     - `sound`: **SOUND**. Sticker with sound
     - `animationSound`: **ANIMATION_SOUND**. Animated sticker with sound
     - `popup`: **POPUP**. Pop-up sticker or Effect sticker
     - `popupSound`: **POPUP_SOUND**. Pop-up sticker with sound or Effect sticker with sound
     - `nameText`: **NAME_TEXT**. Custom sticker. You can't retrieve the sticker's custom text with the Messaging API.
     - `perStickerText`: **PER_STICKER_TEXT**. Message sticker. You can't retrieve the sticker's custom text with the Messaging API.
     
     # About stickerResourceType
     
     In the future, we may add new resource types without notice. Make sure your implementation can handle both current and future sticker resource types.
     */
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

// MARK: - Codable
extension LineMessageStickerObject: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case packageID = "packageId"
        case stickerID = "stickerId"
        case stickerResourceType
        case keywords
    }
}
