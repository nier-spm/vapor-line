import Foundation

/**
 [CreateRichmeun]: https://developers.line.biz/en/reference/messaging-api/#create-rich-menu
 [GetRichmenu]: https://developers.line.biz/en/reference/messaging-api/#get-rich-menu
 [GetRichmenuList]: https://developers.line.biz/en/reference/messaging-api/#get-rich-menu-list
 [ActionObjects]: https://developers.line.biz/en/reference/messaging-api/#action-objects
 
 Rich menus consist of either of these objects.
 
 - Rich menu object without the rich menu ID. Use this object when you [create a rich menu][CreateRichmeun].
 
 - Rich menu response object with the rich menu ID. This object is returned when you [get a rich menu][GetRichmenu] or [get a list of rich menus][GetRichmenuList].
 
 Area objects and [action objects][ActionObjects] are included in these objects.
 
 - `size`: size object which contains the width and height of the rich menu displayed in the chat. The width of the rich menu image must be between 800px and 2500px. The height must be at least 250px. However, the aspect ratio of width to height must be at least 1.45.
     - `width`: Width of the rich menu. Must be `2500`.
     - `height`: Height of the rich menu. Possible values: `1686`, `843`.
 - `selected`: `true` to display the rich menu by default. Otherwise, `false`
 - `name`: Name of the rich menu. This value can be used to help manage your rich menus and is not displayed to users.
    - Max character limit: 300.
 - `chatBarText`: Text displayed in the chat bar.
    - Max character limit: 14
 - `areas`: Array of area objects which define the coordinates and size of tappable areas. See **LineRichmenuAreaObject**.
    - Max: 20 area objects
 */
public struct LineRichmenuObject {
    
    public var size: LineSizeObject
    public var selected: Bool
    public var name: String
    public var chatBarText: String
    public var areas: [LineRichmenuAreaObject]
}

// MARK: - Codable
extension LineRichmenuObject: Codable {}
