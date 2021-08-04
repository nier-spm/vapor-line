import Foundation

/**
 - `type`: `videoPlayComplete`
 - `mode`, `timestamp`, `source`: See **LineWebhookEvent**.
 - `replyToken`: Token for replying to this event.
 - `videoPlayComplete`: See **VideoPlayComplete**.
 */
public struct LineVideoViewingCompleteEvent: LineWebhookEvent {
    
    public var type: LineWebhookEventType = .videoPlayComplete
    public var mode: LineWebhookEventMode
    public var timestamp: Double
    public var source: LineWebhookEventSource
    public var replyToken: String
    public var videoPlayComplete: VideoPlayComplete
}

// MARK: - VideoPlayComplete
extension LineVideoViewingCompleteEvent {
    
    /**
     - `trackingID`: ID used to identify a video. Returns the same value as the `trackingID` assigned to the video message.
     */
    public struct VideoPlayComplete: Codable {
        public var trackingID: String
        
        enum CodingKeys: String, CodingKey {
            case trackingID = "trackingId"
        }
    }
}

// MARK: - Codable
extension LineVideoViewingCompleteEvent: Codable {
    
    enum CodingKeys: String, CodingKey {
        case type
        case mode
        case timestamp
        case source
        case replyToken
        case videoPlayComplete
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
        self.videoPlayComplete = try container.decode(VideoPlayComplete.self, forKey: .videoPlayComplete)
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
        try container.encode(self.videoPlayComplete, forKey: .videoPlayComplete)
    }
}

