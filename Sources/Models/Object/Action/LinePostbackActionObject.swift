import Foundation

/**
 When a control associated with this action is tapped, a postback event is returned via webhook with the specified string in the data property.
 
 - `type`: `postback`
 - `label`: Label for the action.
    - Required for templates other than image carousel. Max character limit: 20
    - Optional for image carousel templates. Max character limit: 12
    - Optional for rich menus. Spoken when the accessibility feature is enabled on the client device. Max character limit: 20. Supported on LINE 8.2.0 or later for iOS.
    - Required for quick reply buttons. Max character limit: 20. Supported on LINE 8.11.0 or later for both LINE for iOS and LINE for Android.
    - Required for the button of Flex Message. This property can be specified for the box, image, and text but its value is not displayed. Max character limit: 40
 - `data`: String returned via webhook in the `postback.data` property of the postback event.
    - Max character limit: 300
 - `displayText`: Text displayed in the chat as a message sent by the user when the action is performed. Required for quick reply buttons. Optional for the other message types.
     - Max character limit: 300
     - The displayText and text properties cannot both be used at the same time.
 - `text`: **[Deprecated]** Text displayed in the chat as a message sent by the user when the action is performed. Returned from the server through a webhook. This property shouldn't be used with quick reply buttons.
    - Max character limit: 300
    - The displayText and text properties cannot both be used at the same time.
 */
public struct LinePostbackActionObject: LineActionObject {
    
    public var type: LineActionObjectType = .postback
    public var label: String?
    public var data: String
    public var displayText: String?
    public var text: String?
}

// MARK: - Codable
extension LinePostbackActionObject: Codable {}
