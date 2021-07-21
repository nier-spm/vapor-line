import Vapor

public struct LineError: DebuggableError {
    
    public enum Error {
        case missingChannelID
        case missingChannelSecret
        case missingChannelAccessToken
        case signatureNotFound
        case messageBodyNotFound
        case signatureVerifyFail
    }
    
    public var identifier: String {
        return "\(self.error)"
    }
    
    public var reason: String {
        switch self.error {
        case .missingChannelID:
            return "Missing Environment: {{your_nvironment_prefix}}_ID."
        case .missingChannelSecret:
            return "Missing Environment: {{your_nvironment_prefix}}_SECRET."
        case .missingChannelAccessToken:
            return "Missing Environment: {{your_nvironment_prefix}}_ACCESS_TOKEN."
        case .signatureNotFound:
            return "Request header not found: x-line-signature."
        case .messageBodyNotFound:
            return "Request body not found."
        case .signatureVerifyFail:
            return "Signature verifu fail."
        }
    }
    
    var error: Error
    public var source: ErrorSource?
    
    init(_ error: Error, file: String = #file, function: String = #function, line: UInt = #line, column: UInt = #column) {
        self.error = error
        self.source = .init(file: file, function: function, line: line, column: column)
    }
}
