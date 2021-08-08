import Foundation

/**
 [ComponentWidthAndHeight]: https://developers.line.biz/en/docs/messaging-api/flex-message-layout/#component-width-and-height
 [MarginProperty]: https://developers.line.biz/en/docs/messaging-api/flex-message-layout/#margin-property
 [Offset]: https://developers.line.biz/en/docs/messaging-api/flex-message-layout/#component-offset
 [GravityProperty]: https://developers.line.biz/en/docs/messaging-api/flex-message-layout/#gravity-property
 
 This component renders a button.
 
 When the user taps a button, a specified action is performed.
 
 - `type`: `button`
 - `action`: Action performed when this button is tapped. Specify an action object.
 - `flex`: The ratio to use for the width or height of this component within the parent element. By default, a horizontal box's components have their `flex` property set equal to `1`. By default, a vertical box's components have their `flex` property set equal to `0`. For more information, see [Width and height of components][ComponentWidthAndHeight] in the Messaging API documentation.
 - `margin`: The minimum amount of space to include before this component in its parent container. For more information, see [margin property for components][MarginProperty] in the Messaging API documentation.
 - `position`: Reference for `offsetTop`, `offsetBottom`, `offsetStart`, and `offsetEnd`. See **LineFlexMessageComponentPosition**.
 - `offsetTop`: The top offset. For more information, see [Offset] in the Messaging API documentation.
 - `offsetBottom`: The bottom offset. For more information, see [Offset] in the Messaging API documentation.
 - `offsetStart`: The left offset. For more information, see [Offset] in the Messaging API documentation.
 - `offsetEnd`: The right offset. For more information, see [Offset] in the Messaging API documentation.
 - `height`: Height of the button. You can specify `sm` or `md`. The default value is `md`.
 - `style`: Style of the button. See **Style**. The default value is `link`.
 - `color`: Character color when the `style` property is `link`. Background color when the `style` property is `primary` or `secondary`. Use a hexadecimal color code.
 - `gravity`: Alignment style in vertical direction. For more information, see [Vertical alignment][GravityProperty] in the Messaging API documentation.
 - `adjustMode`: The method by which to adjust the text font size. See **AdjustMode**.
 */
public struct LineFlexMessageButtonComponent: LineFlexMessageComponent {
    
    public var type: LineFlexMessageComponentType = .button
    public var action: LineActionObject
    public var flex: Double?
    public var margin: String?
    public var position: LineFlexMessageComponentPosition?
    public var offsetTop: String?
    public var offsetBottom: String?
    public var offsetStart: String?
    public var offsetEnd: String?
    public var height: Height?
    public var style: Style?
    public var color: String?
    public var gravity: LineFlexMessageComponentVerticalAlignment?
    public var adjustMode: LineFlexMessageComponentAdjustMode?
}

// MARK: - Height
extension LineFlexMessageButtonComponent {
    
    /**
     - `sm`
     - `md`
     */
    public enum Height: String, Codable {
        case sm
        case md
    }
}

// MARK: - Style
extension LineFlexMessageButtonComponent {
    
    /**
     - `primary`: Style for dark color buttons
     - `secondary`: Style for light color buttons
     - `link`: HTML link style
     */
    public enum Style: String, Codable {
        case primary
        case secondary
        case link
    }
}

// MARK: - Codable
extension LineFlexMessageButtonComponent: Codable {
    
    enum CodingKeys: String, CodingKey {
        case  type
        case  action
        case  flex
        case  margin
        case  position
        case  offsetTop
        case  offsetBottom
        case  offsetStart
        case  offsetEnd
        case  height
        case  style
        case  color
        case  gravity
        case  adjustMode
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.type = try container.decode(LineFlexMessageComponentType.self, forKey: .type)
        
        let action = try container.decode(LineActionObjectPrototype.self, forKey: .action)
        
        switch action.type {
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
        }
        
        self.flex = try container.decodeIfPresent(Double.self, forKey: .flex)
        self.margin = try container.decodeIfPresent(String.self, forKey: .margin)
        self.position = try container.decodeIfPresent(LineFlexMessageComponentPosition.self, forKey: .position)
        self.offsetTop = try container.decodeIfPresent(String.self, forKey: .offsetTop)
        self.offsetBottom = try container.decodeIfPresent(String.self, forKey: .offsetBottom)
        self.offsetStart = try container.decodeIfPresent(String.self, forKey: .offsetStart)
        self.offsetEnd = try container.decodeIfPresent(String.self, forKey: .offsetEnd)
        self.height = try container.decodeIfPresent(Height.self, forKey: .height)
        self.style = try container.decodeIfPresent(Style.self, forKey: .style)
        self.color = try container.decodeIfPresent(String.self, forKey: .color)
        self.gravity = try container.decodeIfPresent(LineFlexMessageComponentVerticalAlignment.self, forKey: .gravity)
        self.adjustMode = try container.decodeIfPresent(LineFlexMessageComponentAdjustMode.self, forKey: .adjustMode)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.type, forKey: .type)
        
        switch self.action.type {
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
        }
        
        try container.encodeIfPresent(self.flex, forKey: .flex)
        try container.encodeIfPresent(self.margin, forKey: .margin)
        try container.encodeIfPresent(self.position, forKey: .position)
        try container.encodeIfPresent(self.offsetTop, forKey: .offsetTop)
        try container.encodeIfPresent(self.offsetBottom, forKey: .offsetBottom)
        try container.encodeIfPresent(self.offsetStart, forKey: .offsetStart)
        try container.encodeIfPresent(self.offsetEnd, forKey: .offsetEnd)
        try container.encodeIfPresent(self.height, forKey: .height)
        try container.encodeIfPresent(self.style, forKey: .style)
        try container.encodeIfPresent(self.color, forKey: .color)
        try container.encodeIfPresent(self.gravity, forKey: .gravity)
        try container.encodeIfPresent(self.adjustMode, forKey: .adjustMode)
    }
}
