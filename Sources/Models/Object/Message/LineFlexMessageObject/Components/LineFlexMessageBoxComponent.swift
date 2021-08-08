import Foundation

/**
 [FlexMessageLayout]: https://developers.line.biz/en/docs/messaging-api/flex-message-layout/#box-layout-types
 [BoxWidth]: https://developers.line.biz/en/docs/messaging-api/flex-message-layout/#box-width
 [BoxHeight]: https://developers.line.biz/en/docs/messaging-api/flex-message-layout/#box-height
 [ComponentWidthAndHeight]: https://developers.line.biz/en/docs/messaging-api/flex-message-layout/#component-width-and-height
 [SpacingProperty]: https://developers.line.biz/en/docs/messaging-api/flex-message-layout/#spacing-property
 [MarginProperty]: https://developers.line.biz/en/docs/messaging-api/flex-message-layout/#margin-property
 [PaddingProperty]: https://developers.line.biz/en/docs/messaging-api/flex-message-layout/#padding-property
 [Offset]: https://developers.line.biz/en/docs/messaging-api/flex-message-layout/#component-offset
 [JustifyProperty]: https://developers.line.biz/en/docs/messaging-api/flex-message-layout/#justify-property
 
 This is a component that defines the layout of child components.
 
 You can also include a box in a box.
 
 - `type`: `box`
 - `layout`: The layout style of components in this box. For more information, see [Direction of placing components][FlexMessageLayout] in the API documentation.
 - `contents`: Components in this box. Here are the types of components available:
    - When the `layout` property is `horizontal` or `vertical`: **box**, **button**, **image**, **text**, **separator**, and **filler**
    - When the `layout` property is `baseline`: **icon**, **text**, and **filler**
 
     Components are rendered in the same order specified in the array. You may also specify an empty array.
 
 - `backgroundColor`: Background color of the block. In addition to the RGB color, an alpha channel (transparency) can also be set. Use a hexadecimal color code. (Example:`#RRGGBBAA`) The default value is `#00000000`.
 - `borderColor`: Color of box border. Use a hexadecimal color code.
 - `borderWidth`: Width of box border. You can specify a value in pixels or any one of `none`, `light`, `normal`, `medium`, `semi-bold`, or `bold`. A value of `none` means that borders are not rendered; the other values are listed in order of increasing width.
 - `cornerRadius`: Radius at the time of rounding the corners of the border. You can specify a value in pixels or any one of `none`, `xs`, `sm`, `md`, `lg`, `xl`, or `xxl`. `none` doesn't round the corner while the others increase in radius in the order of listing. The default value is `none`.
 - `width`: Box width. For more information, see [Box width][BoxWidth] in the Messaging API documentation.
 - `height`: Box height. For more information, see [Box height][BoxHeight] in the Messaging API documentation.
 - `flex`: The ratio of the width or height of this component within the parent box. For more information, see [Width and height of components][ComponentWidthAndHeight] in the Messaging API documentation.
 - `spacing`: Minimum space between components in this box. The default value is `none`. For more information, see [spacing property of the box][SpacingProperty] in the Messaging API documentation.
 - `margin`: The minimum amount of space to include before this component in its parent container. For more information, see [margin property of the component][MarginProperty] in the Messaging API documentation.
 - `paddingAll`: Free space between the borders of this box and the child element. For more information, see [Box padding][PaddingProperty] in the Messaging API documentation.
 - `paddingTop`: Free space between the border at the upper end of this box and the upper end of the child element. For more information, see [Box padding][PaddingProperty] in the Messaging API documentation.
 - `paddingBottom`: Free space between the border at the lower end of this box and the lower end of the child element. For more information, see [Box padding][PaddingProperty] in the Messaging API documentation.
 - `paddingStart`: Free space between the border at the left end of this box and the left end of the child element. For more information, see [Box padding][PaddingProperty] in the Messaging API documentation.
 - `paddingEnd`: Free space between the border at the right end of this box and the right end of the child element. For more information, see [Box padding][PaddingProperty] in the Messaging API documentation.
 - `position`: Reference position for placing this box. See **LineFlexMessageComponentPosition**.
 - `offsetTop`: The top offset. For more information, see [Offset] in the Messaging API documentation.
 - `offsetBottom`: The bottom offset. For more information, see [Offset] in the Messaging API documentation.
 - `offsetStart`: The left offset. For more information, see [Offset] in the Messaging API documentation.
 - `offsetEnd`: The right offset. For more information, see [Offset] in the Messaging API documentation.
 - `action`: Action performed when this image is tapped. Specify an action object. This property is supported on the following versions of LINE.
    - LINE 8.11.0 or later for iOS and Android
 - `justifyContent`: How child elements are aligned along the main axis of the parent element. If the parent element is a horizontal box, this only takes effect when its child elements have their `flex` property set equal to 0. For more information, see [Arranging a box's child elements and free space][JustifyProperty] in the Messaging API documentation.
 - `alignItems`: How child elements are aligned along the cross axis of the parent element. For more information, see [Arranging a box's child elements and free space][JustifyProperty] in the Messaging API documentation.
 - `background`: See **Background**.
 */
