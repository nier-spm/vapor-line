import Foundation

// MARK: - [ Protocol ] LineMessageObject
/**
 [messageObject]: https://developers.line.biz/en/reference/messaging-api/#message-objects
 [quickReplies]: https://developers.line.biz/en/docs/messaging-api/using-quick-reply/
 
 JSON object which contains the contents of the message you send.
 
 # Reference
 [Message Object | LINE Developers][messageObject]
 
 The following properties can be specified in all the message objects.
 
 - `type`: Type of Line message Object.
 - `sender`: When sending a message from the LINE Official Account, you can specify the `name` and the `iconURL` properties in Message objects.
 - `quickReply`: These properties are used for the quick reply feature. Supported on 8.11.0 or later for both LINE for iOS and LINE for Android. For more information, see [Using quick replies][quickReplies].
 
 If the user receives multiple message objects, the `quickReply` property of the last message object is displayed.
 */
public protocol LineMessageObject {
    var type: LineMessageObjectType { get }
    var sender: LineMessageObjectSender? { get set }
    var quickReply: LineMessageObjectQuickReply? { get set }
}

// MARK: - LineMessageObjectQuickReply
/**
 This is a container that contains quick reply buttons.
 
 - `items`: Quick reply button objects.
    - Max: 13 objects
 */
public struct LineMessageObjectQuickReply: Codable {
    public var items: [LineMessageObjectReplyItem]
}

// MARK: - LineMessageObjectType
/**
 - `text`: See **LineTextMessageObject**.
 - `sticker`: See **LineStickerMessageObject**.
 - `image`: See **LineImageMessageObject**.
 - `video`: See **LineVideoMessageObject**.
 - `audio`: See **LineAudioMessageObject**.
 - `location`: See **LineLocationMessageObject**.
 - `imagemap`: See **LineImagemapMessageObject**.
 - `template`: See **LineTemplateMessageObject**.
 - `flex`: See **LineFlexMessageObject**.
 */
public enum LineMessageObjectType: String, Codable {
    case text
    case sticker
    case image
    case video
    case audio
    case location
    case imagemap
    case template
    case flex
}
