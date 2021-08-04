import Foundation

// MARK: - [ Protocol ] LineActionObject
public protocol LineActionObject {
    var type: LineActionObjectType { get }
}

// MARK: - LineActionObjectType
/**
 - `postback`
 - `message`
 - `uri`
 - `datetimePicker`: `datetimepicker`
 - `camera`
 - `cameraRoll`
 - `location`
 - `richmenuSwitch`: `richmenuswitch`
 */
public enum LineActionObjectType: String, Codable {
    case postback
    case message
    case uri
    case datetimePicker = "datetimepicker"
    case camera
    case cameraRoll
    case location
    case richmenuSwitch = "richmenuswitch"
}

// MARK: - LineActionObjectPrototype
struct LineActionObjectPrototype: LineActionObject {
    
    var type: LineActionObjectType
}
