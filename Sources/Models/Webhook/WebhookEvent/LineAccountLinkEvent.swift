import Foundation

/**
 Event object for when a user has linked their LINE account with a provider's service account.
 
 You can reply to account link events.
 
 - `type`: `accountLink
 - `mode`, `timestamp`, `source`: See **LineWebhookEvent**.
 - `replyToken`: Token for replying to this event.
 - `link`: `link` object. This will include whether the account link was successful or not and a nonce (number used once) generated from the user ID on the provider's service. See **Link**.
 */
public struct LineAccountLinkEvent: LineWebhookEvent {
    
    public var type: LineWebhookEventType = .accountLink
    public var mode: LineWebhookEventMode
    public var timestamp: Double
    public var source: LineWebhookEventSource
    public var replyToken: String
    public var link: Link
}

// MARK: - Link
extension LineAccountLinkEvent {
    
    /**
     - `result`: One of the following values to indicate whether the link was successful or not.
        - `ok`: Indicates the link was successful.
        - `failed`: Indicates the link failed for any reason, such as due to a user impersonation.
     - `nonce`: [Specified nonce when verifying the user ID](https://developers.line.biz/en/docs/messaging-api/linking-accounts/#step-four-verifying-user-id).
     */
    public struct Link: Codable {
        public var result: Result
        public var nonce: String
        
        public enum Result: String, Codable {
            case ok
            case failed
        }
    }
}

// MARK: - Codable
extension LineAccountLinkEvent: Codable {
    
    enum CodingKeys: String, CodingKey {
        case type
        case mode
        case timestamp
        case source
        case replyToken
        case link
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
        self.link = try container.decode(Link.self, forKey: .link)
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
        try container.encode(self.link, forKey: .link)
    }
}
