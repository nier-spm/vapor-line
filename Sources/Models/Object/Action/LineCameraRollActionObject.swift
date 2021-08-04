import Foundation

/**
 This action can be configured only with quick reply buttons.
 
 When a button associated with this action is tapped, the camera roll screen in LINE is opened.
 
 - `type`: `cameraRoll`
 - `label`: Label for the action.
    - Max character limit: 20
 */
public struct LineCameraRollActionObject: LineActionObject {
    
    public var type: LineActionObjectType = .cameraRoll
    public var label: String
}

// MARK: - Codable
extension LineCameraRollActionObject: Codable {}
