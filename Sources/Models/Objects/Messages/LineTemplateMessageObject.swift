import Foundation

/**
 [template]: https://developers.line.biz/en/reference/messaging-api/#template-messages
 [templateMessage]: https://developers.line.biz/en/docs/messaging-api/message-types/#template-messages
 
 Template messages are messages with predefined layouts which you can customize.
 
 For more information, see [Template messages][templateMessage].
 
 # Reference
 [Template messages | LINE Developers][template]
 
 - `type`: `template`
 - `altText`: Alternative text. Displayed on devices that do not support template messages.
    - Max character limit: 400
 - `template`: A **Buttons**, **Confirm**, **Carouse**l, or **Image Carousel** object.
 - `sender`: See **LineMessageObjectSender**.
 - `quickReply`: See **Common Properties**.
 */
public struct LineTemplateMessageObject: LineMessageObject {
    
    public var type: LineMessageObjectType = .template
    public var altText: String
    public var template: LineTemplateMessageTemplate
    public var sender: LineMessageObjectSender?
    public var quickReply: LineMessageObjectQuickReply?
}

// MARK: Codable
extension LineTemplateMessageObject: Codable {
    
    enum CodingKeys: String, CodingKey {
        case type
        case altText
        case template
        case sender
        case quickReply
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.type = try container.decode(LineMessageObjectType.self, forKey: .type)
        self.altText = try container.decode(String.self, forKey: .altText)
        
        let template = try container.decode(LineTemplateMessageTemplatePrototype.self, forKey: .template)
        
        switch template.type {
        case .buttons:
            self.template = try container.decode(LineTemplateMessageButtonsTemplate.self, forKey: .template)
        case .confirm:
            self.template = try container.decode(LineTemplateMessageConfirmTemplate.self, forKey: .template)
        case .carousel:
            self.template = try container.decode(LineTemplateMessageCarouselTemplate.self, forKey: .template)
        case .imageCarousel:
            self.template = try container.decode(LineTemplateMessageImageCarouselTemplate.self, forKey: .template)
        }
        
        self.sender = try container.decodeIfPresent(LineMessageObjectSender.self, forKey: .sender)
        self.quickReply = try container.decodeIfPresent(LineMessageObjectQuickReply.self, forKey: .quickReply)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.type, forKey: .type)
        try container.encode(self.altText, forKey: .altText)
        
        switch self.template.type {
        case .buttons:
            let buttons = self.template as! LineTemplateMessageButtonsTemplate
            try container.encode(buttons, forKey: .template)
        case .confirm:
            let confirm = self.template as! LineTemplateMessageConfirmTemplate
            try container.encode(confirm, forKey: .template)
        case .carousel:
            let carousel = self.template as! LineTemplateMessageCarouselTemplate
            try container.encode(carousel, forKey: .template)
        case .imageCarousel:
            let imageCarousel = self.template as! LineTemplateMessageImageCarouselTemplate
            try container.encode(imageCarousel, forKey: .template)
        }
        
        try container.encodeIfPresent(self.sender, forKey: .sender)
        try container.encodeIfPresent(self.quickReply, forKey: .quickReply)
    }
}
