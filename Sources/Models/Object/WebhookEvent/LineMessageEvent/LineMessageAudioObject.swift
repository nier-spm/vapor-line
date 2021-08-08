import Foundation

/**
 Message object which contains the audio content sent from the source.
 
 - `id`: Message ID.
 - `type`: `audio`
 - `duration`: Length of audio file (milliseconds)
 - `contentProvider`: Provider of the audio file. See **LineMessageMediaContent**.
 */
public struct LineMessageAudioObject: LineMessageEventObject {
    
    public var id: String
    public var type: LineMessageEventObjectType = .audio
    public var duration: Double
    public var contentProvider: LineMessageMediaContent
}

// MARK: - Codable
extension LineMessageAudioObject: Codable {}
