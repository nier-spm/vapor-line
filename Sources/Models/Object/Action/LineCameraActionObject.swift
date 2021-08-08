import Foundation

/**
 This action can be configured only with quick reply buttons.
 
 When a button associated with this action is tapped, the camera screen in LINE is opened.
 
 - `type`: `camera`
 - `label`: Label for the action.
    - Max character limit: 20
 */
public struct LineCameraActionObject: LineActionObject {
    
    public var type: LineActionObjectType = .camera
    public var label: String
}

// MARK: - Codable
extension LineCameraActionObject: Codable {}
