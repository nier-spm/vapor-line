import Foundation

public struct LineImagemapMessageURIAction: LineImagemapMessageAction {
    
    public var type: LineImagemapMessageActionType = .uri
    public var label: String?
    public var linkURI: String
    public var area: LineImagemapMessageObjectArea
}

extension LineImagemapMessageURIAction: Codable {}
