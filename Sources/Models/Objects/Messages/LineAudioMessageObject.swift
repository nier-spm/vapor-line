import Foundation

public struct LineAudioMessageObject: LineMessageObject {
    
    public var type: LineMessageObjectType = .audio
    public var originalContentURL: String
    public var duration: Double
    public var quickReply: LineMessageObjectQuickReply?
}

extension LineAudioMessageObject: Codable {
    
    enum CodingKeys: String, CodingKey {
        case type
        case originalContentURL = "originalContentUrl"
        case duration
        case quickReply
    }
}
