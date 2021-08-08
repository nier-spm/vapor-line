import Foundation

/**
 Message object which contains the image content sent from the source.
 
 - `id`: Message ID.
 - `type`: `image`
 - `contentProvider`: Provider of the image file. See **LineMessageMediaContent**.
 */
public struct LineMessageImageObject: LineMessageEventObject {
    
    public var id: String
    public var type: LineMessageEventObjectType = .image
    public var contentProvider: LineMessageMediaContent
}

// MARK: Codable
extension LineMessageImageObject: Codable {}
