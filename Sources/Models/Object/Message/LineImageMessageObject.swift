import Foundation

/**
 [ImageMessage]: https://developers.line.biz/en/reference/messaging-api/#image-message
 
 - `type`: `image`
 - `originalContentURL`: Image URL (Max character limit: 1000).
    - **HTTPS** over **TLS 1.2** or later
    - JPEG or PNG
    - Max image size: No limits
    - Max file size: 10 MB
 - `previewImageURL`: Preview image URL (Max character limit: 1000).
    - **HTTPS** over **TLS 1.2** or later
    - JPEG or PNG
    - Max image size: No limits
    - Max file size: 1 MB
 - `sender`: See **LineMessageObjectSender**.
 - `quickReply`: See **Common Properties**.
 
 # Reference
 [Image Message | LINE Developers][ImageMessage]
 */
public struct LineImageMessageObject: LineMessageObject {
    
    public var type: LineMessageObjectType = .image
    public var originalContentURL: String
    public var previewImageURL: String
    public var sender: LineMessageObjectSender?
    public var quickReply: LineMessageObjectQuickReply?
}

// MARK: Codable
extension LineImageMessageObject: Codable {
    
    enum CodingKeys: String, CodingKey {
        case type
        case originalContentURL = "originalContentUrl"
        case previewImageURL = "previewImageUrl"
        case sender
        case quickReply
    }
}
