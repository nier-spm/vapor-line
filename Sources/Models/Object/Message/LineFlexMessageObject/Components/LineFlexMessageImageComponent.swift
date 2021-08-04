import Foundation

/**
 [ComponentWidthAndHeight]: https://developers.line.biz/en/docs/messaging-api/flex-message-layout/#component-width-and-height
 [MarginProperty]: https://developers.line.biz/en/docs/messaging-api/flex-message-layout/#margin-property
 [AlignProperty]: https://developers.line.biz/en/docs/messaging-api/flex-message-layout/#align-property
 [GravityProperty]: https://developers.line.biz/en/docs/messaging-api/flex-message-layout/#gravity-property
 [ImageSize]:
 https://developers.line.biz/en/docs/messaging-api/flex-message-layout/#image-size
 [Offset]: https://developers.line.biz/en/docs/messaging-api/flex-message-layout/#component-offset
 
 This component renders an image.
 
 - `type`: `image`
 - `url`: Image URL.
    - Protocol: HTTPS (TLS 1.2 or later)
    - Image format: JPEG or PNG
    - Maximum image size: 1024×1024 pixels
    - Maximum file size: 10 MB (300 KB when the `animated` property is `true`)
 - `flex`: The ratio of the width or height of this component within the parent box. For more information, see [Width and height of components][ComponentWidthAndHeight] in the Messaging API documentation.
 - `margin`: The minimum amount of space to include before this component in its parent container. For more information, see [margin property of the component][MarginProperty] in the Messaging API documentation.
 - `position`: Reference for `offsetTop`, `offsetBottom`, `offsetStart`, and `offsetEnd`. See **LineFlexMessageComponentPosition**.
 - `offsetTop`: The top offset. For more information, see [Offset] in the Messaging API documentation.
 - `offsetBottom`: The bottom offset. For more information, see [Offset] in the Messaging API documentation.
 - `offsetStart`: The left offset. For more information, see [Offset] in the Messaging API documentation.
 - `offsetEnd`: The right offset. For more information, see [Offset] in the Messaging API documentation.
 - `align`: Alignment style in horizontal direction. For more information, see [Alignment in horizontal direction][AlignProperty] in the Messaging API documentation.
 - `gravity`: Alignment style in vertical direction. For more information, see [Alignment in vertical direction][GravityProperty] in the Messaging API documentation.
 - `size`: The maximum image width. This is md by default. For more information, see [Image size][ImageSize] in the Messaging API documentation.
 - `aspectRatio`: Aspect ratio of the image. `{width}:{height}` format. Specify the value of `{width}` and `{height}` in the range from 1 to 100000. However, you cannot set `{height}` to a value that is more than three times the value of `{width}`. The default value is `1:1`.
 - `aspectMode`: The display style of the image if the aspect ratio of the image and that specified by the aspectRatio property do not match. For more information, see **About the drawing area**.
 - `backgroundColor`: Background color of the image. Use a hexadecimal color code.
 - `action`: Action performed when this image is tapped. Specify an action object.
 - `animated`: When this is `true`, an animated image (APNG) plays. You can specify a value of `true` up to three times in a single message. You can't send messages that exceed this limit. This is `false` by default. Animated images larger than 300 KB aren't played back.
 
 # About the drawing area
 
 Specify the max width of the image with the `size` property and the aspect ratio (horizontal-to-vertical ratio) of the image with the `aspectRatio` property. The rectangular area determined by the `size` and `aspectRatio` properties is called the **drawing area**. The image is rendered in this drawing area.
 
 - If the image width specified by the `flex` property is larger than that calculated from the [size property][ComponentWidthAndHeight], the width of the drawing area is scaled down to the width of the component.
 - If the aspect ratio of the image and that specified by the `aspectRatio` property do not match, the image is displayed according to the `aspectMode` property. The default value is `fit`.
 */
public struct LineFlexMessageImageComponent: LineFlexMessageComponent {
    
    public var type: LineFlexMessageComponentType = .image
    public var url: String
    public var flex: Double?
    public var margin: String?
    public var position: LineFlexMessageComponentPosition?
    public var offsetTop: String?
    public var offsetBottom: String?
    public var offsetStart: String?
    public var offsetEnd: String?
    public var align: LineFlexMessageComponentHorizontalAlignment?
    public var gravity: LineFlexMessageComponentVerticalAlignment?
    public var size: String?
    public var aspectRatio: String?
    public var aspectMode: LineFlexMessageComponentAspectMode?
    public var backgroundColor: String?
//    public var action: LineActionObject?
    public var animated: Bool?
}

// MARK: - Codable
extension LineFlexMessageImageComponent: Codable {}
