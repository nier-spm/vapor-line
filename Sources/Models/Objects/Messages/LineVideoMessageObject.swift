import Foundation

/**
 [videoViewingComplete]: https://developers.line.biz/en/reference/messaging-api/#video-viewing-complete
 [VideoMessage]: https://developers.line.biz/en/reference/messaging-api/#video-message
 
 - `type`: `video`
 - `originalContentURL`: URL of video file (Max character limit: 1000).
    - **HTTPS** over **TLS 1.2** or later
    - mp4
    - Max file size: 200 MB
 - `previewImageURL`: URL of preview image (Max character limit: 1000).
    - **HTTPS** over **TLS 1.2** or later
    - JPEG or PNG
    - Max file size: 1 MB
 - `trackingID`: ID used to identify the video when [Video viewing complete event][videoViewingComplete] occurs. If you send a video message with trackingId added, the video viewing complete event occurs when the user finishes watching the video.
 
     You can use the same ID in multiple messages.
 
    - Max character limit: 100
    - Supported character types: Half-width alphanumeric characters (`a-z`, `A-Z`, `0-9`) and symbols (`-.=,+*()%$&;:@{}!?<>[]`)
 - `sender`: See **LineMessageObjectSender**.
 - `quickReply`: See **Common Properties**.
 
 # Reference
 [Video Message | LINE Developers][VideoMessage]
 */
public struct LineVideoMessageObject: LineMessageObject {
    
    public var type: LineMessageObjectType = .video
    public var originalContentURL: String
    public var previewImageURL: String
    public var trackingID: String?
    public var sender: LineMessageObjectSender?
    public var quickReply: LineMessageObjectQuickReply?
}

// MARK: Codable
extension LineVideoMessageObject: Codable {
    
    enum CodingKeys: String, CodingKey {
        case type
        case originalContentURL = "originalContentUrl"
        case previewImageURL = "previewImageUrl"
        case trackingID = "trackingId"
        case sender
        case quickReply
    }
}
