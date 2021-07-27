import Foundation

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
