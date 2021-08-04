import Foundation

/**
 Template with two action buttons.
 
 - `type`: `confirm`
 - `text`: Message text.
    - Max character limit: 240
 -  `actions`: Action when tapped.
    - Set 2 actions for the 2 buttons
 */
public struct LineTemplateMessageConfirmTemplate: LineTemplateMessageTemplate {
    
    public var type: LineTemplateMessageTemplateType = .confirm
    public var text: String
    public var actions: [LineActionObject] = []
}

// MARK: - Codable
extension LineTemplateMessageConfirmTemplate: Codable {
    
    enum CodingKeys: String, CodingKey {
        case type
        case text
        case actions
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.type = try container.decode(LineTemplateMessageTemplateType.self, forKey: .type)
        self.text = try container.decode(String.self, forKey: .text)
        
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
        try container.encode(self.text, forKey: .text)
        
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
