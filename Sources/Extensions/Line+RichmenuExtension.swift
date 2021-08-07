import Foundation

extension Line {
    
    private static var _richmenu: Richmenu?
    
    public var richmenu: Richmenu {
        if Line._richmenu != nil {
            return Line._richmenu!
        }
        
        Line._richmenu = Richmenu(self)
        return Line._richmenu!
    }
}
