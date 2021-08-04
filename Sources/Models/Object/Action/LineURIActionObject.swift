import Foundation

/**
 [UsingLineURLScheme]: https://developers.line.biz/en/docs/messaging-api/using-line-url-scheme/
 When a control associated with this action is tapped, the URI specified in the `uri` property is opened in LINE's in-app browser.
 
 - `type`: `uri`
 - `label`: Label for the action.
    - Required for templates other than image carousel. Max character limit: 20
    - Optional for image carousel templates. Max character limit: 12
    - Optional for rich menus. Spoken when the accessibility feature is enabled on the client device. Max character limit: 20. Supported on LINE 8.2.0 or later for iOS.
    - Required for the button of Flex Message. This property can be specified for the box, image, and text but its value is not displayed. Max character limit: 40
    - Required for quick reply. Max character limit: 20
 - `uri`: URI opened when the action is performed (Max character limit: 1000).
    - The available schemes are `http`, `https`, `line`, and `tel`. For more information about the LINE URL scheme, see [Using LINE features with the LINE URL scheme][UsingLineURLScheme].
 - `altURI`: URI opened on LINE for macOS and Windows when the action is performed (Max character limit: 1000).
 
    If the `altURI.desktop` property is set, the `uri` property is ignored on LINE for macOS and Windows.
 
    The available schemes are `http`, `https`, `line`, and `tel`. For more information about the LINE URL scheme, see [Using LINE features with the LINE URL scheme][UsingLineURLScheme]. This property is supported on the following version of LINE.
 
    - 5.12.0 or later for both LINE for macOS and LINE for Windows
 */
public struct LineURIActionObject: LineActionObject {
    
    public var type: LineActionObjectType = .uri
    public var label: String?
    public var uri: String
    public var altURI: String
}

// MARK: - AltURI
extension LineURIActionObject {
    
    public struct AltURI: Codable {
        var desktop: String
    }
}

// MARK: - Codable
extension LineURIActionObject: Codable {}
