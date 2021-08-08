import Foundation

/**
 [AudioMessage]: https://developers.line.biz/en/reference/messaging-api/#audio-message
 
 - `type`:
 - `originalContentURL`: URL of audio file (Max character limit: 1000).
    - HTTPS over TLS 1.2 or later
    - m4a
    - Max file size: 200 MB
 - `duration`: Length of audio file (milliseconds).
 - `sender`: See **LineMessageObjectSender**.
 - `quickReply`: See **Common Properties**.
 
 # Reference
 [Audio Message | LINE Developers][AudioMessage]
 */
public struct LineAudioMessageObject: LineMessageObject {
    
    public var type: LineMessageObjectType = .audio
    public var originalContentURL: String
    public var duration: Double
    public var sender: LineMessageObjectSender?
    public var quickReply: LineMessageObjectQuickReply?
}

// MARK: Codable
extension LineAudioMessageObject: Codable {
    
    enum CodingKeys: String, CodingKey {
        case type
        case originalContentURL = "originalContentUrl"
        case duration
        case sender
        case quickReply
    }
}
