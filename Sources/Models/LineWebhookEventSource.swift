import Foundation

public protocol LineWebhookEventSource {
    var type: LineWebhookEventSourceType { get }
}

public enum LineWebhookEventSourceType: String, Codable {
    case user
    case group
    case room
}

struct LineWebhookEventSourcePrototype: LineWebhookEventSource, Codable {
    
    var type: LineWebhookEventSourceType
}

public struct LineWebhookEventUserSource: LineWebhookEventSource, Codable {
    
    public var type: LineWebhookEventSourceType = .user
    public var userID: String
    
    enum CodingKeys: String, CodingKey {
        case type
        case userID = "userId"
    }
}

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
