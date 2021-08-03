import Foundation

/**
 [css]: https://developers.line.biz/en/reference/messaging-api/#template-messages
 [flexMessage]: https://developers.line.biz/en/docs/messaging-api/using-flex-messages/
 [FlexMessage]: https://developers.line.biz/en/reference/messaging-api/#flex-message
 
 Flex Messages are messages with a customizable layout.
 
 You can customize the layout freely based on the specification for [CSS Flexible Box (CSS Flexbox)][css].
 
 For more information, see [Sending Flex Messages][flexMessage] in the Messaging API documentation.
 
 # Reference
 [Flex Messages | LINE Developers][FlexMessage]
 
 - `type`: `flex`
 - `altText`: Alternative text.
    - Max character limit: 400
 - `contents`: Flex Message container.
 - `sender`: See **LineMessageObjectSender**.
 - `quickReply`: See **Common Properties**.
 */
public struct LineFlexMessageObject: LineMessageObject {
    
    public var type: LineMessageObjectType = .flex
    public var altText: String
    public var contents: LineFlexMessageContainer
    public var sender: LineMessageObjectSender?
    public var quickReply: LineMessageObjectQuickReply?
}

// MARK: - Codable
extension LineFlexMessageObject: Codable {
    
    enum CodingKeys: String, CodingKey {
        case type
        case altText
        case contents
        case sender
        case quickReply
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.type = try container.decode(LineMessageObjectType.self, forKey: .type)
        self.altText = try container.decode(String.self, forKey: .altText)
        
        if let bubble = try? container.decode(LineFlexMessageBubbleContainer.self, forKey: .contents) {
            self.contents = bubble
        } else {
            let carousel = try container.decode(LineFlexMessageCarouselContainer.self, forKey: .contents)
            self.contents = carousel
        }
        
        self.sender = try container.decodeIfPresent(LineMessageObjectSender.self, forKey: .sender)
        self.quickReply = try container.decodeIfPresent(LineMessageObjectQuickReply.self, forKey: .quickReply)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.type, forKey: .type)
        try container.encode(self.altText, forKey: .altText)
        
        switch self.contents.type {
        case .bubble:
            let bubble = self.contents as! LineFlexMessageBubbleContainer
            try container.encode(bubble, forKey: .contents)
        case .carousel:
            let carousel = self.contents as! LineFlexMessageCarouselContainer
            try container.encode(carousel, forKey: .contents)
        }
        
        try container.encodeIfPresent(self.sender, forKey: .sender)
        try container.encodeIfPresent(self.quickReply, forKey: .quickReply)
    }
}
