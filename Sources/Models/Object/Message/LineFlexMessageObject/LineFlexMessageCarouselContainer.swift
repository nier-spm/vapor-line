import Foundation

/**
 A carousel is a container that contains multiple bubbles as child elements.
 
 Users can scroll horizontally through the bubbles.
 
 The maximum size of JSON data that defines a carousel is 50 KB.
 
 - `type`: `carousel`
 - `contents`: Bubbles within a carousel. Max: 12 bubbles
 */
public struct LineFlexMessageCarouselContainer: LineFlexMessageContainer {
    
    public var type: LineFlexMessageContainerType = .carousel
    public var contents: [LineFlexMessageBubbleContainer]
}

extension LineFlexMessageCarouselContainer: Codable {}
