import Foundation

/**
 - `members`: User ID of users who joined/left.
 */
public struct LineMemberJoinLeaveContent: Codable {
    public var members: [LineWebhookEventUserSource]
}
