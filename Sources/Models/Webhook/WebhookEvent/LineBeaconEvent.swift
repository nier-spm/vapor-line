import Foundation

/**
 Event object for when a user enters the range of a LINE Beacon.
 
 You can reply to beacon events.
 
 - `type`: `beacon`
 - `mode`, `timestamp`, `source`: See **LineWebhookEvent**.
 - `replyToken`: Token for replying to this event.
 - `beacon`: See **Beacon**.
 */
public struct LineBeaconEvent: LineWebhookEvent {
    
    public var type: LineWebhookEventType = .beacon
    public var mode: LineWebhookEventMode
    public var timestamp: Double
    public var source: LineWebhookEventSource
    public var replyToken: String
    public var beacon: Beacon
}

// MARK: - Beacon
extension LineBeaconEvent {
    
    /**
     [BeaconBanner]: https://developers.line.biz/en/docs/messaging-api/using-beacons/#beacon-banner
     [LineSimpleBeaconFrame]: https://github.com/line/line-simple-beacon/blob/master/README.en.md#line-simple-beacon-frame
     
     - `hardwareID (hwid)`: Hardware ID of the beacon that was detected
     - `type`: Type of beacon event
        - `enter`: Entered beacon's reception range.
        - `banner`: Tapped [beacon banner][BeaconBanner].
        - `stay`: A user is within the range of the beacon's reception.
            - This event is sent repeatedly at a minimum interval of 10 seconds.
     - `deviceMessage (dm)`: Device message of beacon that was detected. This message consists of data generated by the beacon to send notifications to bot servers. Only included in webhook events from devices that support the "device message" property. For more information, see the [LINE Simple Beacon specification][LineSimpleBeaconFrame].
     */
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

// MARK: - Codable
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
