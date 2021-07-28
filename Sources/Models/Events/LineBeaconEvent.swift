import Foundation

public struct LineBeaconEvent: LineWebhookEvent {
    
    public var type: LineWebhookEventType = .beacon
    public var mode: LineWebhookEventMode
    public var timestamp: Double
    public var source: LineWebhookEventSource
    public var replyToken: String
    public var beacon: Beacon
}

extension LineBeaconEvent {
    
    public struct Beacon: Codable {
        public var hardwareID: String
        public var type: Type
        public var deviceMessage: String?
        
        enum CodingKeys: String, CodingKey {
            case hardwareID = "hwid"
            case type
            case deviceMessage = "dm"
        }
        
        public enum `Type`: String, Codable {
            case enter
            case banner
            case stay
        }
    }
}

extension LineBeaconEvent: Codable {
    
    enum CodingKeys: String, CodingKey {
        case type
        case mode
        case timestamp
        case source
        case replyToken
        case beacon
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
        
        self.replyToken = try container.decode(String.self, forKey: .replyToken)
        self.beacon = try container.decode(Beacon.self, forKey: .beacon)
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
        
        try container.encode(self.replyToken, forKey: .replyToken)
        try container.encode(self.beacon, forKey: .beacon)
    }
}
