import Vapor

/**
 [UsingRichmenus]: https://developers.line.biz/en/docs/messaging-api/using-rich-menus/
 
 # Reference
 [Rich menu | LINE Developers](https://developers.line.biz/en/reference/messaging-api/#rich-menu)
 
 Customizable menu that is displayed on your LINE Official Account's chat screen. For more information, see [Using rich menus][UsingRichmenus].
 */
public final class Richmenu: NSObject {
    
    private let line: Line
    
    public init(_ line: Line) {
        self.line = line
    }
}

// MARK: - Line rich menu api
extension Richmenu {
    
    public enum API {
        case richment(String? = nil)
        case content(String)
        case list
        
        public var url: String {
            let baseURL: String = "https://api.line.me/v2/bot/"
            
            switch self {
            case .richment(let id):
                var url = baseURL + "richmenu/"
                
                if id != nil {
                    url += id!
                }
                
                return url
            case .content(let id):
                return "https://api-data.line.me/v2/bot/richmenu/\(id)/content"
            case .list:
                return baseURL + "richmenu/" + "\(self)"
            }
        }
    }
}

// MARK: -
extension Richmenu {
    
    // MARK: create richmenu
    /**
     Creates a rich menu.
     
     You must **upload a rich menu image**, and **set the rich menu as the default rich menu** or **link the rich menu** to a user for the rich menu to be displayed. You can create up to 1000 rich menus for one LINE Official Account with the Messaging API.
     
     # Reference
     [Create rich menu | LINE Developers](https://developers.line.biz/en/reference/messaging-api/#create-rich-menu)
     
     - Parameters:
         - request: Client request
         - richmenu: The rich menu represented as a rich menu object. See **LineRichmenu**.
     
     - Returns:
         Returns status code `200` and a JSON object with the rich menu ID.
     */
    public func create(_ request: Request, richmenu: LineRichmenu) -> EventLoopFuture<ClientResponse> {
        request.client.post(URI(string: API.richment().url), headers: self.line.headers) { req in
            try req.content.encode(richmenu)
        }
    }
    
    // MARK: get richmenu
    /**
     Gets a rich menu via a rich menu ID.
     
     # Reference
     [Get rich menu | LINE Developers](https://developers.line.biz/en/reference/messaging-api/#get-rich-menu)
     
     - Parameters:
         - request: Client request
         - menuID: ID of richmenu
     
     - Returns:
        Returns status code `200` and a rich menu response object.
     */
    public func menu(_ request: Request, menuID id: String) -> EventLoopFuture<LineRichmenuResponseObject> {
        request.client.get(URI(string: API.richment(id).url), headers: self.line.headers).flatMapThrowing { res in
            if res.status.code != 200 {
                let error = try? res.content.decode(LineAPIErrorResponse.self)
                
                throw Abort(res.status, reason: error?.message)
            }
            
            return try res.content.decode(LineRichmenuResponseObject.self)
        }
    }
    
    // MARK: upload local richmenu image
    /**
     Uploads and attaches a local image to a rich menu.
     
     You can use rich menu images with the following specifications:
     - Image format: JPEG or PNG
     - Image width size (pixels): 800 to 2500
     - Image height size (pixels): 250 or more
     - Image aspect ratio (width/height): 1.45 or more
     - Max file size: 1 MB
     
     - Parameters:
        - request: Client request
        - menuID: ID of richmenu
        - path: Path of local file.
     
     - Returns:
        Returns status code `200` and a rich menu response object.
     */
    public func content(_ request: Request, menuID id: String, path: String) -> EventLoopFuture<HTTPStatus> {
        request.eventLoop.future(request.fileio.streamFile(at: path))
            .flatMap { res in
                res.body.collect(on: request.eventLoop)
                    .unwrap(orError: Abort(.internalServerError))
                    .flatMap { buffer in
                        res.headers.add(name: .authorization, value: "Bearer \(self.line.accessToken)")
                        
                        return request.client.post(URI(string: API.content(id).url), headers: res.headers) { req in
                            req.body = buffer
                        }.flatMapThrowing { res in
                            if res.status.code != 200 {
                                let error = try res.content.decode(LineAPIErrorResponse.self)
                                
                                throw Abort(res.status, reason: error.message)
                            }
                            
                            return res.status
                        }
                    }
            }
    }
    
