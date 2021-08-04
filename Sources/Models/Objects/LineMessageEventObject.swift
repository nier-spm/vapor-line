import Foundation

// MARK: - [ Protocol ] LineMesssageEventObject
/**
 - `id`: Message ID.
 - `type`: Type of message.
 */
public protocol LineMessageEventObject {
    var id: String { get }
    var type: LineMessageEventObjectType { get }
}

// MARK: - LineMessageEventObjectType
/**
 - `text`
 - `image`
 - `video`
 - `audio`
 - `file`
 - `location`
 - `sticker`
 */
public enum LineMessageEventObjectType: String, Codable {
    case text
    case image
    case video
    case audio
    case file
    case location
    case sticker
}

// MARK: - LineMessageEventPrototpye
struct LineMessageEventPrototpye: LineMessageEventObject, Codable {
    
    var id: String
    var type: LineMessageEventObjectType
}
