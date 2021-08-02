import Foundation

public struct LineLocationMessageObject: LineMessageObject {
    
    public var type: LineMessageObjectType = .location
    public var title: String
    public var address: String
    public var latitude: Double
    public var longitude: Double
    public var quickReply: LineMessageObjectQuickReply?
}

extension LineLocationMessageObject: Codable {}