public struct LineFlexMessageBoxComponent: LineFlexMessageComponent {
    
    public var type: LineFlexMessageComponentType = .box
    public var layout: Layout
    public var contents: [LineFlexMessageComponent] = []
    public var backgroundColor: String?
    public var borderColor: String?
    public var borderWidth: String?
    public var cornerRadius: String?
    public var width: String?
    public var height: String?
    public var flex: Double?
    public var spacing: String?
    public var margin: String?
    public var paddingAll: String?
    public var paddingTop: String?
    public var paddingBottom: String?
    public var paddingStart: String?
    public var paddingEnd: String?
    public var position: LineFlexMessageComponentPosition?
    public var offsetTop: String?
    public var offsetBottom: String?
    public var offsetStart: String?
    public var offsetEnd: String?
    public var action: LineActionObject?
    public var justifyContent: String?
    public var alignItems: String?
    public var background: Background?
}

// MARK: - Layout
extension LineFlexMessageBoxComponent {
    
    /**
     [BaselineBox]: https://developers.line.biz/en/docs/messaging-api/flex-message-layout/#baseline-box
     
     There are three types of boxes.
     
     The direction of the main axis is determined by a box's type.
     
     Specify the type of any **box** through its `layout` property.
     
     - `horizontal`: **Horizontal box**. The main axis is horizontal. Child elements are arranged horizontally. The cross axis is vertical.
     - `vertical`: **Vertical box**. The main axis is vertical. Child elements are arranged vertically from top to bottom. The cross axis is horizontal.
     - `baseline`: **Baseline box**. The main axis runs in the same direction as a horizontal box.
     For more information on how this differs from a horizontal box, see [Characteristics of a baseline box][BaselineBox].
     */
    public enum Layout: String, Codable {
        case horizontal
        case vertical
        case baseline
    }
}

// MARK: - Background
extension LineFlexMessageBoxComponent {
    
    /**
     [LinearGradientBackgroundAngle]: https://developers.line.biz/en/docs/messaging-api/flex-message-layout/#linear-gradient-bg-angle
     [LinearGradientBackgroundCenterColor]: https://developers.line.biz/en/docs/messaging-api/flex-message-layout/#linear-gradient-bg-center-color
     
     - `type`: The type of background used. See **Type**.
     - `angle`: The angle at which a linear gradient moves. Specify the angle using an integer value like `90deg` (90 degrees) or a decimal number like `23.5deg` (23.5 degrees) in the half-open interval [0, 360). The direction of the linear gradient rotates clockwise as the angle increases. Given a value of `0deg`, the gradient starts at the bottom and ends at the top; given a value of `45deg`, the gradient starts at the bottom-left corner and ends at the top-right corner; given a value of `90deg`, the gradient starts at the left and ends at the right; and given a value of `180deg`, the gradient starts at the top and ends at the bottom. For more information, see [Direction (angle) of linear gradient backgrounds][LinearGradientBackgroundAngle] in the Messaging API documentation.
     - `startColor`: The color at the gradient's starting point. Use a hexadecimal color code in the `#RRGGBB` or `#RRGGBBAA` format.
     - `endColor`: The color at the gradient's ending point. Use a hexadecimal color code in the `#RRGGBB` or `#RRGGBBAA` format.
     - `centerColor`: The color in the middle of the gradient. Use a hexadecimal color code in the #RRGGBB or #RRGGBBAA format. Specify a value for the background.centerColor property to create a gradient that has three colors. For more information, see [Intermediate color stops for linear gradients][LinearGradientBackgroundCenterColor] in the Messaging API documentation.
     - `centerPosition`: The position of the intermediate color stop. Specify an integer or decimal value between 0% (the starting point) and 100% (the ending point). This is 50% by default. For more information, see [Intermediate color stops for linear gradients][LinearGradientBackgroundCenterColor] in the Messaging API documentation.
     */
    public struct Background: Codable {
        public var type: Type
        public var angle: String
        public var startColor: String
        public var endColor: String
        public var centerColor: String?
        public var centerPosition: String?
    }
}

