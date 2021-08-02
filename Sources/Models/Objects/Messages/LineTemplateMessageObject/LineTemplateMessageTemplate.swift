import Foundation

public protocol LineTemplateMessageTemplate {
    var type: LineTemplateMessageTemplateType { get }
}

// MARK: - LineTemplateMessageTemplateType
/**
 - `buttons`: See **LineTemplateMessageButtonsTemplate**.
 -  `confirm`: See **LineTemplateMessageConfirmTemplate**.
 - `carousel`: See **LineTemplateMessageCarouselTemplate**.
 - `imageCarousel`: See **LineTemplateMessageImageCarouselTemplate**.
 */
public enum LineTemplateMessageTemplateType: String, Codable {
    case buttons
    case confirm
    case carousel
    case imageCarousel = "image_carousel"
}

// MARK: - LineTemplateMessageImageAspectRatio
/**
 Aspect ratio of the image.
 
 - `rectangle`: 1.51:1
 - `square`: 1:1
 
 Default: `rectangle`
 */
public enum LineTemplateMessageImageAspectRatio: String, Codable {
    case rectangle
    case contain
}

// MARK: - LineTemplateMessageImageSize
/**
 Size of the image.
 
 - `cover`: The image fills the entire image area. Parts of the image that do not fit in the area are not displayed.
 - `contain`: The entire image is displayed in the image area. A background is displayed in the unused areas to the left and right of vertical images and in the areas above and below horizontal images.
 
 Default: `cover`
 */
public enum LineTemplateMessageImageSize: String, Codable {
    case cover
    case contain
}
