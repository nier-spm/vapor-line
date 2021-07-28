import Foundation

public struct LineDeviceThings: Codable {
    
    public var deviceID: String
    public var type: Type
    public var result: Result?
    
    enum CodingKeys: String, CodingKey {
        case deviceID = "deviceId"
        case type
        case result
    }
}

extension LineDeviceThings {
    
    public enum `Type`: String, Codable {
        case link
        case unlink
        case scenarioResult
    }
}

extension LineDeviceThings {
    
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
        
        public enum ResultCode: String, Codable {
            case success
            case gattError = "gatt_error"
            case runtimeError = "runtime_error"
        }
        
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
