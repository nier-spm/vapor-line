import Foundation

/**
 [ComponentWidthAndHeight]: https://developers.line.biz/en/docs/messaging-api/flex-message-layout/#component-width-and-height
 [MarginProperty]: https://developers.line.biz/en/docs/messaging-api/flex-message-layout/#margin-property
 [OtherComponentSize]: https://developers.line.biz/en/docs/messaging-api/flex-message-layout/#other-component-size
 [AlignProperty]: https://developers.line.biz/en/docs/messaging-api/flex-message-layout/#align-property
 [GravityProperty]: https://developers.line.biz/en/docs/messaging-api/flex-message-layout/#gravity-property
 [TextWrap]: https://developers.line.biz/en/docs/messaging-api/flex-message-elements/#text-wrap
 
 This component renders a text string in one row.
 
 You can specify font color, size, and weight.
 
 - `type`: `text`
 - `text`: Text. Be sure to set either one of the `text` property or `contents` property. If you set the `contents` property, `text` is ignored.
 - `contents`: Array of **spans (LineFlexMessageSpanComponent)**. Be sure to set either one of the `text` property or `contents` property. If you set the `contents` property, `text` is ignored.
 - `adjustMode`: The method by which to adjust the text's font size.
 - `flex`: The ratio of the width or height of this component within the parent box. For more information, see [Width and height of components][ComponentWidthAndHeight] in the Messaging API documentation.
 - `margin`: The minimum amount of space to include before this component in its parent container. For more information, see [margin property of the component][MarginProperty] in the Messaging API documentation.
 - `position`: Reference for `offsetTop`, `offsetBottom`, `offsetStart`, and `offsetEnd`. See **LineFlexMessageComponentPosition**.
 - `offsetTop`: The top offset. For more information, see [Offset] in the Messaging API documentation.
 - `offsetBottom`: The bottom offset. For more information, see [Offset] in the Messaging API documentation.
 - `offsetStart`: The left offset. For more information, see [Offset] in the Messaging API documentation.
 - `offsetEnd`: The right offset. For more information, see [Offset] in the Messaging API documentation.
 - `size`: Font size. This is `md` by default. For more information, see [Icon, text, and span size][OtherComponentSize] in the Messaging API documentation.
 - `align`: Alignment style in horizontal direction. For more information, see [Alignment in horizontal direction][AlignProperty] in the Messaging API documentation.
 - `gravity`: Alignment style in vertical direction. For more information, see [Alignment in vertical direction][GravityProperty] in the Messaging API documentation.
 - `wrap`: `true` to wrap text. The default value is `false`. If set to `true`, you can use a new line character (`\n`) to begin on a new line. For more information, see [Wrapping text][TextWrap] in the Messaging API documentation.
 - `maxLines`: Max number of lines. If the text does not fit in the specified number of lines, an ellipsis (…) is displayed at the end of the last line. If set to `0`, all the text is displayed. The default value is `0`. This property is supported on the following versions of LINE.
    - LINE 8.11.0 or later for iOS and Android
 - `weight`: Font weight. See **LineFlexMessageComponentFontWeight**.
 - `color`: Font color. Use a hexadecimal color code.
 - `action`: Action performed when this image is tapped. Specify an action object.
 - `style`: Style of the text. See **LineFlexMessageComponentTextStyle**.
 - `decoration`: Decoration of the text. See **LineFlexMessageComponentDecoration**.
 */
public struct LineFlexMessageTextComponent: LineFlexMessageComponent {
    
    public var type: LineFlexMessageComponentType = .text
    public var text: String
    public var contents: [LineFlexMessageSpanComponent]?
    public var adjustMode: LineFlexMessageComponentAspectMode?
    public var flex: String
    public var margin: String?
    public var position: LineFlexMessageComponentPosition?
    public var offsetTop: String?
    public var offsetBottom: String?
    public var offsetStart: String?
    public var offsetEnd: String?
    public var size: String?
    public var align: LineFlexMessageComponentHorizontalAlignment?
    public var gravity: LineFlexMessageComponentVerticalAlignment?
    public var wrap: Bool?
    public var maxLines: Int?
    public var weight: LineFlexMessageComponentFontWeight?
    public var color: String?
//    public var action: LineActionObject?
    public var style: LineFlexMessageComponentTextStyle?
    public var decoration: LineFlexMessageComponentDecoration?
}

// MARK: - Codable
extension LineFlexMessageTextComponent: Codable {}
