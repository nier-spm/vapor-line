import Foundation

/**
 Defines the size of a tappable area.
 
 The top left is used as the origin of the area.
 
 Set these properties based on the `baseSize.width` property and the `baseSize.height` property.
 
 - `x`: Horizontal position relative to the left edge of the area. Value must be **0** or higher.
 - `y`: Vertical position relative to the top of the area. Value must be **0** or higher.
 - `width`: Width of the tappable area
 - `height`: Height of the tappable area
 */
public struct LineImagemapMessageObjectArea {
    
    var x: Double
    var y: Double
    var width: Double
    var height: Double
}

extension LineImagemapMessageObjectArea: Codable {}
