import Foundation

/**
 [MarginProperty]: https://developers.line.biz/en/docs/messaging-api/flex-message-layout/#margin-property
 
 This component renders a separating line within a box.
 
 A vertical line will be rendered in a horizontal box and a horizontal line will be rendered in a vertical box.
 
 - `type`: `separator`
 - `margin`: The minimum amount of space to include before this component in its parent container. For more information, see [margin property of the component][MarginProperty] in the Messaging API documentation.
 - `color`: Color of the separator. Use a hexadecimal color code.
 */
public struct LineFlexMessageSeparatorComponent: LineFlexMessageComponent {
    
    public var type: LineFlexMessageComponentType = .separator
    public var margin: String?
    public var color: String?
}

// MARK: - Codable
extension LineFlexMessageSeparatorComponent: Codable {}
