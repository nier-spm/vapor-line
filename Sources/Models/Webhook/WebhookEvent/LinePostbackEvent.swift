import Foundation

/**
 Event object for when a user performs a postback action which initiates a postback.
 
 You can reply to postback events.
 
 - `type`: `postback`,
 - `mode`, `timestamp`, `source`: See **LineWebhookEvent**.
 - `replyToken`: Token for replying to this event.
 - `postback`: See **Postback**.
 */
public struct LinePostbackEvent: LineWebhookEvent {
    
    public var type: LineWebhookEventType = .postback
    public var mode: LineWebhookEventMode
    public var timestamp: Double
    public var source: LineWebhookEventSource
    public var replyToken: String
    public var postback: Postback
}

// MARK: - Postback
extension LinePostbackEvent {
    
    /**
     - `data`: Postback data.
     - `params`: Any of these JSON objects. See **LinePostbackEventParam**.
     */
    public struct Postback {
        public var data: String
        public var params: LinePostbackEventParam
    }
}

// MARK: - LinePostbackEvent.Postback.Codable
extension LinePostbackEvent.Postback: Codable {
    
    enum CodingKeys: String, CodingKey {
        case data
        case params
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.data = try container.decode(String.self, forKey: .data)
        
        if let datetime = try? container.decode(LinePostbackEventDateTimeParam.self, forKey: .params) {
            self.params = datetime
        } else {
            let richmenu = try container.decode(LinePostbackEventRichMenuParam.self, forKey: .params)
            self.params = richmenu
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.data, forKey: .data)
        
        if let datetime = self.params as? LinePostbackEventDateTimeParam {
            try container.encode(datetime, forKey: .params)
        } else {
            let richmenu = self.params as! LinePostbackEventRichMenuParam
            try container.encode(richmenu, forKey: .params)
        }
    }
}

// MARK: - LinePostbackEvent.Codable
extension LinePostbackEvent: Codable {
    
    enum CodingKeys: String, CodingKey {
        case type
        case mode
        case timestamp
        case source
        case replyToken
        case postback
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
        self.postback = try container.decode(Postback.self, forKey: .postback)
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
        try container.encode(self.postback, forKey: .postback)
    }
}
