import Foundation

/**
 - `deviceID`: Device ID of the device that has been linked/unlink with LINE or device ID of the device that executed the scenario.
 - `type`: `link`, `unlink` or `scenarioResult`.
 - `result`: See **Result**.
 */
public struct LineDeviceThings {
    
    public var deviceID: String
    public var type: Type
    public var result: Result?
}

extension LineDeviceThings {
    
    public enum `Type`: String, Codable {
        case link
        case unlink
        case scenarioResult
    }
}

// MARK: - Codable
extension LineDeviceThings: Codable {
    
    enum CodingKeys: String, CodingKey {
        case deviceID = "deviceId"
        case type
        case result
    }
}

// MARK: - Result
extension LineDeviceThings {
    
    /**
     - `scenarioID`: Scenario ID executed
     - `revision`: Revision number of the scenario set containing the executed scenario.
     - `startTime`: Timestamp for when execution of scenario action started (milliseconds, LINE app time).
     - `endTime`: Timestamp for when execution of scenario was completed (milliseconds, LINE app time).
     - `resultCode`: Scenario execution completion status. See **ResultCode**.
     - `actionResults`: See **ActionResult**.
     - `bluetoothNotificationPayload`: **bleNotificationPayload**. Data contained in notification.
        - The value is Base64-encoded binary data. Only included for scenarios where `trigger.type = BLE_NOTIFICATION`.
     - `errorReason`: Error reason.
     */
    public struct Result: Codable {
        public var scenarioID: String
        public var revision: Int
        public var startTime: Double
        public var endTime: Double
        public var resultCode: ResultCode
        public var actionResults: [ActionResult]
        public var bluetoothNotificationPayload: String
        public var errorReason: String?
        
        enum CodingKeys: String, CodingKey {
            case scenarioID = "scenarioId"
            case revision
            case startTime
            case endTime
            case resultCode
            case actionResults
            case bluetoothNotificationPayload = "bleNotificationPayload"
            case errorReason
        }
        
        // MARK: ResultCode
        /**
         - `success`: Indicates that the execution has completed successfully.
         - `gattError`: Indicates that the execution of the GATT operation failed.
            - GATT Service UUID is incorrect.
            - GATT Characteristic UUID is incorrect.
            - Attempted to write to a characteristic that cannot be written to.
         - `runtimeError`: Indicates that an unexpected error has occurred.
            - When an unexpected error has occurred.
         */
        public enum ResultCode: String, Codable {
            case success
            case gattError = "gatt_error"
            case runtimeError = "runtime_error"
        }
        
        // MARK: ActionResult
        /**
         Execution result of individual operations specified in action.
         
         Note that an array of actions specified in a scenario has the following characteristics.
         
         - The actions defined in a scenario are performed sequentially, from top to bottom.
         - Each action produces some result when executed. Even actions that do not generate data, such as `SLEEP`, return an execution result of type `void`.
         - The number of items in an action array may be 0.
         
         Therefore, `result.actionResults` has the following properties:
         
         - The number of items in the array matches the number of actions defined in the scenario.
         - The order of execution results matches the order in which actions are performed. That is, in a scenario set with multiple `GATT_READ` actions, the results are returned in the order in which each individual `GATT_READ` action was performed.
         - If 0 actions are defined in the scenario, the number of items in `result.actionResults` will be 0.
         
         # Property
         
         - `type`: `void`, `binary`
            - Depends on `type` of the executed action.
            - This property is always included if `result.actionResults` is not empty.
         - `data`: Base64-encoded binary data.
            - This property is always included when `result.actionResults[].type` is binary.
         */
        public struct ActionResult: Codable {
            public var type: Type
            public var data: String?
            
            public enum `Type`: String, Codable {
                case void
                case binary
            }
        }
    }
}
