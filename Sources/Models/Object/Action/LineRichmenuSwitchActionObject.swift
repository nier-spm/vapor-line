import Foundation

/**
 [SwitchingBetweenMultipleRichmenu]: https://developers.line.biz/en/docs/messaging-api/using-rich-menus/#switching-between-multiple-rich-menus
 This action can be configured only with rich menus.
 
 It can't be used for Flex Messages or quick replies.When you tap a rich menu associated with this action, you can switch between rich menus, and a postback event including the rich menu alias ID selected by the user is returned via a webhook. For more information, see [Switching between multiple rich menus][SwitchingBetweenMultipleRichmenu] in the Messaging API documentation.
 
 - `type`: `richmenuSwitch`
 - `label`: Action label. Optional for rich menus. Read when the user's device accessibility feature is enabled.
    - Max character limit: 20
    - Supported on LINE for iOS 8.2.0 or later.
 - `richMenuAliasID`: Rich menu alias ID to switch to.
 - `data`: String returned by the `postback.data` property of the postback event via a webhook.
    - Max character limit: 300
 */
public struct LineRichmenuSwitchActionObject: LineActionObject {
    
    public var type: LineActionObjectType = .richmenuSwitch
    public var label: String?
    public var richMenuAliasID: String
    public var data: String
}

// MARK: - Codable
extension LineRichmenuSwitchActionObject: Codable {
    
    enum CodingKeys: String, CodingKey {
        case type
        case label
        case richMenuAliasID = "richMenuAliasId"
        case data
    }
}
