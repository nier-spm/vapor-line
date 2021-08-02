import Foundation

public struct LineMessageObjectReplyItem {
    
    public var type: LineMessageObjectReplyItemType = .action
    public var imageURL: String?
//    public var action: LineActionObject
}

// MARK: - Codable
extension LineMessageObjectReplyItem: Codable {
    
    enum CodingKeys: String, CodingKey {
        case type
        case imageURL = "imageUrl"
//        case action
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.type = try container.decode(LineMessageObjectReplyItemType.self, forKey: .type)
        self.imageURL = try container.decodeIfPresent(String.self, forKey: .imageURL)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.type, forKey: .type)
        try container.encodeIfPresent(self.imageURL, forKey: .imageURL)
    }
}

// MARK: - LineMessageObjectReplyItemType
public enum LineMessageObjectReplyItemType: String, Codable {
    case action
}

// MARK: - LineMessageObjectReplyItem.Sender
extension LineMessageObjectReplyItem {
    
    public struct Sender: Codable {
        var name: String?
        var iconURL: String?
        
        enum CodingKeys: String, CodingKey {
            case name
            case iconURL = "iconUrl"
        }
    }
}

// MARK: - LineMessageObjectReplyItem.Sender Initializer
extension LineMessageObjectReplyItem.Sender {
    
    public init(name: String, iconURL: String) {
        self.name = name
        self.iconURL = iconURL
    }
    
    public init(name: String) {
        self.name = name
    }
    
    public init(iconURL: String) {
        self.iconURL = iconURL
    }
}
