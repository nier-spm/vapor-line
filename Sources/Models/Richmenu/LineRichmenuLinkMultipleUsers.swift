import Vapor

internal struct LineRichmenuLinkMultipleUsers: Content {
    
    var menuID: String?
    var userIDs: [String]
    
    enum CodingKeys: String, CodingKey {
        case menuID = "richMenuId"
        case userIDs = "userIds"
    }
}
