import Foundation

// MARK: - [ Protocol ] LinePostbackEventParam
/**
 # Object for date-time selection action

 - JSON object with date and time selected by the user via Datetime picker action.
 - Returned only for postback actions by Datetime picker action.
 
 # object for rich menu switch action
 
 - JSON object with rich menu alias ID selected by the user via Rich menu switch action.
 - Returned only for postback actions by Rich menu switch action.
 */
public protocol LinePostbackEventParam {}

// MARK: - LinePostbackEventDateTimeParam
/**
 Object with the date and time selected by a user through a datetime picker action.
 
 The `full-date`, `time-hour`, and `time-minute` formats follow the [RFC3339 protocol](https://www.ietf.org/rfc/rfc3339.txt).
 
 - `date`: Date selected by user. Only included in the `date` mode.
    - Format: `full-date`
 - `time`: Time selected by the user. Only included in the `time` mode.
    - Format: `time-hour ":" time-minute`
 - `datetime`: Date and time selected by the user. Only included in the `datetime` mode.
    - Format: `full-date "T" time-hour ":" time-minute`
 */
public struct LinePostbackEventDateTimeParam: LinePostbackEventParam {
    
    var date: String?
    var time: String?
    var datetime: String?
}

// MARK: - LinePostbackEventDateTimeParam.Codable
extension LinePostbackEventDateTimeParam: Codable {}

// MARK: - LinePostbackEventRichMenuParam
/**
 Object with rich menu alias ID selected by user via rich menu switch action.
 
 - `newRichMenuAliasID`: Rich menu alias ID to switch to.
 - `status`: See **Status**.
 */
public struct LinePostbackEventRichMenuParam: LinePostbackEventParam {
    
    var newRichMenuAliasID: String
    var status: Status
}

// MARK: - Status
extension LinePostbackEventRichMenuParam {
    
    /**
     - `success`: Rich menu changed successfully.
     - `richmenuAliasIDNotFound`: The specified rich menu alias ID was not found.
     - `richmenuNotFound`: The rich menu ID associated with the specified rich menu alias ID was not found.
     - `failed`: Rich menu switch failed.
     */
    public enum Status: String, Codable {
        case success = "SUCCESS"
        case richmenuAliasIDNotFound = "RICHMENU_ALIAS_ID_NOTFOUND"
        case richmenuNotFound = "RICHMENU_NOTFOUND"
        case failed = "FAILED"
    }
}

// MARK: - LinePostbackEventRichMenuParam.Codable
extension LinePostbackEventRichMenuParam: Codable {
    
    enum CodingKeys: String, CodingKey {
        case newRichMenuAliasID = "newRichMenuAliasId"
        case status
    }
}
