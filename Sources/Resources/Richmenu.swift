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
        case allUser(_ menuID: String? = nil)
        case user(_ userID: String, menuID: String? = nil)
        case alias(String? = nil)
        case aliasList
        case linkMultipleUsers
        case unlinkMultipleUsers
        
        public var url: String {
            let baseURL: String = "https://api.line.me/v2/bot/"
            
            switch self {
            case .richment(let id):
                return baseURL + "richmenu/" + (id ?? "")
            case .content(let id):
                return "https://api-data.line.me/v2/bot/richmenu/\(id)/content"
            case .list:
                return baseURL + "richmenu/" + "\(self)"
            case .allUser(let menuID):
                return baseURL + "user/all/richmenu/" + (menuID ?? "")
            case .user(let userID, let menuID):
                return baseURL + "user/\(userID)/richmenu/" + (menuID ?? "")
            case .alias(let id):
                return baseURL + "richmenu/alias/" + (id ?? "")
            case .aliasList:
                return baseURL + "richmenu/alias/list"
            case .linkMultipleUsers:
                return baseURL + "richmenu/bulk/link"
            case .unlinkMultipleUsers:
                return baseURL + "richmenu/bulk/unlink"
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
    
    // MARK: set default richmenu
    /**
     Sets the default rich menu.
     
     The default rich menu is displayed to all users who have added your LINE Official Account as a friend and are not linked to any per-user rich menu. If a default rich menu has already been set, calling this endpoint replaces the current default rich menu with the one specified in your request.
     
     The rich menu is displayed in the following order of priority (highest to lowest):
     1. [The per-user rich menu set with the Messaging API](https://developers.line.biz/en/reference/messaging-api/#link-rich-menu-to-user)
     1. The default rich menu set with the Messaging API
     1. The [default rich menu set with LINE Official Account Manager](https://developers.line.biz/en/docs/messaging-api/using-rich-menus/#creating-a-rich-menu-with-the-line-manager)
     
     - Parameters:
         - request: Client request
         - menuID: ID of richmenu
     
     - Returns:
        Returns status code `200` and an empty JSON object.
     */
    public func defaultMenu(_ request: Request, menuID id: String) -> EventLoopFuture<HTTPStatus> {
        request.client.post(URI(string: API.allUser(id).url), headers: self.line.headers)
            .flatMapThrowing { res in
                if res.status.code != 200 {
                    let error = try? res.content.decode(LineAPIErrorResponse.self)
                    
                    throw Abort(res.status, reason: error?.message)
                }
                
                return res.status
            }
    }
    
    // MARK: get default richmenu id
    /**
     Gets the ID of the default rich menu set with the Messaging API.
     
     - Parameters:
        - request: Client request
     
     - Returns:
        Returns status code `200` and a JSON object with the rich menu ID.
     */
    public func defaultMenu(_ request: Request) -> EventLoopFuture<LineRichmenuResponseObject> {
        request.client.get(URI(string: API.allUser().url), headers: self.line.headers)
            .flatMapThrowing { res in
                if res.status.code != 200 {
                    let error = try? res.content.decode(LineAPIErrorResponse.self)
                    
                    throw Abort(res.status, reason: error?.message)
                }
                
                return try res.content.decode(LineRichmenuResponseObject.self)
            }
    }
    
    // MARK: - cancel default richmenu
    /**
     Cancels the default rich menu set with the Messaging API.
     
     - Parameters:
        - request: Client request
     
     - Returns:
        Returns status code `200` and an empty JSON object.
     */
    public func defaultMenu(_ request: Request) -> EventLoopFuture<HTTPStatus> {
        request.client.delete(URI(string: API.allUser().url), headers: self.line.headers)
            .flatMapThrowing { res in
                if res.status.code != 200 {
                    let error = try? res.content.decode(LineAPIErrorResponse.self)
                    
                    throw Abort(res.status, reason: error?.message)
                }
                
                return res.status
            }
    }
    
    // MARK: link richmenu to user
    /**
     Links a rich menu to a user.
     
     Only one rich menu can be linked to a user at one time. If a user already has a rich menu linked, calling this endpoint replaces the existing rich menu with the one specified in your request.
     
     The rich menu is displayed in the following order of priority (highest to lowest):
     1. The per-user rich menu set with the Messaging API
     1. The [default rich menu set with the Messaging API](https://developers.line.biz/en/reference/messaging-api/#set-default-rich-menu)
     1. The [default rich menu set with LINE Official Account Manager](https://developers.line.biz/en/docs/messaging-api/using-rich-menus/#creating-a-rich-menu-with-the-line-manager)
     
     - Parameters:
         - request: Client request
         - menuID: ID of richmenu
         - userID: User ID. Found in the source object of webhook event objects. Do not use the LINE ID used in LINE.
     
     - Returns:
        Returns status code `200` and an empty JSON object.
     */
    public func lineMenu(_ request: Request, menuID id: String, userID: String) -> EventLoopFuture<HTTPStatus> {
        request.client.post(URI(string: API.user(userID, menuID: id).url), headers: self.line.headers)
            .flatMapThrowing { res in
                if res.status.code != 200 {
                    let error = try? res.content.decode(LineAPIErrorResponse.self)
                    
                    throw Abort(res.status, reason: error?.message)
                }
                
                return res.status
            }
    }
    
    // MARK: line richmenu to users
    /**
     Links a rich menu to multiple users.
     
     The rich menu is displayed in the following order of priority (highest to lowest):
     1. The per-user rich menu set with the Messaging API
     1. The [default rich menu set with the Messaging API](https://developers.line.biz/en/reference/messaging-api/#set-default-rich-menu)
     1. The [default rich menu set with LINE Official Account Manager](https://developers.line.biz/en/docs/messaging-api/using-rich-menus/#creating-a-rich-menu-with-the-line-manager)
     
     - Parameters:
         - request: Client request
         - menuID: ID of richmenuID
         - userIDs: Array of user IDs. Found in the source object of webhook event objects. Do not use the LINE ID used in LINE.
            - Max: 500 user IDs
     
     - Returns:
         Returns status code `202` and an empty JSON object.
         
         Unlike **linking a rich menu to a user**, this request is processed asynchronously in the background. Normally, the process is completed within a few seconds.
         
         To verify whether the request was processed successfully, **get the rich menu ID linked to the users** and check if the rich menu is actually linked to the users.
     */
    public func lineMenu(_ request: Request, menuID id: String, userIDs: [String]) -> EventLoopFuture<HTTPStatus> {
        request.client.post(URI(string: API.linkMultipleUsers.url), headers: self.line.headers) { req in
            try req.content.encode(LineRichmenuLinkMultipleUsers(menuID: id, userIDs: userIDs))
        }.flatMapThrowing { res in
            if res.status.code != 202 {
                let error = try? res.content.decode(LineAPIErrorResponse.self)
                
                guard error?.details != nil else {
                    throw Abort(res.status, reason: error?.message)
                }
                
                let data = try JSONEncoder().encode(error)
                let reason = String(data: data, encoding: .utf8)
                
                throw Abort(res.status, reason: reason)
            }
            
            return res.status
        }
    }
    
    /**
     Links a rich menu to multiple users.
     
     The rich menu is displayed in the following order of priority (highest to lowest):
     1. The per-user rich menu set with the Messaging API
     1. The [default rich menu set with the Messaging API](https://developers.line.biz/en/reference/messaging-api/#set-default-rich-menu)
     1. The [default rich menu set with LINE Official Account Manager](https://developers.line.biz/en/docs/messaging-api/using-rich-menus/#creating-a-rich-menu-with-the-line-manager)
     
     - Parameters:
        - request: Client request
        - menuID: ID of richmenuID
        - userIDs: Array of user IDs. Found in the source object of webhook event objects. Do not use the LINE ID used in LINE.
            - Max: 500 user IDs
     
     - Returns:
        Returns status code `202` and an empty JSON object.
     
        Unlike **linking a rich menu to a user**, this request is processed asynchronously in the background. Normally, the process is completed within a few seconds.
     
        To verify whether the request was processed successfully, **get the rich menu ID linked to the users** and check if the rich menu is actually linked to the users.
     */
    public func lineMenu(_ request: Request, menuID id: String, userIDs: String...) -> EventLoopFuture<HTTPStatus> {
        self.lineMenu(request, menuID: id, userIDs: userIDs)
    }
    
    // MARK: create richmenu alias
    /**
     [SwitchingBetweenMultipleRichmenus]: https://developers.line.biz/en/docs/messaging-api/using-rich-menus/#switching-between-multiple-rich-menus
     [CreateRichmenu]: https://developers.line.biz/en/reference/messaging-api/#create-rich-menu
     [UploadRichmenuImage]: https://developers.line.biz/en/reference/messaging-api/#upload-rich-menu-image
     
     Creates a rich menu alias.
     
     To create a rich menu alias, make sure to finish these tasks in advance. For more information, see [Switching between multiple rich menus][SwitchingBetweenMultipleRichmenus] in the Messaging API documentation.
     - [Create a rich menu][CreateRichmenu]
     - [Upload a rich menu image][UploadRichmenuImage]
     
     Using the Messaging API, you can create up to 1000 rich menu aliases per one LINE Official Account.
     
     - Parameters:
        - request: Client request
        - menuID: The rich menu ID to be associated with the rich menu alias.
        - aliasID: Rich menu alias ID, which can be any ID, unique for each channel.
            - Max character limit: 100
            - Supported character types: Half-width alphanumeric characters (`a-z`, `A-Z`, `0-9`), underscore (`_`), and hyphen (`-`)
     
     - Returns:
        Returns the `200` HTTP status code and an empty JSON object.
     
        # Error Response
     
        Returns the `400` HTTP status code and an error response.
     */
    public func createAlias(_ request: Request, menuID: String, aliasID id: String) -> EventLoopFuture<HTTPStatus> {
        request.client.post(URI(string: API.alias().url), headers: self.line.headers) { req in
            var data: [String: String] = [:]
            data["richMenuAliasId"] = id
            data["richMenuId"] = menuID
            try req.content.encode(data)
        }.flatMapThrowing { res in
            if res.status.code != 200 {
                let error = try? res.content.decode(LineAPIErrorResponse.self)
                
                guard error?.details != nil else {
                    throw Abort(res.status, reason: error?.message)
                }
                
                let data = try JSONEncoder().encode(error)
                let reason = String(data: data, encoding: .utf8)
                
                throw Abort(res.status, reason: reason)
            }
            
            return res.status
        }
    }
    
    // MARK: delete richmenu alias
    /**
     Deletes rich menu alias.
     
     - Parameters:
        - request: Client request
        - aliasID: The rich menu alias ID whose information you want to obtain.
     
     - Returns:
        Returns the `200` HTTP status code and an empty JSON object.
     
        # Error Response
     
        Returns the `400` HTTP status code and an error response.
     */
    public func deleteAlias(_ request: Request, aliasID id: String) -> EventLoopFuture<HTTPStatus> {
        request.client.delete(URI(string: API.alias(id).url), headers: self.line.headers)
            .flatMapThrowing { res in
                if res.status.code != 200 {
                    let error = try? res.content.decode(LineAPIErrorResponse.self)
                    
                    guard error?.details != nil else {
                        throw Abort(res.status, reason: error?.message)
                    }
                    
                    let data = try JSONEncoder().encode(error)
                    let reason = String(data: data, encoding: .utf8)
                    
                    throw Abort(res.status, reason: reason)
                }
                
                return res.status
            }
    }
    
    // MARK: update richmenu alias
    /**
     Updates rich menu aliases.
     
     You can specify an existing rich menu alias to modify the associated rich menu.
     
     - Parameters:
        - request: Client request
        - menuID: ID of richmenu.
        - aliasID: The rich menu alias ID whose information you want to obtain.
     
     - Returns:
        Returns the `200` HTTP status code and an empty JSON object.
     
        # Error Response
     
        Returns the `400` HTTP status code and an error response.
     */
    public func updateAlias(_ request: Request, menuID: String, aliasID id: String) -> EventLoopFuture<HTTPStatus> {
        request.client.post(URI(string: API.alias(id).url), headers: self.line.headers) { req in
            let data: [String: String] = ["richMenuId": menuID]
            try req.content.encode(data)
        }.flatMapThrowing { res in
            if res.status.code != 200 {
                let error = try? res.content.decode(LineAPIErrorResponse.self)
                
                guard error?.details != nil else {
                    throw Abort(res.status, reason: error?.message)
                }
                
                let data = try JSONEncoder().encode(error)
                let reason = String(data: data, encoding: .utf8)
                
                throw Abort(res.status, reason: reason)
            }
            
            return res.status
        }
    }
    
    // MARK: get richmenu alias information
    /**
     Specifies rich menu alias ID to get information of the rich menu alias.
     
     - Parameters:
        - request: Client request
        - aliasID: The rich menu alias ID whose information you want to obtain.
     
     - Returns:
        Returns the `200` HTTP status code and an empty JSON object.
     
        # Error Response
     
        Returns the `400` HTTP status code and an error response.
     */
    public func alias(_ request: Request, aliasID: String) -> EventLoopFuture<LineRichmenuAliasResponse> {
        request.client.get(URI(string: API.alias(aliasID).url), headers: self.line.headers)
            .flatMapThrowing { res in
                if res.status.code != 200 {
                    let error = try? res.content.decode(LineAPIErrorResponse.self)
                    
                    guard error?.details != nil else {
                        throw Abort(res.status, reason: error?.message)
                    }
                    
                    let data = try JSONEncoder().encode(error)
                    let reason = String(data: data, encoding: .utf8)
                    
                    throw Abort(res.status, reason: reason)
                }
                
                return try res.content.decode(LineRichmenuAliasResponse.self)
            }
    }
    
    // MARK: get list of richmenu alias
    /**
     Gets the rich menu alias list.
     
     - Parameters:
        - request: Client request
     
     - Returns:
        Returns the `200` HTTP status code and a JSON object containing these values.
     
        # Error Response
  
        Returns the `400` HTTP status code and an error response.
     */
    public func alias(_ request: Request) -> EventLoopFuture<[LineRichmenuAliasResponse]> {
        request.client.get(URI(string: API.aliasList.url), headers: self.line.headers)
            .flatMapThrowing { res in
                if res.status.code != 200 {
                    let error = try? res.content.decode(LineAPIErrorResponse.self)
                    
                    guard error?.details != nil else {
                        throw Abort(res.status, reason: error?.message)
                    }
                    
                    let data = try JSONEncoder().encode(error)
                    let reason = String(data: data, encoding: .utf8)
                    
                    throw Abort(res.status, reason: reason)
                }
                
                let response = try res.content.decode([String: [LineRichmenuAliasResponse]].self)
                
                return response.values.first ?? []
            }
    }
    
    // MARK: get richmenu id of user
    /**
     Gets the ID of the rich menu linked to a user.
     
     - Parameters:
        - request: Client response
        - userID: User ID. Found in the source object of webhook event objects. Do not use the LINE ID used in LINE.
     
     - Returns:
        Returns status code `200` and a JSON object with the rich menu ID.
     */
    public func lineMenu(_ request: Request, userID: String) -> EventLoopFuture<LineRichmenuResponseObject> {
        request.client.get(URI(string: API.user(userID).url), headers: self.line.headers)
            .flatMapThrowing { res in
                if res.status.code != 200 {
                    let error = try? res.content.decode(LineAPIErrorResponse.self)
                    
                    throw Abort(res.status, reason: error?.message)
                }
                
                return try res.content.decode(LineRichmenuResponseObject.self)
            }
    }
    
    // MARK: unlink richmenu from user
    /**
     API that removes the per-user rich menu linked to a specified user.
     
     - Parameters:
        - request: Client response
        - userID: User ID. Found in the source object of webhook event objects. Do not use the LINE ID used in LINE.
     
     - Returns:
        Returns status code `200` and a JSON object with the rich menu ID.
     */
    public func unlinkMenu(_ request: Request, userID: String) -> EventLoopFuture<HTTPStatus> {
        request.client.delete(URI(string: API.user(userID).url), headers: self.line.headers)
            .flatMapThrowing { res in
                if res.status.code != 200 {
                    let error = try? res.content.decode(LineAPIErrorResponse.self)
                    
                    throw Abort(res.status, reason: error?.message)
                }
                
                return res.status
            }
    }
    
    // MARK: unlink richmenu from multiple users
    /**
     Unlinks rich menus from multiple users.
     
     - Parameters:
        - request: Client response
        - userIDs: Array of user IDs. Found in the source object of webhook event objects. Do not use the LINE ID used in LINE.
            - Max: 500 user IDs
     
     - Returns:
        Returns status code `202` and an empty JSON object.
     
        Unlike **unlinking a rich menu from a user**, this request is processed asynchronously in the background. Normally, the process is completed within a few seconds.
     
        To verify whether the request was processed successfully, **get the rich menu ID linked to the users** and check if the rich menu is actually linked to the users.
     */
    public func unlinkMenu(_ request: Request, userIDs: [String]) -> EventLoopFuture<HTTPStatus> {
        request.client.post(URI(string: API.unlinkMultipleUsers.url), headers: self.line.headers) { req in
            try req.content.encode(LineRichmenuLinkMultipleUsers(userIDs: userIDs))
        }.flatMapThrowing { res in
            if res.status.code != 202 {
                let error = try? res.content.decode(LineAPIErrorResponse.self)

                throw Abort(res.status, reason: error?.message)
            }
            
            return res.status
        }
    }
    
    /**
     Unlinks rich menus from multiple users.
     
     - Parameters:
        - request: Client response
        - userIDs: Array of user IDs. Found in the source object of webhook event objects. Do not use the LINE ID used in LINE.
            - Max: 500 user IDs
     
     - Returns:
        Returns status code `202` and an empty JSON object.
     
        Unlike **unlinking a rich menu from a user**, this request is processed asynchronously in the background. Normally, the process is completed within a few seconds.
     
        To verify whether the request was processed successfully, **get the rich menu ID linked to the users** and check if the rich menu is actually linked to the users.
     */
    public func unlinkMenu(_ request: Request, userIDs: String...) -> EventLoopFuture<HTTPStatus> {
        self.unlinkMenu(request, userIDs: userIDs)
    }
}
