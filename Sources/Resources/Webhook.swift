import Vapor

/**
 [Webhooks]: https://developers.line.biz/en/reference/messaging-api/#webhooks
 
 When an event occurs, such as when a user adds your LINE Official Account as a friend or sends a message, the LINE Platform sends an HTTPS POST request to the webhook URL (bot server).
 
 # Reference
 [Webhooks | LINE Developers][Webhooks]
 */
public final class Webhook: NSObject {
    
    private let line: Line
    
    public init(_ line: Line) {
        self.line = line
    }
}

// MARK: - Line webhook api
extension Webhook {
    
    public enum API: String {
        case endpoint
        case test
        
        public var url: URI {
            let baseURL: String = "https://api.line.me/v2/bot/channel/webhook/"

            return URI(string: baseURL + self.rawValue)
        }
    }
}

// MARK: -
extension Webhook {
    
    // MARK: Webhook verify
    /**
     The signature in the x-line-signature request header must be verified to confirm that the request was sent from the LINE Platform.
     
     # Reference
     [Signature validation | LINE Developers](https://developers.line.biz/en/reference/messaging-api/#signature-validation)
     
     - Parameters:
        - signature: **x-line-signature** or **X-Line-Signature** in request header
        - message: Request body
     
     - Returns:
        The result of Line message verify.
     */
    public func verify(_ signature: String, _ message: String) -> Result<Bool, LineError> {
        let digest: HashedAuthenticationCode = HMAC<SHA256>.authenticationCode(for: message.data(using: .utf8)!, using: self.line.secretKey)
        
        if signature == Data(digest).base64EncodedString() {
            return .success(true)
        } else {
            return .failure(.init(.signatureVerifyFail))
        }
    }
    
    // MARK: Get webhook endpoint information
    /**
     Gets information on a webhook endpoint.
     
     # Reference
     [Get webhook endpoint information | LINE Developers](https://developers.line.biz/en/reference/messaging-api/#get-webhook-endpoint-information)
     
     - Parameters:
        - request: Client request
     
     - Returns:
        Returns status code `200` and a JSON object with the following information.
     
        - `endpoints`: Webhook URL
        - `active`: Webhook usage status. Send a webhook event from the LINE platform to the webhook URL only if enabled.
            - `true`: Webhook usage is enabled.
            - `false`: Webhook usage is disabled.
     */
    public func endpoint(_ request: Request) -> EventLoopFuture<LineWebhookEndpointResponse> {
        return request.client.get(API.endpoint.url, headers: self.line.headers)
            .flatMapThrowing { res in
                if res.status.code != 200 {
                    let error = try? res.content.decode(LineAPIErrorResponse.self)
                    
                    throw Abort(res.status, reason: error?.message)
                }
                
                return try res.content.decode(LineWebhookEndpointResponse.self)
            }
    }
    
    // MARK: Set webhook endpoint URL
    /**
     Sets the webhook endpoint URL. It may take up to 1 minute for changes to take place due to caching.
     
     # Reference
     [Set webhook endpoint URL | LINE Developers](https://developers.line.biz/en/reference/messaging-api/#set-webhook-endpoint-url)
     
     - Parameters:
        - request: Client request
        - endpoint: A valid webhook URL.
     
     - Returns:
        Returns status code `200` and an empty JSON object.
     
        # Error Response
     
        Returns a `400` HTTP status code if the webhook URL is invalid.
     */
    public func endpoint(_ request: Request, endpoint: URI) -> EventLoopFuture<HTTPStatus> {
        return request.client.put(API.endpoint.url, headers: self.line.headers) { req in
            let data: [String: String] = ["endpoint": endpoint.string]
            try req.content.encode(data)
        }.flatMapThrowing { res in
            if res.status.code != 200 {
                let error = try? res.content.decode(LineAPIErrorResponse.self)
                
                throw Abort(res.status, reason: error?.message)
            }
            
            return res.status
        }
    }
    
    // MARK: Test webhook endpoint
    /**
     Checks if the configured webhook endpoint can receive a test webhook event.
     
     # Reference
     [Test webhook endpoint](https://developers.line.biz/en/reference/messaging-api/#test-webhook-endpoint)
     
     - Parameters:
        - request: Client request
        - endpoint: [Optional] A webhook URL to be validated.
     
     - Returns:
        Returns status code `200` and a JSON object with the following information.
     
        - `success`: Result of the communication from the LINE platform to the webhook URL.
            - `true`: Success
            - `false`: Failure
        - `timestamp`: Time of the event in milliseconds
        - `statusCode`: The HTTP status code. If the webhook response isn't received, the status code is set to zero or a negative number.
        - `reason`: Reason for the response.
            - `OK`: `200`
            - `COULD_NOT_CONNECT`: Failure to connect message
            - `ERROR_STATUS_CODE`: HTTP status code
            - `REQUEST_TIMEOUT`: Request timeout
            - `UNCLASSIFIED`:  `N/A`
     
        # Error Response
     
        - Returns a `400` HTTP status code if the webhook URL isn't valid.
        - Returns a `404` HTTP status code if the webhook URL isn't set.
     */
    public func test(_ request: Request, endpoint: URI? = nil) -> EventLoopFuture<LineWebhookTestResponse> {
        return request.client.post(API.test.url, headers: self.line.headers) { req in
            if let endpoint = endpoint {
                let data: [String: String] = ["endpoint": endpoint.string]
                try req.content.encode(data)
            }
        }.flatMapThrowing { res in
            if res.status.code != 200 {
                let error = try? res.content.decode(LineAPIErrorResponse.self)
                
                throw Abort(res.status, reason: error?.message)
            }
            
            return try res.content.decode(LineWebhookTestResponse.self)
        }
    }
}
