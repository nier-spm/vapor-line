import Foundation

extension Line {
    
    private static var _webhook: Webhook?
    
    public var webhook: Webhook {
        if Line._webhook != nil {
            return Line._webhook!
        }
        
        Line._webhook = Webhook(self)
        return Line._webhook!
    }
}
