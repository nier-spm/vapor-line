import Foundation

/**
 - `type`: Provider of the media file.
 - `originalContentURL`: URL of the media file. Only included when **type** is `external`.
 - `previewImageURL`: URL of the preview image. Only included when **type** is `external`.
 */
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
    
    /**
     [SendMessage]: https://developers.line.biz/en/reference/liff/#send-messages
     
     - `line`: The image was sent by a LINE user. The binary image data can be retrieved from the **content** endpoint.
     - `external`: The image was sent using the LIFF `liff.sendMessages()` method. For more information, see [liff.sendMessages()][SendMessage] in the LIFF API reference.
     */
    public enum `Type`: String, Codable {
        case line
        case external
    }
}
