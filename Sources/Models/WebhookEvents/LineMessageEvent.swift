import Foundation

public struct LineMessageEvent: LineWebhookEvent {
    
    public var type: LineWebhookEventType = .message
    public var mode: LineWebhookEventMode
    public var timestamp: Double
    public var source: LineWebhookEventSource
    public var replyToken: String
    public var message: LineMessageEventObject
}

extension LineMessageEvent: Codable {
    
    enum CodingKeys: String, CodingKey {
        case type
        case mode
        case timestamp
        case source
        case replyToken
        case message
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
        
        let message = try container.decode(LineMessageEventPrototpye.self, forKey: .message)
        
        switch message.type {
        case .text:
            self.message = try container.decode(LineMessageTextObject.self, forKey: .message)
        case .image:
            self.message = try container.decode(LineMessageImageObject.self, forKey: .message)
        case .video:
            self.message = try container.decode(LineMessageVideoObject.self, forKey: .message)
        case .audio:
            self.message = try container.decode(LineMessageAudioObject.self, forKey: .message)
        case .file:
            self.message = try container.decode(LineMessageFileObject.self, forKey: .message)
        case .location:
            self.message = try container.decode(LineMessageLocationObject.self, forKey: .message)
        case .sticker:
            self.message = try container.decode(LineMessageStickerObject.self, forKey: .message)
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
        
        try container.encode(self.replyToken, forKey: .replyToken)
        
        switch self.message.type {
        case .text:
            let text: LineMessageTextObject = self.message as! LineMessageTextObject
            try container.encode(text, forKey: .message)
        case .image:
            let image: LineMessageImageObject = self.message as! LineMessageImageObject
            try container.encode(image, forKey: .message)
        case .video:
            let video: LineMessageVideoObject = self.message as! LineMessageVideoObject
            try container.encode(video, forKey: .message)
        case .audio:
            let audio: LineMessageAudioObject = self.message as! LineMessageAudioObject
            try container.encode(audio, forKey: .message)
        case .file:
            let file: LineMessageFileObject = self.message as! LineMessageFileObject
            try container.encode(file, forKey: .message)
        case .location:
            let location: LineMessageLocationObject = self.message as! LineMessageLocationObject
            try container.encode(location, forKey: .message)
        case .sticker:
            let sticker: LineMessageStickerObject = self.message as! LineMessageStickerObject
            try container.encode(sticker, forKey: .message)
        }
    }
}
