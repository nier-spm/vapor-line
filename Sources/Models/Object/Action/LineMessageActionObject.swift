import Foundation

/**
 When a control associated with this action is tapped, the string in the `text` property is sent as a message from the user.
 
 - `type`: `message`
 - `label`: Label for the action.
    - Required for templates other than image carousel. Max character limit: 20
    - Optional for image carousel templates. Max character limit: 12
    - Optional for rich menus. Spoken when the accessibility feature is enabled on the client device. Max character limit: 20. Supported on LINE 8.2.0 or later for iOS.
    - Required for quick reply buttons. Max character limit: 20. Supported on 8.11.0 or later for both LINE for iOS and LINE for Android.
    - Required for the button of Flex Message. This property can be specified for the box, image, and text but its value is not displayed. Max charater limit: 40
 - `text`: Text sent when the action is performed.
     - Max character limit: 300
 */
public struct LineMessageActionObject: LineActionObject {
    
    public var type: LineActionObjectType = .message
    public var label: String?
    public var text: String
}

// MARK: - Codable
extension LineMessageActionObject: Codable {}
