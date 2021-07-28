import Foundation

public struct LineMessageAudioObject: LineMessageEventObject, Codable {
    
    public var id: String
    public var type: LineMessageEventObjectType = .audio
    public var duration: Double
    public var contentProvider: LineMessageMediaContent
}
