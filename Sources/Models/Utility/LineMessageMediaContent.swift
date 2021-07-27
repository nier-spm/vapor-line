import Foundation

public struct LineMessageMediaContent: Codable {
    
    public var type: Type
    public var originalContentURL: String?
    public var previewImageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case type
        case originalContentURL = "originalContentUrl"
        case previewImageURL = "previewImageUrl"
    }
}

extension LineMessageMediaContent {
    
    public enum `Type`: String, Codable {
        case line
        case external
    }
}
