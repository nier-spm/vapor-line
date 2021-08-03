import Foundation

/**
 [LocationMessage]: https://developers.line.biz/en/reference/messaging-api/#location-message
 
 - `type`: `location`
 - `title`: Title.
    - Max character limit: 100
 - `address`: Address.
    - Max character limit: 100
 - `latitude`: Latitude.
 - `longitude`: Longitude.
 - `sender`: See **LineMessageObjectSender**.
 - `quickReply`: See **Common Properties**.
 
 # Reference
 [Location Message | LINE Developers][LocationMessage]
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
