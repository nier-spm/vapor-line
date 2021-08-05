import Foundation

/**
 - `width`: Width of the size in pixels.
 - `height`: Height of the size in pixels.
 */
public struct LineSizeObject {
    
    public var width: Double
    public var height: Double
}

// MARK: - Codable
extension LineSizeObject: Codable {}
