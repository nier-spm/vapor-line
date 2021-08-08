import Foundation

/**
 Message object which contains the file sent from the source.
 
 The binary data can be retrieved from the content endpoint.
 
 - `id`: Message ID.
 - `type`: `file`
 - `fileName`: File name.
 - `fileSize`: File size in bytes.
 */
public struct LineMessageFileObject: LineMessageEventObject {
    
    public var id: String
    public var type: LineMessageEventObjectType = .file
    public var fileName: String
    public var fileSize: Int
}

// MARK: - Codable
extension LineMessageFileObject: Codable {}
