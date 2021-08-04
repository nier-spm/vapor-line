import Foundation

// MARK: - [ Protocol ] LineImagemapMessageAction
/**
 Object which specifies the actions and tappable areas of an imagemap.
 
 When an area is tapped, the user is redirected to the URI specified in `uri` and the message specified in `message` is sent.
 
 - `type`: Type of Action.
 - `label`: Label for the action. Spoken when the accessibility feature is enabled on the client device.
    - Max character limit: 50
    - Supported on LINE 8.2.0 or later for iOS.
 - `linkURI`: Webpage URL.
    - Max character limit: 1000
    - The available schemes are `http`, `https`, `line`, and `tel`. For more information about the LINE URL scheme, see [Using LINE features with the LINE URL scheme][LineURL].
 - `area`: Defined tappable area. See **LineImagemapMessageObjectArea**
 */
public protocol LineImagemapMessageAction {
    var type: LineImagemapMessageActionType { get }
    var label: String? { get set }
    var area: LineImagemapMessageObjectArea { get set }
}

// MARK: - LineImagemapMessageActionType
/**
 - `uri`
 - `message`
 */
public enum LineImagemapMessageActionType: String, Codable {
    case uri
    case message
}
