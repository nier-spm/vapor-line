import Vapor

/**
 - `aliasID`: Rich menu alias ID.
 - `menuID`: The rich menu ID associated with the rich menu alias.
 */
public struct LineRichmenuAliasResponse {
    
    var aliasID: String
    var menuID: String
}

// MARK: - Content
extension LineRichmenuAliasResponse: Content {
    
    enum CodingKeys: String, CodingKey {
        case aliasID = "richMenuAliasId"
        case menuID = "richMenuId"
    }
}
