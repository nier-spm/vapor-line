import Foundation

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
