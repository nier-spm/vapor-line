import Vapor

public struct LineWebhookEndpointResponse: Content {
    
    public var endpoint: String
    public var active: Bool
}

