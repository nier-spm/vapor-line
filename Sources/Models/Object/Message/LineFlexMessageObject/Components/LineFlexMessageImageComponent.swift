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
    public var action: LineActionObject?
    public var animated: Bool?
}

// MARK: - Codable
extension LineFlexMessageImageComponent: Codable {
    
    enum CodingKeys: String, CodingKey {
        case type
        case url
        case flex
        case margin
        case position
        case offsetTop
        case offsetBottom
        case offsetStart
        case offsetEnd
        case align
        case gravity
        case size
        case aspectRatio
        case aspectMode
        case backgroundColor
        case action
        case animated
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.type = try container.decode(LineFlexMessageComponentType.self, forKey: .type)
        self.url = try container.decode(String.self, forKey: .url)
        self.flex = try container.decodeIfPresent(Double.self, forKey: .flex)
        self.margin = try container.decodeIfPresent(String.self, forKey: .margin)
        self.position = try container.decodeIfPresent(LineFlexMessageComponentPosition.self, forKey: .position)
        self.offsetTop = try container.decodeIfPresent(String.self, forKey: .offsetTop)
        self.offsetBottom = try container.decodeIfPresent(String.self, forKey: .offsetBottom)
        self.offsetStart = try container.decodeIfPresent(String.self, forKey: .offsetStart)
        self.offsetEnd = try container.decodeIfPresent(String.self, forKey: .offsetEnd)
        self.align = try container.decodeIfPresent(LineFlexMessageComponentHorizontalAlignment.self, forKey: .align)
        self.gravity = try container.decodeIfPresent(LineFlexMessageComponentVerticalAlignment.self, forKey: .gravity)
        self.size = try container.decodeIfPresent(String.self, forKey: .size)
        self.aspectRatio = try container.decodeIfPresent(String.self, forKey: .aspectRatio)
        self.aspectMode = try container.decodeIfPresent(LineFlexMessageComponentAspectMode.self, forKey: .aspectMode)
        self.backgroundColor = try container.decodeIfPresent(String.self, forKey: .backgroundColor)
        
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
        
        self.animated = try container.decodeIfPresent(Bool.self, forKey: .animated)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.type, forKey: .type)
        try container.encode(self.url, forKey: .url)
        try container.encodeIfPresent(self.flex, forKey: .flex)
        try container.encodeIfPresent(self.margin, forKey: .margin)
        try container.encodeIfPresent(self.position, forKey: .position)
        try container.encodeIfPresent(self.offsetTop, forKey: .offsetTop)
        try container.encodeIfPresent(self.offsetBottom, forKey: .offsetBottom)
        try container.encodeIfPresent(self.offsetStart, forKey: .offsetStart)
        try container.encodeIfPresent(self.offsetEnd, forKey: .offsetEnd)
        try container.encodeIfPresent(self.align, forKey: .align)
        try container.encodeIfPresent(self.gravity, forKey: .gravity)
        try container.encodeIfPresent(self.size, forKey: .size)
        try container.encodeIfPresent(self.aspectRatio, forKey: .aspectRatio)
        try container.encodeIfPresent(self.aspectMode, forKey: .aspectMode)
        try container.encodeIfPresent(self.backgroundColor, forKey: .backgroundColor)
        
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
        
        try container.encodeIfPresent(self.animated, forKey: .animated)
    }
}
