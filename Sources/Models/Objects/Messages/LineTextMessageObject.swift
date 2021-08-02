import Foundation

public struct LineTextMessageObject: LineMessageObject {
    
    public var type: LineMessageObjectType = .text
    public var text: String
    public var emojis: [Emoji]
    public var quickReply: LineMessageObjectQuickReply?
}

extension LineTextMessageObject {
    
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

extension LineTextMessageObject: Codable {}
