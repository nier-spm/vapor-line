import Foundation

public struct LineWebhookEventUserSource: LineWebhookEventSource, Codable {
    
    public var type: LineWebhookEventSourceType = .user
    public var userID: String
    
    enum CodingKeys: String, CodingKey {
        case type
        case userID = "userId"
    }
}
