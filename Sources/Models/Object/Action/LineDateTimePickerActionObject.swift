import Foundation

/**
 When a control associated with this action is tapped, a postback event is returned via webhook with the date and time selected by the user from the date and time selection dialog.
 
 The datetime picker action does not support time zones.
 
 - `type`: `datetimePicker`
 - `label`: Label for the action.
    - Required for templates other than image carousel. Max character limit: 20
    - Optional for image carousel templates. Max character limit: 12
    - Optional for rich menus. Spoken when the accessibility feature is enabled on the client device. Max character limit: 20. Supported on LINE 8.2.0 or later for iOS.
    - Required for quick reply buttons. Max character limit: 20. Supported on 8.11.0 or later for both LINE for iOS and LINE for Android.
    - Required for the button of Flex Message. This property can be specified for the box, image, and text but its value is not displayed. Max character limit: 40
 - `data`: String returned via webhook in the `postback.data` property of the postback event.
    - Max character limit: 300
 - `mode`: Action mode. See **Mode**,
 - `initial`: Initial value of date or time.
 - `max`: Largest date or time value that can be selected. Must be greater than the `min` value.
 - `min`: Smallest date or time value that can be selected. Must be less than the `max` value.
 
 # Date and time format
 
 he date and time formats for the `initial`, `max`, and `min` values are shown below. The `full-date`, `time-hour`, and `time-minute` formats follow the [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) protocol.
 
 - `date`: `full-date`
    - Max: 2100-12-31
    - Min: 1900-01-01
    - Example: 2017-06-18
 - `time`: `time-hour : time-minute`
    - Max: 23:59
    - Min: 00:00
    - Example: 00:00, 06:15, 23:59
 - `datetime`: `full-date T time-hour : time-minute` or `full-date t time-hour : time-minute`
    - Max: 2100-12-31T23:59
    - Min: 1900-01-01T00:00
    - Example: 2017-06-18T06:15, 2017-06-18t06:15
 */
public struct LineDateTimePickerActionObject: LineActionObject {
    
    public var type: LineActionObjectType = .datetimePicker
    public var label: String?
    public var data: String
    public var mode: Mode
    public var initial: String?
    public var max: String?
    public var min: String?
}

// MARK: - Mode
extension LineDateTimePickerActionObject {
    
    /**
     - `date`: Pick date
     - `time`: Pick time
     - `datetime`: Pick date and time
     */
    public enum Mode: String, Codable {
        case date
        case time
        case datetime
    }
}

// MARK: - Codable
extension LineDateTimePickerActionObject: Codable {}
