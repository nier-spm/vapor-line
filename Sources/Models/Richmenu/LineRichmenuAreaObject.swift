import Foundation

/**
 - `bounds`: Object describing the boundaries of the area in pixels. See **LineAreaObject**.
 - `action`: Action performed when the area is tapped. See **LineActionObject**.
 */
public struct LineRichmenuAreaObject {
    
    public var bounds: LineAreaObject
    public var action: LineActionObject
}

// MARK: - Codable
extension LineRichmenuAreaObject: Codable {
    
    enum CodingKeys: String, CodingKey {
        case bounds
        case action
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.bounds = try container.decode(LineAreaObject.self, forKey: .bounds)
        
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
        
        try container.encode(self.bounds, forKey: .bounds)
        
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
