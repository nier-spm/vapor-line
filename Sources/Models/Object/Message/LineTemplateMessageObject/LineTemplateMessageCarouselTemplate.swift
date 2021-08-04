import Foundation

/**
 Template with multiple columns which can be cycled like a carousel.
 
 The columns are shown in order when scrolling horizontally.
 
 - `type`: `carousel`
 - `columns`: Array of columns.
    - Max columns: 10
 - `imageAspectRatio`: See **LineTemplateMessageImageAspectRatio**.
    - Applies to all columns.
 -  `imageSize`: See **LineTemplateMessageImageSize**.
    - Applies to all columns.
 */
public struct LineTemplateMessageCarouselTemplate: LineTemplateMessageTemplate {
    
    public var type: LineTemplateMessageTemplateType = .carousel
    public var columns: [Column]
    public var imageAspectRatio: LineTemplateMessageImageAspectRatio?
    public var imageSize: LineTemplateMessageImageSize?
}

extension LineTemplateMessageCarouselTemplate {
    
    /**
     Column object for carousel
     
     - `thumbnailImageURL`: Image URL (Max character limit: 1,000).
        - **HTTPS** over **TLS 1.2** or later
        - JPEG or PNG
        - Aspect ratio: 1:1.51
        - Max width: 1024px
        - Max file size: 10 MB
     - `imageBackgroundColor`: Background color of the image. Specify a RGB color value. The default value is `#FFFFFF` (white).
     - `title`: Title.
        - Max character limit: 40
     - `text`: Message text.
        - Max character limit: 120 (no image or title)
        - Max character limit: 60 (message with an image or title)
     - `defaultAction`: Action when image, title or text area is tapped.
     - `actions`: Action when tapped.
        - Max objects: 3
     */
    public struct Column: Codable {
        var thumbnailImageURL: String?
        var imageBackgroundColor: String?
        var title: String?
        var text: String
//        var defaultAction: ActionObject?
//        var actions: [ActionObject]
        
        enum CodingKeys: String, CodingKey {
            case thumbnailImageURL = "thumbnailImageUrl"
            case imageBackgroundColor
            case title
            case text
//            case defaultAction
//            case actions
        }
    }
}

extension LineTemplateMessageCarouselTemplate: Codable {}
