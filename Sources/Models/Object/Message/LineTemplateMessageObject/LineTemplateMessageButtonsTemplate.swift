import Foundation

/**
 Template with an image, title, text, and multiple action buttons.
 
 - `type`: `buttons`.
 - `thumbnailImageURL`: To avoid delays in displaying messages, keep the size of individual image files small (1 MB or less recommended).
    - Image URL (Max character limit: 1,000)
    - **HTTPS** over **TLS 1.2** or later
    - JPEG or PNG
    - Max width: 1024px
    - Max file size: 10 MB
 -  `imageAspectRatio`: See **LineTemplateMessageImageAspectRatio**.
 - `imageSize`: See **LineTemplateMessageImageSize**.
 - `imageBackgroundColor`: Background color of the image. Specify a RGB color value. Default: `#FFFFFF` (white).
 - `title`: Title.
 - `text`: Message text.
    - Max character limit: 160 (no image or title)
    - Max character limit: 60 (message with an image or title)
 - `defaultAction`: Action when image, title or text area is tapped.
 - `actions`: Action when tapped.
    - Max objects: 4
 */
public struct LineTemplateMessageButtonsTemplate: LineTemplateMessageTemplate {
    
    public var type: LineTemplateMessageTemplateType = .buttons
    public var thumbnailImageURL: String?
    public var imageAspectRatio: LineTemplateMessageImageAspectRatio?
    public var imageSize: LineTemplateMessageImageSize?
    public var imageBackgroundColor: String?
    public var title: String?
    public var text: String
//    public var defaultAction: ActionObject?
//    public var actions: [ActionObject] = []
}

extension LineTemplateMessageButtonsTemplate: Codable {
    
    enum CodingKeys: String, CodingKey {
        case type
        case thumbnailImageURL = "thumbnailImageUrl"
        case imageAspectRatio
        case imageSize
        case imageBackgroundColor
        case title
        case text
//        case defaultAction
//        case actions
    }
}
