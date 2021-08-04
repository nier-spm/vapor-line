import Foundation

/**
 [block]: https://developers.line.biz/en/docs/messaging-api/flex-message-elements/#block
 
 This is a container that contains one message bubble.
 
 It can contain four blocks: header, hero, body, and footer.
 
 For more information about using each block, see [Block][block] in the API documentation.
 
 The maximum size of JSON data that defines a bubble is 30 KB.
 
 - `type`: `bubble`
 - `size`: The size of the bubble. See **Size**.
 - `direction`: Text directionality and the direction of placement of components in horizontal boxes. See **Direction**
 - `header`: Header block.
 - `hero`: Hero block.
 - `body`: Body block.
 - `footer`: Footer block.
 - `styles`: Style of each block. See **BubbleStyle**.
 - `action`: Action performed when this image is tapped. Specify an action object. This property is supported on the following versions of LINE.
    - LINE for iOS and Android: 8.11.0 or later
 */
public struct LineFlexMessageBubbleContainer: LineFlexMessageContainer {
    
    public var type: LineFlexMessageContainerType = .bubble
    public var size: Size?
    public var direction: Direction?
    public var header: LineFlexMessageBoxComponent?
    public var hero: LineFlexMessageComponent?
    public var body: LineFlexMessageBoxComponent?
    public var footer: LineFlexMessageBoxComponent?
    public var styles: BubbleStyle?
    public var action: LineActionObject?
}

// MARK: - Initializer
extension LineFlexMessageBubbleContainer {
    
    public init(size: Size? = nil,
                direction: Direction? = nil,
                header: LineFlexMessageBoxComponent? = nil,
                hero: LineFlexMessageBoxComponent? = nil,
                body: LineFlexMessageBoxComponent? = nil,
                footer: LineFlexMessageBoxComponent? = nil,
                styles: BubbleStyle? = nil) {
        self.size = size
        self.direction = direction
        self.header = header
        self.hero = hero
        self.body = body
        self.footer = footer
        self.styles = styles
    }
    
    public init(size: Size? = nil,
                direction: Direction? = nil,
                header: LineFlexMessageBoxComponent? = nil,
                hero: LineFlexMessageImageComponent? = nil,
                body: LineFlexMessageBoxComponent? = nil,
                footer: LineFlexMessageBoxComponent? = nil,
                styles: BubbleStyle? = nil) {
        self.size = size
        self.direction = direction
        self.header = header
        self.hero = hero
        self.body = body
        self.footer = footer
        self.styles = styles
    }
}

// MARK: - Size
extension LineFlexMessageBubbleContainer {
    
    /**
     You can specify one of the following values: `nano`, `micro`, `kilo`, `mega`, or `giga`. The default value is `mega`.
     
     - `nano`
     - `micro`
     -  `kilo`
     -  `mega`
     -  `giga`
     */
    public enum Size: String, Codable {
        case nano
        case micro
        case kilo
        case mega
        case giga
    }
}

// MARK: - Direction
extension LineFlexMessageBubbleContainer {
    
    /**
     - `leftToRight(ltr)`: The text is left-to-right horizontal writing, and the components are placed from left to right
     -  `rightToLeft(rtl)`: The text is right-to-left horizontal writing, and the components are placed from right to left
     
     The default value is `leftToRight(ltr)`.
     */
    public enum Direction: String, Codable {
        case leftToRight = "ltr"
        case rightToLeft = "rtl"
    }
}

// MARK: - BubbleStyle & BlockStyle
extension LineFlexMessageBubbleContainer {
    
    /**
     - `header`: Header block. See **BlockStyle**.
     - `hero`: Hero block. See **BlockStyle**.
     - `body`: Body block. See **BlockStyle**.
     - `footer`: Footer block. See **BlockStyle**.
     */
    public struct BubbleStyle: Codable {
        
        public var header: BlockStyle?
        public var hero: BlockStyle?
        public var body: BlockStyle?
        public var footer: BlockStyle?
    }
    
