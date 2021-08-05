import Foundation

/**
 Defines the size of a tappable area.
 
 The top left is used as the origin of the area.
 
 - `x`: Horizontal position relative to the left edge of the area. Value must be **0** or higher.
 - `y`: Vertical position relative to the top of the area. Value must be **0** or higher.
 - `width`: Width of the tappable area
 - `height`: Height of the tappable area
 */
public struct LineAreaObject {
    
    public var x: Double
    public var y: Double
    public var width: Double
    public var height: Double
}

// MARK: - Codable
extension LineAreaObject: Codable {}