extension LineFlexMessageBoxComponent.Background {
    
    /**
     [LinearGradientBackground]: https://developers.line.biz/en/docs/messaging-api/flex-message-layout/#linear-gradient-bg
     
     - `linearGradient`: Linear gradient. For more information, see [Linear gradient backgrounds][LinearGradientBackground] in the Messaging API documentation.
     */
    public enum `Type`: String, Codable {
        case linearGradient
    }
}

// MARK: - Codable
extension LineFlexMessageBoxComponent: Codable {
    
    enum CodingKeys: String, CodingKey {
        case type
        case layout
        case contents
        case backgroundColor
        case borderColor
        case borderWidth
        case cornerRadius
        case width
        case height
        case flex
        case spacing
        case margin
        case paddingAll
        case paddingTop
        case paddingBottom
        case paddingStart
        case paddingEnd
        case position
        case offsetTop
        case offsetBottom
        case offsetStart
        case offsetEnd
        case action
        case justifyContent
        case alignItems
        case background
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.type = try container.decode(LineFlexMessageComponentType.self, forKey: .type)
        self.layout = try container.decode(Layout.self, forKey: .layout)
        
        let contents = try container.decode([LineFlexMessageComponentPrototype].self, forKey: .contents)
        
        var unkeyedContainer = try container.nestedUnkeyedContainer(forKey: .contents)
        
        while !unkeyedContainer.isAtEnd {
            switch contents[unkeyedContainer.currentIndex].type {
            case .box:
                let box = try unkeyedContainer.decode(LineFlexMessageBoxComponent.self)
                self.contents.append(box)
            case .button:
                let button = try unkeyedContainer.decode(LineFlexMessageButtonComponent.self)
                self.contents.append(button)
            case .image:
                let image = try unkeyedContainer.decode(LineFlexMessageImageComponent.self)
                self.contents.append(image)
            case .icon:
                let icon = try unkeyedContainer.decode(LineFlexMessageIconComponent.self)
                self.contents.append(icon)
            case .text:
                let text = try unkeyedContainer.decode(LineFlexMessageTextComponent.self)
                self.contents.append(text)
            case .span:
                let span = try unkeyedContainer.decode(LineFlexMessageSpanComponent.self)
                self.contents.append(span)
            case .separator:
                let separator = try unkeyedContainer.decode(LineFlexMessageSeparatorComponent.self)
                self.contents.append(separator)
            case .filler:
                let filler = try unkeyedContainer.decode(LineFlexMessageFillerComponent.self)
                self.contents.append(filler)
            }
        }
        