    /**
     - `backgroundColor`: Background color of the block. Use a hexadecimal color code.
     -  `separator`: `true` to place a separator above the block. The default value is `false`.
     -  `separatorColor`: Color of the separator. Use a hexadecimal color code.
     */
    public struct BlockStyle: Codable {
        
        public var backgroundColor: String?
        public var separator: Bool?
        public var separatorColor: String?
    }
}

// MARK: - Codable
extension LineFlexMessageBubbleContainer: Codable {
    
    enum CodingKeys: String, CodingKey {
        case type
        case size
        case direction
        case header
        case hero
        case body
        case footer
        case styles
        case action
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.type = try container.decode(LineFlexMessageContainerType.self, forKey: .type)
        self.size = try container.decodeIfPresent(Size.self, forKey: .size)
        self.direction = try container.decodeIfPresent(Direction.self, forKey: .direction)
        self.header = try container.decodeIfPresent(LineFlexMessageBoxComponent.self, forKey: .header)
        
        let component = try container.decodeIfPresent(LineFlexMessageComponentPrototype.self, forKey: .hero)
        
        switch component?.type {
        case .box:
            let box = try container.decode(LineFlexMessageBoxComponent.self, forKey: .hero)
            self.hero = box
        case .button:
            let button = try container.decode(LineFlexMessageButtonComponent.self, forKey: .hero)
            self.hero = button
        case .image:
            let image = try container.decode(LineFlexMessageImageComponent.self, forKey: .hero)
            self.hero = image
        case .icon:
            let icon = try container.decode(LineFlexMessageIconComponent.self, forKey: .hero)
            self.hero = icon
        case .text:
            let text = try container.decode(LineFlexMessageTextComponent.self, forKey: .hero)
            self.hero = text
        case .span:
            let span = try container.decode(LineFlexMessageSpanComponent.self, forKey: .hero)
            self.hero = span
        case .separator:
            let separator = try container.decode(LineFlexMessageSeparatorComponent.self, forKey: .hero)
            self.hero = separator
        case .filler:
            let filler = try container.decode(LineFlexMessageFillerComponent.self, forKey: .hero)
            self.hero = filler
        case .none:
            break
        }
        
        self.body = try container.decodeIfPresent(LineFlexMessageBoxComponent.self, forKey: .body)
        self.footer = try container.decodeIfPresent(LineFlexMessageBoxComponent.self, forKey: .footer)
        self.styles = try container.decodeIfPresent(BubbleStyle.self, forKey: .styles)
        
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
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.type, forKey: .type)
        try container.encodeIfPresent(self.size, forKey: .size)
        try container.encode(self.direction, forKey: .direction)
        try container.encode(self.header, forKey: .header)
        
        switch self.hero?.type {
        case .box:
            let box = self.hero as! LineFlexMessageBoxComponent
            try container.encode(box, forKey: .hero)
        case .button:
            let button = self.hero as! LineFlexMessageButtonComponent
            try container.encode(button, forKey: .hero)
        case .image:
            let image = self.hero as! LineFlexMessageImageComponent
            try container.encode(image, forKey: .hero)
        case .icon:
            let icon = self.hero as! LineFlexMessageIconComponent
            try container.encode(icon, forKey: .hero)
        case .text:
            let text = self.hero as! LineFlexMessageTextComponent
            try container.encode(text, forKey: .hero)
        case .span:
            let span = self.hero as! LineFlexMessageSpanComponent
            try container.encode(span, forKey: .hero)
        case .separator:
            let separator = self.hero as! LineFlexMessageSeparatorComponent
            try container.encode(separator, forKey: .hero)
        case .filler:
            let filler = self.hero as! LineFlexMessageFillerComponent
            try container.encode(filler, forKey: .hero)
        case .none:
            break
        }
        
        try container.encodeIfPresent(self.body, forKey: .body)
        try container.encodeIfPresent(self.footer, forKey: .footer)
        try container.encodeIfPresent(self.styles, forKey: .styles)
        
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
    }
}
