import Vapor

public struct LineAPIErrorResponse: Content {
    public var message: String
    public var details: [LineAPIErrorResponseDetail]?
}

public struct LineAPIErrorResponseDetail: Codable {
    public var message: String
    public var property: String
}
