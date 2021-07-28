import Foundation

public struct LineMessageImageObject: LineMessageEventObject, Codable {
    
    public var id: String
    public var type: LineMessageEventObjectType = .image
    public var contentProvider: LineMessageMediaContent
}
