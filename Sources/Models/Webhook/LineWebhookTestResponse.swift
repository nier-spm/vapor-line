import Vapor

public struct LineWebhookTestResponse: Content {
    
    public var success: Bool
    public var timestamp: String
    public var statusCode: Int
    public var reason: Reason
    public var detail: String
    
    public enum Reason: String, Codable {
        case ok = "OK"
        case couldNotConnect = "COULD_NOT_CONNECT"
        case errorStatusCode = "ERROR_STATUS_CODE"
        case requestTimeout = "REQUEST_TIMEOUT"
        case unclassified = "UNCLASSIFIED"
        
        public var description: String {
            switch self {
            case .ok:
                return "Successfully sent the webhook"
            case .couldNotConnect:
                return "Failed to connect"
            case .errorStatusCode:
                return "HTTP status code error response"
            case .requestTimeout:
                return "Request time out"
            case .unclassified:
                return "Unknown error"
            }
        }
    }
}
