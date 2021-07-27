import Foundation

public struct LineWebhook {
    
    public var destination: String
    public var events: [LineWebhookEvent] = []
}

extension LineWebhook: Codable {
    
    enum CodingKeys: String, CodingKey {
        case destination
        case events
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.destination = try container.decode(String.self, forKey: .destination)
        
        var unkeyedContainer = try container.nestedUnkeyedContainer(forKey: .events)
        
        for _ in 0..<(unkeyedContainer.count ?? 0) {
            if let message = try? unkeyedContainer.decode(LineMessageEvent.self) {
                self.events.append(message)
            }
            
            print(unkeyedContainer.isAtEnd)
        }
        
//        while !unkeyedContainer.isAtEnd {
//            print(unkeyedContainer.currentIndex)
//            if let message = try? unkeyedContainer.decode(LineMessageEvent.self) {
//                self.events.append(message)
//            } else {
//                let res = try unkeyedContainer.decodeNil()
//
//                print(res)
//
//                continue
//            }
//        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.destination, forKey: .destination)
        
        var unkeyedContainer = container.nestedUnkeyedContainer(forKey: .events)
        
        for event in self.events {
            if let message = event as? LineMessageEvent {
                try unkeyedContainer.encode(message)
            }
        }
    }
}
