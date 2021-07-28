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
    case unsend
    case follow
    case unfollow
    case join
    case leave
    case memberJoin = "memberJoined"
    case memberLeave = "memberLeft"
    case postback
    case videoPlayComplete
    case beacon
    case accountLink
    case things
}

public enum LineWebhookEventMode: String, Codable {
    case active
    case standby
}

struct LineWebhookEventPrototype: LineWebhookEvent, Codable {
    
    var type: LineWebhookEventType
    var mode: LineWebhookEventMode
    var timestamp: Double
    var source: LineWebhookEventSource
    
    enum CodingKeys: String, CodingKey {
        case type
        case mode
        case timestamp
        case source
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
    }
}
