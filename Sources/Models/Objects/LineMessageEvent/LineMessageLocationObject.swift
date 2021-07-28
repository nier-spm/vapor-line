import Foundation

public struct LineMessageLocationObject: LineMessageEventObject, Codable {
    
    public var id: String
    public var type: LineMessageEventObjectType = .location
    public var title: String
    public var address: String
    public var latitude: Double
    public var longitude: Double
}
