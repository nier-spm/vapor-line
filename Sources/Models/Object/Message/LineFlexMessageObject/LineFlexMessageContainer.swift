import Foundation

// MARK: - [ Protocol ] LineFlexMessageContainer
/**
 [FlexMessageElements]: https://developers.line.biz/en/docs/messaging-api/flex-message-elements/
 
 A container is the top-level structure of a Flex Message.
 
 Here are the types of containers available:
    - `Bubble`
    - `Carousel`
 
 For JSON samples and usage of containers, see [Flex Message elements][FlexMessageElements] in the API documentation.
 
 - `type`: Type of container.
 */
public protocol LineFlexMessageContainer {
    var type: LineFlexMessageContainerType { get }
}

// MARK: - LineFlexMessageContainerType
/**
 - `bubble`
 - `carousel`
 */
public enum LineFlexMessageContainerType: String, Codable {
    case bubble
    case carousel
}
