import Vapor

/**
 - `endpoint`: Webhook URL.
 - `active`: Webhook usage status. Send a webhook event from the LINE platform to the webhook URL only if enabled.
    - `true`: Webhook usage is enabled.
    - `false`: Webhook usage is disabled.
 */
public struct LineWebhookEndpointResponse: Content {
    
    public var endpoint: String
    public var active: Bool
}