        self.backgroundColor = try container.decodeIfPresent(String.self, forKey: .backgroundColor)
        self.borderColor = try container.decodeIfPresent(String.self, forKey: .borderColor)
        self.borderWidth = try container.decodeIfPresent(String.self, forKey: .borderWidth)
        self.cornerRadius = try container.decodeIfPresent(String.self, forKey: .cornerRadius)
        self.width = try container.decodeIfPresent(String.self, forKey: .width)
        self.height = try container.decodeIfPresent(String.self, forKey: .height)
        self.flex = try container.decodeIfPresent(Double.self, forKey: .flex)
        self.spacing = try container.decodeIfPresent(String.self, forKey: .spacing)
        self.margin = try container.decodeIfPresent(String.self, forKey: .margin)
        self.paddingAll = try container.decodeIfPresent(String.self, forKey: .paddingAll)
        self.paddingTop = try container.decodeIfPresent(String.self, forKey: .paddingTop)
        self.paddingBottom = try container.decodeIfPresent(String.self, forKey: .paddingBottom)
        self.paddingStart = try container.decodeIfPresent(String.self, forKey: .paddingStart)
        self.paddingEnd = try container.decodeIfPresent(String.self, forKey: .paddingEnd)
        self.position = try container.decodeIfPresent(LineFlexMessageComponentPosition.self, forKey: .position)
        self.offsetTop = try container.decodeIfPresent(String.self, forKey: .offsetTop)
        self.offsetBottom = try container.decodeIfPresent(String.self, forKey: .offsetBottom)
        self.offsetStart = try container.decodeIfPresent(String.self, forKey: .offsetStart)
        self.offsetEnd = try container.decodeIfPresent(String.self, forKey: .offsetEnd)
        
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
        
        self.justifyContent = try container.decodeIfPresent(String.self, forKey: .justifyContent)
        self.alignItems = try container.decodeIfPresent(String.self, forKey: .alignItems)
        self.background = try container.decodeIfPresent(Background.self, forKey: .background)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.type, forKey: .type)
        try container.encode(self.layout, forKey: .layout)
        
        var unkeyedContainer = container.nestedUnkeyedContainer(forKey: .contents)
        
        for content in self.contents {
            switch content.type {
            case .box:
                let box = content as! LineFlexMessageBoxComponent
                try unkeyedContainer.encode(box)
            case .button:
                let button = content as! LineFlexMessageButtonComponent
                try unkeyedContainer.encode(button)
            case .image:
                let image = content as! LineFlexMessageImageComponent
                try unkeyedContainer.encode(image)
            case .icon:
                let icon = content as! LineFlexMessageIconComponent
                try unkeyedContainer.encode(icon)
            case .text:
                let text = content as! LineFlexMessageTextComponent
                try unkeyedContainer.encode(text)
            case .span:
                let span = content as! LineFlexMessageSpanComponent
                try unkeyedContainer.encode(span)
            case .separator:
                let separator = content as! LineFlexMessageSeparatorComponent
                try unkeyedContainer.encode(separator)
            case .filler:
                let filler = content as! LineFlexMessageFillerComponent
                try unkeyedContainer.encode(filler)
            }
        }
        
        try container.encodeIfPresent(self.backgroundColor, forKey: .backgroundColor)
        try container.encodeIfPresent(self.borderColor, forKey: .borderColor)
        try container.encodeIfPresent(self.borderWidth, forKey: .borderWidth)
        try container.encodeIfPresent(self.cornerRadius, forKey: .cornerRadius)
        try container.encodeIfPresent(self.width, forKey: .width)
        try container.encodeIfPresent(self.width, forKey: .width)
        try container.encodeIfPresent(self.height, forKey: .height)
        try container.encodeIfPresent(self.flex, forKey: .flex)
        try container.encodeIfPresent(self.spacing, forKey: .spacing)
        try container.encodeIfPresent(self.margin, forKey: .margin)
        try container.encodeIfPresent(self.paddingAll, forKey: .paddingAll)
        try container.encodeIfPresent(self.paddingTop, forKey: .paddingTop)
        try container.encodeIfPresent(self.paddingBottom, forKey: .paddingBottom)
        try container.encodeIfPresent(self.paddingStart, forKey: .paddingStart)
        try container.encodeIfPresent(self.paddingEnd, forKey: .paddingEnd)
        try container.encodeIfPresent(self.position, forKey: .position)
        try container.encodeIfPresent(self.offsetTop, forKey: .offsetTop)
        try container.encodeIfPresent(self.offsetBottom, forKey: .offsetBottom)
        try container.encodeIfPresent(self.offsetStart, forKey: .offsetStart)
        try container.encodeIfPresent(self.offsetEnd, forKey: .offsetEnd)
        
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
        
        try container.encodeIfPresent(self.justifyContent, forKey: .justifyContent)
        try container.encodeIfPresent(self.alignItems, forKey: .alignItems)
        try container.encodeIfPresent(self.background, forKey: .background)
    }
}
