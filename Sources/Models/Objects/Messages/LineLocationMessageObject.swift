import Foundation

/**
 - `type`: `location`
 - `title`: Title.
    - Max character limit: 100
 - `address`: Address.
    - Max character limit: 100
 - `latitude`: Latitude.
 - `longitude`: Longitude.
 - `sender`: See **LineMessageObjectSender**.
 - `quickReply`: See **Common Properties**.
 */
public struct LineLocationMessageObject: LineMessageObject {
    
    public var type: LineMessageObjectType = .location
    public var title: String
    public var address: String
    public var latitude: Double
    public var longitude: Double
    public var sender: LineMessageObjectSender?
    public var quickReply: LineMessageObjectQuickReply?
}

// MARK: Codable
extension LineLocationMessageObject: Codable {}
