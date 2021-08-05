import Foundation

/**
 [ImagemapMessage]: https://developers.line.biz/en/reference/messaging-api/#imagemap-message
 [configImage]: https://developers.line.biz/en/reference/messaging-api/#base-url
 
 Imagemap messages are messages configured with an image that has multiple tappable areas.
 
 You can assign one tappable area for the entire image or different tappable areas on divided areas of the image.
 
 You can also play a video on the image and display a label with a hyperlink after the video is finished.
 
 - `type`: `imagemap`. See **Common Properties**.
 - `baseURL`: Base URL of the image.
    - Max character limit: 1000
    - **HTTPS** over **TLS 1.2** or later
    - For more information about supported images in imagemap messages, see [How to configure an image][configImage].
 - `altText`: Alternative text.
    - Max character limit: 400
 - `baseSize`: Set these properties based on the `baseSize.width` property and the `baseSize.height` property. See **LineSizeObject**.
    - `width`: Width of base image in pixels. Set to **1040**.
    - `height`: Height of base image. Set to the height that corresponds to a width of **1040** pixels.
 - `video`: See **Video**.
 - `actions`: Action when tapped. See **Action**.
 - `sender`: See **LineMessageObjectSender**.
 - `quickReply`: See **Common Properties**.
 
 # Reference
 [Imagemap message | LINE Developers][ImagemapMessage]
 
 - Note: Images used in imagemap messages must meet the requirements. See [How to configure an image][configImage].
 */
public struct LineImagemapMessageObject: LineMessageObject {
    
    public var type: LineMessageObjectType = .imagemap
    public var baseURL: String
    public var altText: String
    public var baseSize: LineSizeObject
    public var video: Video?
    public var actions: [LineImagemapMessageAction] = []
    public var sender: LineMessageObjectSender?
    public var quickReply: LineMessageObjectQuickReply?
}

// MARK: - Video
extension LineImagemapMessageObject {
    
    /**
     - `originalContentURL`: URL of the video file (Max character limit: 1000)
        - **HTTPS** over **TLS 1.2** or later
        - mp4
        - Max length: No limit Max file size: 200 MB
        - A very wide or tall video may be cropped when played in some environments.
     - `previewImageURL`: URL of the preview image (Max character limit: 1000)
        - **HTTPS** over **TLS 1.2** or later
        - JPEG or PNG
        - Max image size: No limits
        - Max file size: 1 MB
     - `area`: See **LineImagemapMessageObjectArea**
     - `externalLink`: See **Video.ExternalLink**
     */
    public struct Video: Codable {
        
        public var originalContentURL: String
        public var previewImageURL: String
        public var area: LineAreaObject
        public var externalLink: ExternalLink?
        
        enum CodingKeys: String, CodingKey {
            case originalContentURL = "originalContentUrl"
            case previewImageURL = "previewImageUrl"
            case area
            case externalLink
        }
    }
}

// MARK: - Video.ExternalLink
extension LineImagemapMessageObject.Video {
    
    /**
     [lineURLScheme]: https://developers.line.biz/en/docs/messaging-api/using-line-url-scheme/
     
     - `linkURL`: Webpage URL. Called when the label displayed after the video is tapped.
        - Max character limit: 1000
        - The available schemes are `http`, `https`, `line`, and `tel`. For more information about the LINE URL scheme, see [Using LINE features with the LINE URL scheme][lineURLScheme].
     - `label`: Label. Displayed after the video is finished.
        - Max character limit: 30
     */
    public struct ExternalLink: Codable {
        
        public var linkURI: String
        public var label: String
        
        enum CodingKeys: String, CodingKey {
            case linkURI = "linkUri"
            case label
        }
    }
}

// MARK: - Codable
extension LineImagemapMessageObject: Codable {
    
    enum CodingKeys: String, CodingKey {
        case type
        case baseURL = "baseUrl"
        case altText
        case baseSize
        case video
        case actions
        case sender
        case quickReply
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.type = try container.decode(LineMessageObjectType.self, forKey: .type)
        self.baseURL = try container.decode(String.self, forKey: .baseURL)
        self.altText = try container.decode(String.self, forKey: .altText)
        self.baseSize = try container.decode(LineSizeObject.self, forKey: .baseSize)
        self.video = try container.decodeIfPresent(Video.self, forKey: .video)
        
        var unkeyedContainer = try container.nestedUnkeyedContainer(forKey: .actions)
        
        while !unkeyedContainer.isAtEnd {
            if let uri = try? unkeyedContainer.decode(LineImagemapMessageURIAction.self) {
                self.actions.append(uri)
            } else if let message = try? unkeyedContainer.decode(LineImagemapMessageMessageAction.self) {
                self.actions.append(message)
            }
        }
        
        self.sender = try container.decodeIfPresent(LineMessageObjectSender.self, forKey: .sender)
        self.quickReply = try container.decodeIfPresent(LineMessageObjectQuickReply.self, forKey: .quickReply)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.type, forKey: .type)
        try container.encode(self.baseURL, forKey: .baseURL)
        try container.encode(self.altText, forKey: .altText)
        try container.encode(self.baseSize, forKey: .baseSize)
        try container.encodeIfPresent(self.video, forKey: .video)
        
        var unkeyedContainer = container.nestedUnkeyedContainer(forKey: .video)
        
        for action in self.actions {
            if let uri = action as? LineImagemapMessageURIAction {
                try unkeyedContainer.encode(uri)
            } else if let message = action as? LineImagemapMessageMessageAction {
                try unkeyedContainer.encode(message)
            }
        }
        
        try container.encodeIfPresent(self.sender, forKey: .sender)
        try container.encodeIfPresent(self.quickReply, forKey: .quickReply)
    }
}
