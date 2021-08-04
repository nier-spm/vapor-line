import Foundation

/**
 Message object which contains the text sent from the source.
 
 - `id`: Message ID.
 - `type`: `text`
 - `text`: Message text.
    - If the end user sends a LINE emoji, the LINE emoji will be included as a string, like `(hello)` or `(love)`. You can find the LINE emoji details in the `emojis` property.
    - If the end user mentions someone, the display name of the recipient's LINE account will be included as a string, like `@example`. You can find the mention details in the `mention` property.
 - `emojis`: One or more LINE emojis objects. Only included when the `text` property contains a LINE emoji. See **Emoji**.
 - `mention`: Object containing the contents of the mentioned user. See **Mention**.
 */
public struct LineMessageTextObject: LineMessageEventObject {
    
    public var id: String
    public var type: LineMessageEventObjectType = .text
    public var text: String
    public var emojis: [Emoji]?
    public var mention: Mention?
}

// MARK: - Emoji
extension LineMessageTextObject {
    
    /**
     [EmojiList]: https://developers.line.biz/en/docs/messaging-api/emoji-list/
     
     - `index`: Index position for a character in `text`, with the first character being at position `0`.
     - `length`: The length of the LINE emoji string. For LINE emoji `(hello)`, `7` is the length.
     - `productID`: Product ID for a LINE emoji set. See [List of available LINE emojis][EmojiList] for an example of a product ID.
     - `emojiID`: ID for a LINE emoji inside a set. See [List of available LINE emojis][EmojiList] for an example of an emoji ID.
     */
    public struct Emoji: Codable {
        public var index: Int
        public var length: Int
        public var productID: String
        public var emojiID: String
        
        enum CodingKeys: String, CodingKey {
            case index
            case length
            case productID = "productId"
            case emojiID = "emojiId"
        }
    }
}

// MARK: - Mention
extension LineMessageTextObject {
    
    /**
     - `mentionees`: Mentioned user information. See **Mentionee**.
        - Max: 20 mentions
     */
    public struct Mention: Codable {
        public var mentionees: [Mentionee]
    }
    
    /**
     [UserConsent]: https://developers.line.biz/en/docs/messaging-api/user-consent/
     
     - `index`: Index position of the user mention for a character in `text`, with the first character being at position `0`.
     - `length`: The length of the text of the mentioned user. For a mention `@example`, `8` is the length.
     - `userID`: User ID of the mentioned user. Only returned if the [user consents][UserConsent] to the LINE Official Account obtaining their user profile information.
     */
    public struct Mentionee: Codable {
        public var index: Int
        public var length: Int
        public var userID: String
        
        enum CodingKeys: String, CodingKey {
            case index
            case length
            case userID = "userId"
        }
    }
}

// MARK: - Codable
extension LineMessageTextObject: Codable {}
