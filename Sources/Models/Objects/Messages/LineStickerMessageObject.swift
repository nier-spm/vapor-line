import Foundation

/**
 [stickerList]: https://developers.line.biz/en/docs/messaging-api/sticker-list/
 [StickerMessage]: https://developers.line.biz/en/reference/messaging-api/#sticker-message
 
 - `type`: `sticker`
 - `packageID`: Package ID for a set of stickers. For information on package IDs, see the [List of available stickers][stickerList].
 - `stickerID`: Sticker ID. For a list of sticker IDs for stickers that can be sent with the Messaging API, see the [List of available stickers][stickerList].
 - `sender`: See **LineMessageObjectSender**.
 - `quickReply`: See **Common Properties**.
 
 # Reference
 [Sticker Message | LINE Developers][StickerMessage]
 */
public struct LineStickerMessageObject: LineMessageObject {
    
    public var type: LineMessageObjectType = .sticker
    public var packageID: String
    public var stickerID: String
    public var sender: LineMessageObjectSender?
    public var quickReply: LineMessageObjectQuickReply?
}

// MARK: Codable
extension LineStickerMessageObject: Codable {
    
    enum CodingKeys: String, CodingKey {
        case type
        case packageID = "packageId"
        case stickerID = "stickerId"
        case sender
        case quickReply
    }
}
