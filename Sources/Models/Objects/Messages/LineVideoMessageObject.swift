import Foundation

public struct LineVideoMessageObject: LineMessageObject {
    
    public var type: LineMessageObjectType = .video
    public var originalContentURL: String
    public var previewImageURL: String
    public var trackingID: String?
    public var quickReply: LineMessageObjectQuickReply?
}

extension LineVideoMessageObject: Codable {
    
    enum CodingKeys: String, CodingKey {
        case type
        case originalContentURL = "originalContentUrl"
        case previewImageURL = "previewImageUrl"
        case trackingID = "trackingId"
        case quickReply
    }
}
