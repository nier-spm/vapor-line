import Foundation

/**
 Template with multiple images which can be cycled like a carousel.
 
 The images are shown in order when scrolling horizontally.
 
 - `type`: `imageCarousel`
 - `columns`: Array of columns.
    - Max columns: 10
 */
public struct LineTemplateMessageImageCarouselTemplate: LineTemplateMessageTemplate {
    
    public var type: LineTemplateMessageTemplateType = .imageCarousel
    public var columns: [Column]
}

extension LineTemplateMessageImageCarouselTemplate {
    
    /**
     Column object for image carousel.
     
     - `imageURL`: Image URL (Max character limit: 1,000).
        - **HTTPS** over **TLS 1.2** or later
        - JPEG or PNG
        - Aspect ratio: 1:1
        - Max width: 1024px
        - Max file size: 10 MB
     - `action`: Action when image is tapped.
     */
    public struct Column: Codable {
        var imageURL: String
//        var action: ActionObject
        
        enum CodingKeys: String, CodingKey {
            case imageURL = "imageUrl"
//            case action
        }
    }
}

extension LineTemplateMessageImageCarouselTemplate: Codable {}
