import Foundation

/**
 [OtherComponentSize]: https://developers.line.biz/en/docs/messaging-api/flex-message-layout/#other-component-size
 
 This component renders multiple text strings with different designs in one row.
 
 You can specify the color, size, weight, and decoration for the font.
 
 Span is set to `contents` property in **Text (LineFlexMessageTextComponent)**.
 
 - `type`: `span`
 - `text`: Text. If the `wrap` property of the parent text is set to `true`, you can use a new line character (`\n`) to begin on a new line.
 - `color`: Font color. Use a hexadecimal color code.
 - `size`: Font size. For more information, see [Icon, text, and span size][OtherComponentSize] in the Messaging API documentation.
 - `weight`: Font weight. See **LineFlexMessageComponentFontWeight**.
 - `style`: Style of the text. See **LineFlexMessageComponentTextStyle**.
 - `decoration`: Decoration of the text. See **LineFlexMessageComponentDecoration**.
 */
public struct LineFlexMessageSpanComponent: LineFlexMessageComponent {
    
    public var type: LineFlexMessageComponentType = .span
    public var text: String?
    public var color: String?
    public var size: String?
    public var weight: LineFlexMessageComponentFontWeight?
    public var style: LineFlexMessageComponentTextStyle?
    public var decoration: LineFlexMessageComponentDecoration?
}

// MARK: - Codable
extension LineFlexMessageSpanComponent: Codable {}
