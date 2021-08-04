import Foundation

/**
 Message object which contains the video content sent from the source.
 
 The preview image is displayed in the chat and the video is played when the image is tapped.
 
 - `id`: Message ID.
 - `type`: `video`
 - `duration`: Length of video file (milliseconds)
 - `contentProvider`: Provider of the video file. See **LineMessageMediaContent**.
 */
public struct LineMessageVideoObject: LineMessageEventObject {
    
    public var id: String
    public var type: LineMessageEventObjectType = .video
    public var duration: Double
    public var contentProvider: LineMessageMediaContent
}

// MARK: Codable
extension LineMessageVideoObject: Codable {}
