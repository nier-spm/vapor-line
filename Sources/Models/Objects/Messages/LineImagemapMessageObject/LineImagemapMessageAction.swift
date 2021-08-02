import Foundation

// MARK: - [Protocol] LineImagemapMessageAction
public protocol LineImagemapMessageAction {
    var type: LineImagemapMessageActionType { get }
    var label: String? { get set }
    var area: LineImagemapMessageObjectArea { get set }
}

public enum LineImagemapMessageActionType: String, Codable {
    case uri
    case message
}
