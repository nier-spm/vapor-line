import Foundation

/**
 [ComponentWidthAndHeight]: https://developers.line.biz/en/docs/messaging-api/flex-message-layout/#component-width-and-height
 
 This component is used to create a space.
 
 You can put a space between, before, or after components by inserting a filler anywhere within a box.
 
 - `type`: `filler`
 - `flex`: The ratio of the width or height of this component within the parent box. For more information, see [Width and height of components][ComponentWidthAndHeight] in the Messaging API documentation.
 
 The `spacing` property of the parent element will be ignored for fillers.
 */
public struct LineFlexMessageFillerComponent: LineFlexMessageComponent {
    
    public var type: LineFlexMessageComponentType = .filler
    public var flex: Double?
}

// MARK: - Codable
extension LineFlexMessageFillerComponent: Codable {}
