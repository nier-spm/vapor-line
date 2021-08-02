import Foundation

public struct LineImagemapMessageMessageAction: LineImagemapMessageAction {
    
    public var type: LineImagemapMessageActionType = .message
    public var label: String?
    public var text: String
    public var area: LineImagemapMessageObjectArea
}

extension LineImagemapMessageMessageAction: Codable {}
