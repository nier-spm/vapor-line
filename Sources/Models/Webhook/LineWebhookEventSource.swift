import Foundation

// MARK: - [ Protocol ] LineWebhookEventSource
/// Source **user**, **group**, or **room** object with information about the source of the event.
public protocol LineWebhookEventSource {
    var type: LineWebhookEventSourceType { get }
}

// MARK: - LineWebhookEventSourceType
/**
 - `uesr`
 - `group`
 - `room`
 */
public enum LineWebhookEventSourceType: String, Codable {
    case user
    case group
    case room
}

// MARK: - LineWebhookEventSourcePrototype
struct LineWebhookEventSourcePrototype: LineWebhookEventSource, Codable {
    
    var type: LineWebhookEventSourceType
}

// MARK: - LineWebhookEventUserSource
/**
 - `type`: `user`
 - `uesrID`: ID of the source user.
 */
public struct LineWebhookEventUserSource: LineWebhookEventSource, Codable {
    
    public var type: LineWebhookEventSourceType = .user
    public var userID: String
    
    enum CodingKeys: String, CodingKey {
        case type
        case userID = "userId"
    }
}

// MARK: - LineWebhookEventGroupSource
/**
 [UserConsent]: https://developers.line.biz/en/docs/messaging-api/user-consent/
 
 - `type`: `group`
 - `groupID`: ID of the source group.
 - `userID`: ID of the source user. Only included in message events. Only users of LINE for iOS and LINE for Android are included in `userId`. For more information, see [Consent on getting user profile information][UserConsent].
 */
public struct LineWebhookEventGroupSource: LineWebhookEventSource, Codable {
    
    public var type: LineWebhookEventSourceType = .group
    public var groupID: String
    public var userID: String?
    
    enum CodingKeys: String, CodingKey {
        case type
        case groupID = "groupId"
        case userID = "userId"
    }
}

// MARK: - LineWebhookEventRoomSource
/**
 [UserConsent]: https://developers.line.biz/en/docs/messaging-api/user-consent/
 
 - `type`: `room`
 - `roomID`: ID of the source room.
 - `userID`: ID of the source user. Only included in message events. Only users of LINE for iOS and LINE for Android are included in `userId`. For more information, see [Consent on getting user profile information][UserConsent].
 */
public struct LineWebhookEventRoomSource: LineWebhookEventSource, Codable {
    
    public var type: LineWebhookEventSourceType = .room
    public var roomID: String
    public var userID: String?
    
    enum CodingKeys: String, CodingKey {
        case type
        case roomID = "roomId"
        case userID = "userId"
    }
}
