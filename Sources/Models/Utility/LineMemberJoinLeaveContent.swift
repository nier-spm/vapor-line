import Foundation

public struct LineMemberJoinLeaveContent: Codable {
    public var members: [LineWebhookEventUserSource]
}
