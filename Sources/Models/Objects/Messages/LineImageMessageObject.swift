import Foundation

public struct LineImageMessageObject: LineMessageObject {
    
    public var type: LineMessageObjectType = .image
    public var originalContentURL: String
    public var previewImageURL: String
    public var quickReply: LineMessageObjectQuickReply?
}

extension LineImageMessageObject: Codable {
    
    enum CodingKeys: String, CodingKey {
        case type
        case originalContentURL = "originalContentUrl"
        case previewImageURL = "previewImageUrl"
        case quickReply
    }
}
