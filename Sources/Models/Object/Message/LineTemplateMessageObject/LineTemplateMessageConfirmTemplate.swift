import Foundation

/**
 Template with two action buttons.
 
 - `type`: `confirm`
 - `text`: Message text.
    - Max character limit: 240
 -  `actions`: Action when tapped.
    - Set 2 actions for the 2 buttons
 */
public struct LineTemplateMessageConfirmTemplate: LineTemplateMessageTemplate {
    
    public var type: LineTemplateMessageTemplateType = .confirm
    public var text: String
//    public var actions: [ActionObject]
}

extension LineTemplateMessageConfirmTemplate: Codable {}