    // MARK: upload local richmenu image from public publicDirectory
    /**
     Uploads and attaches a local image to a rich menu from public directory.
     
     You can use rich menu images with the following specifications:
     - Image format: JPEG or PNG
     - Image width size (pixels): 800 to 2500
     - Image height size (pixels): 250 or more
     - Image aspect ratio (width/height): 1.45 or more
     - Max file size: 1 MB
     
     - Parameters:
        - request: Client request
        - menuID: ID of richmenu
        - filename: Name of file in public directory.
     
     - Returns:
        Returns status code `200` and a rich menu response object.
     */
    public func content(_ request: Request, menuID id: String, filename: String) -> EventLoopFuture<HTTPStatus> {
        let path: String = request.application.directory.publicDirectory + filename
        
        return self.content(request, menuID: id, path: path)
    }
    
    // MARK: upload richmenu image
    /**
     Uploads and attaches an image to a rich menu.
     
     You can use rich menu images with the following specifications:
     - Image format: JPEG or PNG
     - Image width size (pixels): 800 to 2500
     - Image height size (pixels): 250 or more
     - Image aspect ratio (width/height): 1.45 or more
     - Max file size: 1 MB
     
     - Parameters:
        - request: Client request
        - menuID: ID of richmenu
     
     - Returns:
        Returns status code `200` and a rich menu response object.
     */
    public func content(_ request: Request, menuID id: String) -> EventLoopFuture<HTTPStatus> {
        request.headers.add(name: .authorization, value: "Bearer \(self.line.accessToken)")
        
        return request.client.post(URI(string: API.content(id).url), headers: request.headers) { req in
            req.body = request.body.data
        }.flatMapThrowing { res in
            if res.status.code != 200 {
                let error = try res.content.decode(LineAPIErrorResponse.self)
                
                throw Abort(res.status, reason: error.message)
            }
            
            return res.status
        }
    }
    
    // MARK: download richmenu image
    /**
     Downloads an image associated with a rich menu.
     
     - Parameters:
        - request: Client request
        - menuID: ID of richmenu
     
     - Returns:
         Returns status code `200` and the binary data of the rich menu image.
     */
    public func content(_ request: Request, menuID id: String) -> EventLoopFuture<ClientResponse> {
        request.client.get(URI(string: API.content(id).url), headers: self.line.headers)
            .flatMapThrowing { res in
                if res.status.code != 200 {
                    let error = try res.content.decode(LineAPIErrorResponse.self)

                    throw Abort(res.status, reason: error.message)
                }

                return res
            }
    }
    
    // MARK: download and save rich menuimage
    /**
     Downloads and save an image associated with a rich menu to public directory.
     
     - Parameters:
        - request: Client request
        - menuID: ID of richmenu
        - folder: Directory of file in public directory. Default is the **root of public directory**.
     
     - Returns:
        Filename of richmenu image.
     */
    public func content(_ request: Request, menuID id: String, folder path: String = "") -> EventLoopFuture<String> {
        let response: EventLoopFuture<ClientResponse> = self.content(request, menuID: id)
        
        return response.flatMap { res in
            var filename: String = UUID().uuidString
            
            if res.headers.contentType != nil {
                filename += "." + res.headers.contentType!.subType
            }
            
            let filepath: String = request.application.directory.publicDirectory + path + filename
            
            return request.fileio.writeFile(res.body!, at: filepath).map { filename }
        }
    }
    
    // MARK: get richmenus
    /**
     Gets a list of the rich menu response object of all rich menus created by **Create a rich menu**.
     
     # Reference
     [Get rich menu list | LINE Developers](https://developers.line.biz/en/reference/messaging-api/#get-rich-menu-list)
     
     - Parameters:
         - request: Client request
     
     - Returns:
         Returns status code `200` and a list of rich menu response objects.
     */
    public func list(_ request: Request) -> EventLoopFuture<[LineRichmenuResponseObject]> {
        request.client.get(URI(string: API.list.url), headers: self.line.headers).flatMapThrowing { res in
            if res.status.code != 200 {
                let error = try? res.content.decode(LineAPIErrorResponse.self)
                
                throw Abort(res.status, reason: error?.message)
            }
            
            let response = try res.content.decode([String: [LineRichmenuResponseObject]].self)
            
            return response.values.first ?? []
        }
    }
    
    // MARK: delele richmenu
    /**
     Deletes a rich menu.
     
     - Parameters:
        - request: Client request
        - menuID: ID of richmenu
     
     - Returns:
         Returns status code `200` and an empty JSON object.
     */
    public func delete(_ request: Request, menuID id: String) -> EventLoopFuture<HTTPStatus> {
        request.client.delete(URI(string: API.richment(id).url), headers: self.line.headers)
            .flatMapThrowing { res in
                if res.status.code != 200 {
                    let error = try? res.content.decode(LineAPIErrorResponse.self)
                    
                    throw Abort(res.status, reason: error?.message)
                }
                
                return res.status
            }
    }
}
