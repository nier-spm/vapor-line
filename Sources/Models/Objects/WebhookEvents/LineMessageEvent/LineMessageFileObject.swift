import Foundation

public struct LineMessageFileObject: LineMessageEventObject, Codable {
    
    public var id: String
    public var type: LineMessageEventObjectType = .file
    public var fileName: String
    public var fileSize: Int
}
