import Foundation

/**
 - `name`: Display name. Certain words such as `LINE` may not be used.
    - Max character limit: 20
 - `iconURL`: URL of the image to display as an icon when sending a message
    - Max character limit: 1000
    - URL scheme: https
    - Image format: PNG
    - Aspect ratio: 1:1
    - Data size: Up to 1 MB
 */
public struct LineMessageObjectSender {
    
    public var name: String?
    public var iconURL: String?
}

// MARK: - LineMessageObjectSender Initializer
extension LineMessageObjectSender {
    
    public init(name: String, iconURL: String) {
        self.name = name
        self.iconURL = iconURL
    }
    
    public init(name: String) {
        self.name = name
    }
    
    public init(iconURL: String) {
        self.iconURL = iconURL
    }
}

// MARK: - Codable
extension LineMessageObjectSender: Codable {
    
    enum CodingKeys: String, CodingKey {
        case name
        case iconURL = "iconUrl"
    }
}
