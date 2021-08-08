import Foundation

/**
 Template with multiple images which can be cycled like a carousel.
 
 The images are shown in order when scrolling horizontally.
 
 - `type`: `imageCarousel`
 - `columns`: Array of columns.
    - Max columns: 10
 */
public struct LineTemplateMessageImageCarouselTemplate: LineTemplateMessageTemplate {
    
    public var type: LineTemplateMessageTemplateType = .imageCarousel
    public var columns: [Column]
}

// MARK: - LineTemplateMessageImageCarouselTemplate
extension LineTemplateMessageImageCarouselTemplate {
    
    /**
     Column object for image carousel.
     
     - `imageURL`: Image URL (Max character limit: 1,000).
        - **HTTPS** over **TLS 1.2** or later
        - JPEG or PNG
        - Aspect ratio: 1:1
        - Max width: 1024px
        - Max file size: 10 MB
     - `action`: Action when image is tapped.
     */
    public struct Column {
        public var imageURL: String
        public var action: LineActionObject
    }
}

// MARK: - LineTemplateMessageImageCarouselTemplate.Column.Codable
extension LineTemplateMessageImageCarouselTemplate.Column: Codable {
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "imageUrl"
        case action
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.imageURL = try container.decode(String.self, forKey: .imageURL)
        
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
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.imageURL, forKey: .imageURL)
        
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
    }
}

// MARK: - LineTemplateMessageImageCarouselTemplate.Codable
extension LineTemplateMessageImageCarouselTemplate: Codable {}
