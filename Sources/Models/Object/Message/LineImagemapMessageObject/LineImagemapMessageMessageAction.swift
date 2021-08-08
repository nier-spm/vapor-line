import Foundation

/**
 - `type`: `message`
 - `label`: See **LineImagemapMessageAction**
 - `text`: Message to send
    - Max character limit: 400
 - `area`: See **LineImagemapMessageObjectArea**
 */
public struct LineImagemapMessageMessageAction: LineImagemapMessageAction {
    
    public var type: LineImagemapMessageActionType = .message
    public var label: String?
    public var text: String
    public var area: LineAreaObject
}

extension LineImagemapMessageMessageAction: Codable {}
