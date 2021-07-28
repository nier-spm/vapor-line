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
        
        let events = try container.decode([LineWebhookEventPrototype].self, forKey: .events)
        self.events = events
        
        var unkeyedContainer = try container.nestedUnkeyedContainer(forKey: .events)

        while !unkeyedContainer.isAtEnd {
            let index: Int = unkeyedContainer.currentIndex

            switch events[index].type {
            case .message:
                let message = try unkeyedContainer.decode(LineMessageEvent.self)
                self.events.append(message)
            case .unsend:
                let unsend = try unkeyedContainer.decode(LineUnsendEvent.self)
                self.events.append(unsend)
            case .follow:
                let follow = try unkeyedContainer.decode(LineFollowEvent.self)
                self.events.append(follow)
            case .unfollow:
                let unfollow = try unkeyedContainer.decode(LineUnfollowEvent.self)
                self.events.append(unfollow)
            case .join:
                let join = try unkeyedContainer.decode(LineJoinEvent.self)
                self.events.append(join)
            case .leave:
                let leave = try unkeyedContainer.decode(LineLeaveEvent.self)
                self.events.append(leave)
            case .memberJoin:
                let memberJoin = try unkeyedContainer.decode(LineMemberJoinEvent.self)
                self.events.append(memberJoin)
            case .memberLeave:
                let memberLeave = try unkeyedContainer.decode(LineMemberLeaveEvent.self)
                self.events.append(memberLeave)
            case .postback:
                let postback = try unkeyedContainer.decode(LinePostbackEvent.self)
                self.events.append(postback)
            case .videoPlayComplete:
                let videoViewingComplete = try unkeyedContainer.decode(LineVideoViewingCompleteEvent.self)
                self.events.append(videoViewingComplete)
            case .beacon:
                let beacon = try unkeyedContainer.decode(LineBeaconEvent.self)
                self.events.append(beacon)
            case .accountLink:
                let accountLink = try unkeyedContainer.decode(LineAccountLinkEvent.self)
                self.events.append(accountLink)
            case .things:
                let deviceLinkUnlink = try unkeyedContainer.decode(LineDeviceLinkUnlinkEvent.self)
                self.events.append(deviceLinkUnlink)
            }
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.destination, forKey: .destination)
        
        var unkeyedContainer = container.nestedUnkeyedContainer(forKey: .events)
        
        for event in self.events {
            if let message = event as? LineMessageEvent {
                try unkeyedContainer.encode(message)
            } else if let unsend = event as? LineUnsendEvent {
                try unkeyedContainer.encode(unsend)
            } else if let follow = event as? LineFollowEvent {
                try unkeyedContainer.encode(follow)
            } else if let unfollow = event as? LineUnfollowEvent {
                try unkeyedContainer.encode(unfollow)
            } else if let join = event as? LineJoinEvent {
                try unkeyedContainer.encode(join)
            } else if let leave = event as? LineLeaveEvent {
                try unkeyedContainer.encode(leave)
            } else if let memberJoin = event as? LineMemberJoinEvent {
                try unkeyedContainer.encode(memberJoin)
            } else if let memberLeave = event as? LineMemberLeaveEvent {
                try unkeyedContainer.encode(memberLeave)
            } else if let postback = event as? LinePostbackEvent {
                try unkeyedContainer.encode(postback)
            } else if let videoViewingComplete = event as? LineVideoViewingCompleteEvent {
                try unkeyedContainer.encode(videoViewingComplete)
            } else if let beacon = event as? LineBeaconEvent {
                try unkeyedContainer.encode(beacon)
            } else if let accountLink = event as? LineAccountLinkEvent {
                try unkeyedContainer.encode(accountLink)
            } else if let deviceLinkUnlink = event as? LineDeviceLinkUnlinkEvent {
                try unkeyedContainer.encode(deviceLinkUnlink)
            }
        }
    }
}
