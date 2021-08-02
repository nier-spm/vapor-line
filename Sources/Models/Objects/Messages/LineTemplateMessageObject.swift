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
 - `quickReply`: See **Common Properties**.
 */
public struct LineTemplateMessageObject: LineMessageObject {
    
    public var type: LineMessageObjectType = .template
    public var altText: String
    public var template: LineTemplateMessageTemplate
    public var quickReply: LineMessageObjectQuickReply?
}
