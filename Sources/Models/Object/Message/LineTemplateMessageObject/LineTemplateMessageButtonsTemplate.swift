import Foundation

/**
 Template with an image, title, text, and multiple action buttons.
 
 - `type`: `buttons`.
 - `thumbnailImageURL`: To avoid delays in displaying messages, keep the size of individual image files small (1 MB or less recommended).
    - Image URL (Max character limit: 1,000)
    - **HTTPS** over **TLS 1.2** or later
    - JPEG or PNG
    - Max width: 1024px
    - Max file size: 10 MB
 -  `imageAspectRatio`: See **LineTemplateMessageImageAspectRatio**.
 - `imageSize`: See **LineTemplateMessageImageSize**.
 - `imageBackgroundColor`: Background color of the image. Specify a RGB color value. Default: `#FFFFFF` (white).
 - `title`: Title.
 - `text`: Message text.
    - Max character limit: 160 (no image or title)
    - Max character limit: 60 (message with an image or title)
 - `defaultAction`: Action when image, title or text area is tapped.
 - `actions`: Action when tapped.
    - Max objects: 4
 */
public struct LineTemplateMessageButtonsTemplate: LineTemplateMessageTemplate {
    
    public var type: LineTemplateMessageTemplateType = .buttons
    public var thumbnailImageURL: String?
    public var imageAspectRatio: LineTemplateMessageImageAspectRatio?
    public var imageSize: LineTemplateMessageImageSize?
    public var imageBackgroundColor: String?
    public var title: String?
    public var text: String
    public var defaultAction: LineActionObject?
    public var actions: [LineActionObject] = []
}

// MARK: - Codable
extension LineTemplateMessageButtonsTemplate: Codable {
    
    enum CodingKeys: String, CodingKey {
        case type
        case thumbnailImageURL = "thumbnailImageUrl"
        case imageAspectRatio
        case imageSize
        case imageBackgroundColor
        case title
        case text
        case defaultAction
        case actions
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.type = try container.decode(LineTemplateMessageTemplateType.self, forKey: .type)
        self.thumbnailImageURL = try container.decodeIfPresent(String.self, forKey: .thumbnailImageURL)
        self.imageAspectRatio = try container.decodeIfPresent(LineTemplateMessageImageAspectRatio.self, forKey: .imageAspectRatio)
        self.imageSize = try container.decodeIfPresent(LineTemplateMessageImageSize.self, forKey: .imageSize)
        self.imageBackgroundColor = try container.decodeIfPresent(String.self, forKey: .imageBackgroundColor)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.text = try container.decode(String.self, forKey: .text)
        
        let action = try container.decodeIfPresent(LineActionObjectPrototype.self, forKey: .defaultAction)
        
        switch action?.type {
        case .postback:
            self.defaultAction = try container.decode(LinePostbackActionObject.self, forKey: .defaultAction)
        case .message:
            self.defaultAction = try container.decode(LineMessageActionObject.self, forKey: .defaultAction)
        case .uri:
            self.defaultAction = try container.decode(LineURIActionObject.self, forKey: .defaultAction)
        case .datetimePicker:
            self.defaultAction = try container.decode(LineDateTimePickerActionObject.self, forKey: .defaultAction)
        case .camera:
            self.defaultAction = try container.decode(LineCameraActionObject.self, forKey: .defaultAction)
        case .cameraRoll:
            self.defaultAction = try container.decode(LineCameraRollActionObject.self, forKey: .defaultAction)
        case .location:
            self.defaultAction = try container.decode(LineLocationActionObject.self, forKey: .defaultAction)
        case .richmenuSwitch:
            self.defaultAction = try container.decode(LineRichmenuSwitchActionObject.self, forKey: .defaultAction)
        case .none:
            break
        }
        
        let actions = try container.decode([LineActionObjectPrototype].self, forKey: .actions)
        
        var unkeyedContainer = try container.nestedUnkeyedContainer(forKey: .actions)
        
