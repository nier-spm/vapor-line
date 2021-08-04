import Foundation

/**
 This action can be configured only with quick reply buttons.
 
 When a button associated with this action is tapped, the location screen in LINE is opened.
 
 - `type`: `location`
 - `label`: Label for the action.
    - Max character limit: 20
 */
public struct LineLocationActionObject: LineActionObject {
    
    public var type: LineActionObjectType = .location
    public var label: String
}

// MARK: - Codable
extension LineLocationActionObject: Codable {}
