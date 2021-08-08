import Vapor

/**
 - `richMenuID`: ID of a rich menu.
 - `size`: size object which contains the width and height of the rich menu displayed in the chat. The widths of the rich menu image must be between 800px and 2500px. The height must be at least 250px. However, the aspect ratio of width to height must be at least 1.45.
 - `selected`: `true` to display the rich menu by default. Otherwise, `false`.
 - `name`: Name of the rich menu. This value can be used to help manage your rich menus and is not displayed to users.
    - Max character limit: 300.
 - `chatBarText`: Text displayed in the chat bar.
    - Max character limit: 14
 - `areas`: Array of area objects which define the coordinates and size of tappable areas. See **LineRichmenuAreaObject**.
    - Max: 20 area objects
 */
public struct LineRichmenuResponseObject {
    
    public var richMenuID: String
    public var size: LineSizeObject?
    public var selected: Bool?
    public var name: String?
    public var chatBarText: String?
    public var areas: [LineRichmenuAreaObject]?
}

// MARK: - Content
extension LineRichmenuResponseObject: Content {
    
    enum CodingKeys: String, CodingKey {
        case richMenuID = "richMenuId"
        case size
        case selected
        case name
        case chatBarText
        case areas
    }
}
