import Foundation

/**
 [BaselineBox]: https://developers.line.biz/en/docs/messaging-api/flex-message-layout/#baseline-box
 [MarginProperty]: https://developers.line.biz/en/docs/messaging-api/flex-message-layout/#margin-property
 [Offset]: https://developers.line.biz/en/docs/messaging-api/flex-message-layout/#component-offset
 [OtherComponentSize]: https://developers.line.biz/en/docs/messaging-api/flex-message-layout/#other-component-size
 
 This component renders an icon for decorating the adjacent text.
 
 This component can be used only in a [baseline box][BaselineBox].
 
 - `type`: `icon`
 - `url`: Image URL.
    - Protocol: HTTPS (TLS 1.2 or later)
    - Image format: JPEG or PNG
    - Maximum image size: 1024×1024 pixels
    - Maximum data size: 1 MB
 - `margin`: The minimum amount of space to include before this component in its parent container. For more information, see [margin property of the component][MarginProperty] in the Messaging API documentation.
 - `position`: Reference for `offsetTop`, `offsetBottom`, `offsetStart`, and `offsetEnd`. See **LineFlexMessageComponentPosition**.
 - `offsetTop`: The top offset. For more information, see [Offset] in the Messaging API documentation.
 - `offsetBottom`: The bottom offset. For more information, see [Offset] in the Messaging API documentation.
 - `offsetStart`: The left offset. For more information, see [Offset] in the Messaging API documentation.
 - `offsetEnd`: The right offset. For more information, see [Offset] in the Messaging API documentation.
 - `size`: Maximum size of the icon width. This is md by default. For more information, see [Icon, text, and span size][OtherComponentSize] in the Messaging API documentation.
 - `aspectRatio`: Aspect ratio of the image. `{width}:{height}` format. Specify the value of `{width}` and `{height}` in the range from 1 to 100000. However, you cannot set `{height}` to a value that is more than three times the value of `{width}`. The default value is `1:1`.
 
 The icon's `flex` property is fixed to `0`.
 */
public struct LineFlexMessageIconComponent: LineFlexMessageComponent {
    
    public var type: LineFlexMessageComponentType = .icon
    public var url: String
    public var margin: String?
    public var position: LineFlexMessageComponentPosition?
    public var offsetTop: String?
    public var offsetBottom: String?
    public var offsetStart: String?
    public var offsetEnd: String?
    public var size: String?
    public var aspectRatio: String?
}

// MARK: - Codable
extension LineFlexMessageIconComponent: Codable {}
