import Foundation

public protocol LineWebhookEvent {
    var type: LineWebhookEventType { get }
    var mode: LineWebhookEventMode { get }
    var timestamp: Double { get }
    var source: LineWebhookEventSource { get }
}

extension LineWebhookEvent {
    
    public var time: Date {
        return Date(timeIntervalSince1970: self.timestamp / 1000)
    }
}

public enum LineWebhookEventType: String, Codable {
    case message
}

public enum LineWebhookEventMode: String, Codable {
    case active
    case standby
}

public protocol LineWebhookEventSource {
    var type: LineWebhookEventSourceType { get }
}

public enum LineWebhookEventSourceType: String, Codable {
    case user
    case group
    case room
}
