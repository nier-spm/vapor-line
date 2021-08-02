import Foundation

/**
 [emojis]: https://developers.line.biz/en/docs/messaging-api/emoji-list/
 
 - `type`: `text`
 - `text`: Message text. You can include the following emoji:
    - LINE emojis. Use a `$` character as a placeholder and specify the `product ID` and `emoji ID` of the LINE emoji you want to use in the `emojis` property. For more information, see [List of available LINE emojis][emojis].
    - Unicode emojis
 
    Max character limit: 5000
 
 - `emojis`: See **Emoji**.
    - Max: 20 LINE emoji
 - `sender`: See **LineMessageObjectSender**.
 - `quickReply`: See **Common Properties**.
 */
public struct LineTextMessageObject: LineMessageObject {
    
    public var type: LineMessageObjectType = .text
    public var text: String
    public var emojis: [Emoji]
    public var sender: LineMessageObjectSender?
    public var quickReply: LineMessageObjectQuickReply?
}

extension LineTextMessageObject {
    
    /**
     [emojis]: https://developers.line.biz/en/docs/messaging-api/emoji-list/
     
     One or more LINE emoji.
     
     - `index`: The index position for `$` indicating the placeholder for LINE emojis in `text`, with the first character being at position `0`. See the text message example for details.
     -  `productID`: Product ID for a set of LINE emoji. For more information on product IDs, see [List of available LINE emojis][emojis].
     -  `emojiID`: Emoji ID. For more information on emoji IDs for LINE emojis that are sendable with the Messaging API, see [List of available LINE emojis][emojis].
     */
    public struct Emoji: Codable {
        public var index: Int
        public var productID: String
        public var emojiID: String
        
        enum CodingKeys: String, CodingKey {
            case index
            case productID = "productId"
            case emojiID = "emojiId"
        }
    }
}

// MARK: Codable
extension LineTextMessageObject: Codable {}