        while !unkeyedContainer.isAtEnd {
            switch actions[unkeyedContainer.currentIndex].type {
            case .postback:
                let postback = try unkeyedContainer.decode(LinePostbackActionObject.self)
                self.actions.append(postback)
            case .message:
                let message = try unkeyedContainer.decode(LineMessageActionObject.self)
                self.actions.append(message)
            case .uri:
                let uri = try unkeyedContainer.decode(LineURIActionObject.self)
                self.actions.append(uri)
            case .datetimePicker:
                let datetimePicker = try unkeyedContainer.decode(LineDateTimePickerActionObject.self)
                self.actions.append(datetimePicker)
            case .camera:
                let camera = try unkeyedContainer.decode(LineCameraActionObject.self)
                self.actions.append(camera)
            case .cameraRoll:
                let cameraRoll = try unkeyedContainer.decode(LineCameraRollActionObject.self)
                self.actions.append(cameraRoll)
            case .location:
                let location = try unkeyedContainer.decode(LineLocationActionObject.self)
                self.actions.append(location)
            case .richmenuSwitch:
                let richmenuSwitch = try
                    unkeyedContainer.decode(LineRichmenuSwitchActionObject.self)
                self.actions.append(richmenuSwitch)
            }
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.type, forKey: .type)
        try container.encodeIfPresent(self.thumbnailImageURL, forKey: .thumbnailImageURL)
        try container.encodeIfPresent(self.imageAspectRatio, forKey: .imageAspectRatio)
        try container.encodeIfPresent(self.imageSize, forKey: .imageSize)
        try container.encodeIfPresent(self.imageBackgroundColor, forKey: .imageBackgroundColor)
        try container.encodeIfPresent(self.title, forKey: .title)
        try container.encode(self.text, forKey: .text)
        
        switch self.defaultAction?.type {
        case .postback:
            let postback = self.defaultAction as! LinePostbackActionObject
            try container.encode(postback, forKey: .defaultAction)
        case .message:
            let message = self.defaultAction as! LineMessageActionObject
            try container.encode(message, forKey: .defaultAction)
        case .uri:
            let uri = self.defaultAction as! LineURIActionObject
            try container.encode(uri, forKey: .defaultAction)
        case .datetimePicker:
            let datetimePicker = self.defaultAction as! LineDateTimePickerActionObject
            try container.encode(datetimePicker, forKey: .defaultAction)
        case .camera:
            let camera = self.defaultAction as! LineCameraActionObject
            try container.encode(camera, forKey: .defaultAction)
        case .cameraRoll:
            let cameraRoll = self.defaultAction as! LineCameraRollActionObject
            try container.encode(cameraRoll, forKey: .defaultAction)
        case .location:
            let location = self.defaultAction as! LineLocationActionObject
            try container.encode(location, forKey: .defaultAction)
        case .richmenuSwitch:
            let richmenuSwitch = self.defaultAction as! LineRichmenuSwitchActionObject
            try container.encode(richmenuSwitch, forKey: .defaultAction)
        case .none:
            break
        }
        
        var unkeyedContainer = container.nestedUnkeyedContainer(forKey: .actions)
        
        for action in self.actions {
            switch action.type {
            case .postback:
                let postback = action as! LinePostbackActionObject
                try unkeyedContainer.encode(postback)
            case .message:
                let message = action as! LineMessageActionObject
                try unkeyedContainer.encode(message)
            case .uri:
                let uri = action as! LineURIActionObject
                try unkeyedContainer.encode(uri)
            case .datetimePicker:
                let datetimePicker = action as! LineDateTimePickerActionObject
                try unkeyedContainer.encode(datetimePicker)
            case .camera:
                let camera = action as! LineCameraActionObject
                try unkeyedContainer.encode(camera)
            case .cameraRoll:
                let cameraRoll = action as! LineCameraRollActionObject
                try unkeyedContainer.encode(cameraRoll)
            case .location:
                let location = action as! LineLocationActionObject
                try unkeyedContainer.encode(location)
            case .richmenuSwitch:
                let richmenuSwitch = action as! LineRichmenuSwitchActionObject
                try unkeyedContainer.encode(richmenuSwitch)
            }
        }
    }
}
