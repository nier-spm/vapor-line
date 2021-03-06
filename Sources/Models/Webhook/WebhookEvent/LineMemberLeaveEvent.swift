import Foundation

/**
 Event object for when a user leaves a group or room that the LINE Official Account is in.
 
 - `type`: `memberLeave`
 - `mode`, `timestamp`, `source`: See **LineWebhookEvent**.
 - `left`: See **LineMemberJoinLeaveContent**.
 */
public struct LineMemberLeaveEvent: LineWebhookEvent {
    
    public var type: LineWebhookEventType = .memberLeave
    public var mode: LineWebhookEventMode
    public var timestamp: Double
    public var source: LineWebhookEventSource
    public var left: LineMemberJoinLeaveContent
}

// MARK: - Codable
extension LineMemberLeaveEvent: Codable {
    
    enum CodingKeys: String, CodingKey {
        case type
        case mode
        case timestamp
        case source
        case left
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.type = try container.decode(LineWebhookEventType.self, forKey: .type)
        self.mode = try container.decode(LineWebhookEventMode.self, forKey: .mode)
        self.timestamp = try container.decode(Double.self, forKey: .timestamp)
        
        let source = try container.decode(LineWebhookEventSourcePrototype.self, forKey: .source)
        
        switch source.type {
        case .user:
            self.source = try container.decode(LineWebhookEventUserSource.self, forKey: .source)
        case .group:
            self.source = try container.decode(LineWebhookEventGroupSource.self, forKey: .source)
        case .room:
            self.source = try container.decode(LineWebhookEventRoomSource.self, forKey: .source)
        }
        
        self.left = try container.decode(LineMemberJoinLeaveContent.self, forKey: .left)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.type, forKey: .type)
        try container.encode(self.mode, forKey: .mode)
        try container.encode(self.timestamp, forKey: .timestamp)
        
        switch self.source.type {
        case .user:
            let user: LineWebhookEventUserSource = self.source as! LineWebhookEventUserSource
            try container.encode(user, forKey: .source)
        case .group:
            let group: LineWebhookEventGroupSource = self.source as! LineWebhookEventGroupSource
            try container.encode(group, forKey: .source)
        case .room:
            let room: LineWebhookEventRoomSource = self.source as! LineWebhookEventRoomSource
            try container.encode(room, forKey: .source)
        }
        
        try container.encode(self.left, forKey: .left)
    }
}
