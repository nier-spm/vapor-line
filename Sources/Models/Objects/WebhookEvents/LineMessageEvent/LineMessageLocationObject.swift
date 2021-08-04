import Foundation

/**
 Message object which contains the location data sent from the source.
 
 - `id`: Message ID.
 - `type`: `location`
 - `title`: Title.
 - `address`: Address.
 - `latitude`: Latitude.
 - `longitude`: Longitude.
 */
public struct LineMessageLocationObject: LineMessageEventObject {
    
    public var id: String
    public var type: LineMessageEventObjectType = .location
    public var title: String?
    public var address: String
    public var latitude: Double
    public var longitude: Double
}

// MARK: - Codable
extension LineMessageLocationObject: Codable {}
