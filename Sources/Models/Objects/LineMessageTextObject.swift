import Foundation

public struct LineMessageTextObject: LineMessageEventObject, Codable {
    
    public var id: String
    public var type: LineMessageEventObjectType = .text
    public var text: String
    public var emojis: [Emoji]?
    public var mention: Mention?
}

extension LineMessageTextObject {
    
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

extension LineMessageTextObject {
    
    public struct Mention: Codable {
        var mentionees: [Mentionee]
    }
    
    public struct Mentionee: Codable {
        var index: Int
        var length: Int
        var userID: String
        
        enum CodingKeys: String, CodingKey {
            case index
            case length
            case userID = "userId"
        }
    }
}
