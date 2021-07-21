import Vapor

public struct LineMiddleware: Middleware {
    
    private var line: Line
    
    public init(service line: Line) {
        self.line = line
    }
    
    public func respond(to request: Request, chainingTo next: Responder) -> EventLoopFuture<Response> {
        
        guard let signature = request.headers["x-line-signature"].first else {
            let error: LineError = .init(.signatureNotFound)
            print("[ Line ] \(error.reason)")
            return request.eventLoop.makeFailedFuture(Abort(.badRequest))
        }
        
        if request.application.environment != .production {
            print("[ Line ] signature: \(signature)")
        }
        
        guard let body = request.body.string else {
            let error: LineError = .init(.messageBodyNotFound)
            print("[ Line ] \(error.reason)")
            return request.eventLoop.makeFailedFuture(Abort(.badRequest))
        }
        
        if request.application.environment != .production {
            print("[ Line ] message: \(body)")
        }
        
        let result = self.line.webhookVerify(signature, body)
        
        switch result {
        case .success:
            if request.application.environment != .production {
                print("[ Line ] message verify success.")
            }
            return next.respond(to: request)
        case .failure(let error):
            print("[ Line ] \(error.reason)")
            return request.eventLoop.makeFailedFuture(Abort(.badRequest))
        }
    }
}
