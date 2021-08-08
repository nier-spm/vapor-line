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
    public var adjustMode: LineFlexMessageComponentAdjustMode?
    public var flex: String?
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
    public var action: LineActionObject?
    public var style: LineFlexMessageComponentTextStyle?
    public var decoration: LineFlexMessageComponentDecoration?
}

// MARK: - Codable
extension LineFlexMessageTextComponent: Codable {
    
    enum CodingKeys: String, CodingKey {
        case type
        case text
        case contents
        case adjustMode
        case flex
        case margin
        case position
        case offsetTop
        case offsetBottom
        case offsetStart
        case offsetEnd
        case size
        case align
        case gravity
        case wrap
        case maxLines
        case weight
        case color
        case action
        case style
        case decoration
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.type = try container.decode(LineFlexMessageComponentType.self, forKey: .type)
        self.text = try container.decode(String.self, forKey: .text)
        self.contents = try container.decodeIfPresent([LineFlexMessageSpanComponent].self, forKey: .contents)
        self.adjustMode = try container.decodeIfPresent(LineFlexMessageComponentAdjustMode.self, forKey: .adjustMode)
        self.flex = try container.decodeIfPresent(String.self, forKey: .flex)
        self.margin = try container.decodeIfPresent(String.self, forKey: .margin)
        self.position = try container.decodeIfPresent(LineFlexMessageComponentPosition.self, forKey: .position)
        self.offsetTop = try container.decodeIfPresent(String.self, forKey: .offsetTop)
        self.offsetBottom = try container.decodeIfPresent(String.self, forKey: .offsetBottom)
        self.offsetStart = try container.decodeIfPresent(String.self, forKey: .offsetStart)
        self.offsetEnd = try container.decodeIfPresent(String.self, forKey: .offsetEnd)
        self.size = try container.decodeIfPresent(String.self, forKey: .size)
        self.align = try container.decodeIfPresent(LineFlexMessageComponentHorizontalAlignment.self, forKey: .align)
        self.gravity = try container.decodeIfPresent(LineFlexMessageComponentVerticalAlignment.self, forKey: .gravity)
        self.wrap = try container.decodeIfPresent(Bool.self, forKey: .wrap)
        self.maxLines = try container.decodeIfPresent(Int.self, forKey: .maxLines)
        self.weight = try container.decodeIfPresent(LineFlexMessageComponentFontWeight.self, forKey: .weight)
        self.color = try container.decodeIfPresent(String.self, forKey: .color)
        
        let action = try container.decodeIfPresent(LineActionObjectPrototype.self, forKey: .action)
        
        switch action?.type {
        case .postback:
            self.action = try container.decode(LinePostbackActionObject.self, forKey: .action)
        case .message:
            self.action = try container.decode(LineMessageActionObject.self, forKey: .action)
        case .uri:
            self.action = try container.decode(LineURIActionObject.self, forKey: .action)
        case .datetimePicker:
            self.action = try container.decode(LineDateTimePickerActionObject.self, forKey: .action)
        case .camera:
            self.action = try container.decode(LineCameraActionObject.self, forKey: .action)
        case .cameraRoll:
            self.action = try container.decode(LineCameraRollActionObject.self, forKey: .action)
        case .location:
            self.action = try container.decode(LineLocationActionObject.self, forKey: .action)
        case .richmenuSwitch:
            self.action = try container.decode(LineRichmenuSwitchActionObject.self, forKey: .action)
        case .none:
            break
        }
        
        self.style = try container.decodeIfPresent(LineFlexMessageComponentTextStyle.self, forKey: .style)
        self.decoration = try container.decodeIfPresent(LineFlexMessageComponentDecoration.self, forKey: .decoration)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.type, forKey: .type)
        try container.encode(self.text, forKey: .text)
        try container.encodeIfPresent(self.contents, forKey: .contents)
        try container.encodeIfPresent(self.adjustMode, forKey: .adjustMode)
        try container.encodeIfPresent(self.flex, forKey: .flex)
        try container.encodeIfPresent(self.margin, forKey: .margin)
        try container.encodeIfPresent(self.position, forKey: .position)
        try container.encodeIfPresent(self.offsetTop, forKey: .offsetTop)
        try container.encodeIfPresent(self.offsetBottom, forKey: .offsetBottom)
        try container.encodeIfPresent(self.offsetStart, forKey: .offsetStart)
        try container.encodeIfPresent(self.offsetEnd, forKey: .offsetEnd)
        try container.encodeIfPresent(self.size, forKey: .size)
        try container.encodeIfPresent(self.align, forKey: .align)
        try container.encodeIfPresent(self.gravity, forKey: .gravity)
        try container.encodeIfPresent(self.wrap, forKey: .wrap)
        try container.encodeIfPresent(self.maxLines, forKey: .maxLines)
        try container.encodeIfPresent(self.weight, forKey: .weight)
        try container.encodeIfPresent(self.color, forKey: .color)
        
        switch self.action?.type {
        case .postback:
            let postback = self.action as! LinePostbackActionObject
            try container.encode(postback, forKey: .action)
        case .message:
            let message = self.action as! LineMessageActionObject
            try container.encode(message, forKey: .action)
        case .uri:
            let uri = self.action as! LineURIActionObject
            try container.encode(uri, forKey: .action)
        case .datetimePicker:
            let datetimePicker = self.action as! LineDateTimePickerActionObject
            try container.encode(datetimePicker, forKey: .action)
        case .camera:
            let camera = self.action as! LineCameraActionObject
            try container.encode(camera, forKey: .action)
        case .cameraRoll:
            let cameraRoll = self.action as! LineCameraRollActionObject
            try container.encode(cameraRoll, forKey: .action)
        case .location:
            let location = self.action as! LineLocationActionObject
            try container.encode(location, forKey: .action)
        case .richmenuSwitch:
            let richmenuSwitch = self.action as! LineRichmenuSwitchActionObject
            try container.encode(richmenuSwitch, forKey: .action)
        case .none:
            break
        }
        
        try container.encodeIfPresent(self.style, forKey: .style)
        try container.encodeIfPresent(self.decoration, forKey: .decoration)
    }
}
