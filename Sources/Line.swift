import Vapor

public class Line: NSObject {
    
    let id: String
    let secret: String
    let accessToken: String
    
    let secretKey: SymmetricKey
    
    /**
     Initializer of Line.
     
     - Parameters:
        - id: Line channel ID
        - secret: Line channel secret
        - accessToken: Line channel access token
     */
    public init(_ id: String, _ secret: String, _ accessToken: String) {
        self.id = id
        self.secret = secret
        self.accessToken = accessToken
        
        self.secretKey = SymmetricKey(data: secret.data(using: .utf8)!)
    }
}

// MARK: - Line Initializer
extension Line {
    
    
    // MARK: Init by enviornment key
    /**
     Initializer of Line.
     
     - Parameters:
        - id: Line channel ID
        - secret: Line channel secret
        - accessToken: Line channel access token
     */
    public static func environment(_ id: String, _ secret: String, _ accessToken: String) throws -> Line {
        guard let id = Environment.get(id) else {
            throw LineError(.missingChannelID)
        }
        
        guard let secret = Environment.get(secret) else {
            throw LineError(.missingChannelSecret)
        }
        
        guard let accessToken = Environment.get(accessToken) else {
            throw LineError(.missingChannelAccessToken)
        }
        
        return Line(id, secret, accessToken)
    }
    
    // MARK: - Init by enviornment key prefix
    /**
     Initializer of Line.
     
     - Parameters:
        - prefix: Environment key prefix of **Line channel id**, **Line channel secret** and **Line channel access token** from project enviornment.
     */
    public static func enviornment(_ prefix: String) throws -> Line {
        let prefix: String = prefix.uppercased()
        
        guard let id = Environment.get(prefix + "_ID") else {
            throw LineError(.missingChannelID)
        }
        
        guard let secret = Environment.get(prefix + "_SECRET") else {
            throw LineError(.missingChannelSecret)
        }
        
        guard let accessToken = Environment.get(prefix + "_ACCESS_TOKEN") else {
            throw LineError(.missingChannelAccessToken)
        }
        
        return Line(id, secret, accessToken)
    }
}

// MARK: -
extension Line {
    
    var headers: HTTPHeaders {
        var headers = HTTPHeaders()
        
        headers.add(name: .authorization, value: "Bearer \(self.accessToken)")
        
        return headers
    }
}
