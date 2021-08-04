import Foundation

/**
 [LineURL]: https://developers.line.biz/en/docs/messaging-api/using-line-url-scheme/
 
 - `type`: `uri`
 - `label`: See **LineImagemapMessageAction**
 - `linkURI`: Webpage URL.
    - Max character limit: 1000
    - The available schemes are `http`, `https`, `line`, and `tel`. For more information about the LINE URL scheme, see [Using LINE features with the LINE URL scheme][LineURL].
 - `area`: See **LineImagemapMessageObjectArea**
 */
public struct LineImagemapMessageURIAction: LineImagemapMessageAction {
    
    public var type: LineImagemapMessageActionType = .uri
    public var label: String?
    public var linkURI: String
    public var area: LineImagemapMessageObjectArea
}

extension LineImagemapMessageURIAction: Codable {}
