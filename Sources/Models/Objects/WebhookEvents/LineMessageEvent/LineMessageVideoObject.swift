import Foundation

public struct LineMessageVideoObject: LineMessageEventObject, Codable {
    
    public var id: String
    public var type: LineMessageEventObjectType = .video
    public var duration: Double
    public var contentProvider: LineMessageMediaContent
}
