# Richmenu

## Introduction

This document introduce the api for **Line Richmenu**.
For more information about **Line Richmenu** api, See [Rich menu | LINE Developers](https://developers.line.biz/en/reference/messaging-api/#rich-menu).

If you want to know more how to use, create or more introduction about **Line Richmenu**, see [Using rich menus | LINE Developers](https://developers.line.biz/en/docs/messaging-api/using-rich-menus/#page-title).

## APIs

- [Create rich menu](#create-rich-menu)
- [Upload rich menu image](#upload-rich-menu-image)
	- [from local directory](#from-local-directory)
	- [from public directory](#from-public-directory)
- [Download rich menu image](#download-rich-menu-image)
	- [save to local](#save-to-local)
- [Get rich menu list](#get-rich-menu-list)
- [Get rich menu](#get-rich-menu)
- [Set default rich menu](#set-default-rich-menu)
- [Get default rich menu ID](#get-default-rich-menu-id)
- [Cancel default rich menu](#cancel-default-rich-menu)
- [Link rich menu to user](#link-rich-menu-to-user)
- [Link rich menu to multiple users](#link-rich-menu-to-multiple-users)
- [Create rich menu alias](#create-rich-menu-alias)
- [Delete rich menu alias](#delete-rich-menu-alias)
- [Update rich menu alias](#update-rich-menu-alias)
- [Get rich menu alias information](#get-rich-menu-alias-information)
- [Get list of rich menu alias](#get-list-of-rich-menu-alias)
- [Get rich menu ID of user](#get-rich-menu-id-of-user)
- [Unlink rich menu from user](#unlink-rich-menu-from-user)
- [Unlink rich menus from multiple users](#unlink-rich-menus-from-multiple-users)

### Create rich menu

Creates a rich menu.

You must [upload a rich menu image](https://developers.line.biz/en/reference/messaging-api/#upload-rich-menu-image), and [set the rich menu as the default rich menu](https://developers.line.biz/en/reference/messaging-api/#set-default-rich-menu) or [link the rich menu to a user](https://developers.line.biz/en/reference/messaging-api/#link-rich-menu-to-user) for the rich menu to be displayed. You can create up to 1000 rich menus for one LINE Official Account with the Messaging API.

```swift
let line: Line = Line()             // Line Service
let request: Request = Request()    // Client Request
let richmenu: LineRichmenu = LineRichmenu()	// Richmenu content

line.richmenu.create(request, richmenu: richmenu) 	// return ClientResponse
	.flatMapThrowing { res in
		// response handler
	}
```

#### Response

Returns status code `200` and a JSON object with the rich menu ID.

### Upload rich menu image

Uploads and attaches an image to a rich menu.

You can use rich menu images with the following specifications:

- Image format: JPEG or PNG
- Image width size (pixels): 800 to 2500
- Image height size (pixels): 250 or more
- Image aspect ratio (width/height): 1.45 or more
- Max file size: 1 MB

```swift
let line: Line = Line()             // Line Service
let request: Request = Request()    // Client Request
let menuID: String = "richmenu-97e6230f699a6ad3b9e5c973d1ef68ea"

line.richmenu.content(request, menuID: menuID)
```

#### From Local Directory

Upload richmenu image from local.

```swift
let line: Line = Line()             // Line Service
let request: Request = Request()    // Client Request
let menuID: String = "richmenu-97e6230f699a6ad3b9e5c973d1ef68ea"

line.richmenu.content(request, menuID: menuID, path: "path-to-local-image")
```

#### From Public Directory

Upload richmenu image from local, will open file from public directory of application.

```swift
let line: Line = Line()             // Line Service
let request: Request = Request()    // Client Request
let menuID: String = "richmenu-97e6230f699a6ad3b9e5c973d1ef68ea"

line.richmenu.content(request, menuID: menuID, filename: "name-of-image-in-public-directory")
```

#### Response

Returns status code `200` and an empty JSON object.

### Download rich menu image

```swift
let line: Line = Line()             // Line Service
let request: Request = Request()    // Client Request
let menuID: String = "richmenu-97e6230f699a6ad3b9e5c973d1ef68ea"

line.richmenu.content(request, menuID: menuID) 	// return ClientResponse
```

#### Save to Local

```swift
let line: Line = Line()             // Line Service
let request: Request = Request()    // Client Request
let menuID: String = "richmenu-97e6230f699a6ad3b9e5c973d1ef68ea"

line.richmenu.content(request, menuID: menuID, folder: "path-to-save-in-public-direcotry") 	// return filename
```

#### Response

Returns status code `200` and the binary data of the rich menu image.

### Get rich menu list

Gets a list of the rich menu response object of all rich menus created by [Create a rich menu](https://developers.line.biz/en/reference/messaging-api/#create-rich-menu).

```swift
let line: Line = Line()             // Line Service
let request: Request = Request()    // Client Request

line.richmenu.list(request) 	// return array of LineRichmenuResponseObject
```

#### Response

Returns status code `200` and [a list of rich menu response objects](https://developers.line.biz/en/reference/messaging-api/#rich-menu-response-object).

### Get rich menu

Gets a rich menu via a rich menu ID.

```swift
let line: Line = Line()             // Line Service
let request: Request = Request()    // Client Request
let menuID: String = "richmenu-97e6230f699a6ad3b9e5c973d1ef68ea"

line.richmenu.menu(request, menuID: menuID) 	// return LineRichmenuResponseObject
```

#### Response

Returns status code `200` and a [rich menu response object](https://developers.line.biz/en/reference/messaging-api/#rich-menu-response-object).

### Delete rich menu

Deletes a rich menu.

```swift
let line: Line = Line()             // Line Service
let request: Request = Request()    // Client Request
let menuID: String = "richmenu-97e6230f699a6ad3b9e5c973d1ef68ea"

line.richmenu.delete(request, menuID: menuID)
```

#### Response

Returns status code `200` and an empty JSON object.

### Set default rich menu

Sets the default rich menu. The default rich menu is displayed to all users who have added your LINE Official Account as a friend and are not linked to any per-user rich menu. If a default rich menu has already been set, calling this endpoint replaces the current default rich menu with the one specified in your request.

The rich menu is displayed in the following order of priority (highest to lowest):

1. [The per-user rich menu set with the Messaging API](https://developers.line.biz/en/reference/messaging-api/#link-rich-menu-to-user)
1. The default rich menu set with the Messaging API
1. The [default rich menu set with LINE Official Account Manager](https://developers.line.biz/en/docs/messaging-api/using-rich-menus/#creating-a-rich-menu-with-the-line-manager)

```swift
let line: Line = Line()             // Line Service
let request: Request = Request()    // Client Request
let menuID: String = "richmenu-97e6230f699a6ad3b9e5c973d1ef68ea"

line.richmenu.defaultMenu(request, menuID: menuID)
```

#### Response

Returns status code `200` and an empty JSON object.

### Get default rich menu ID

Gets the ID of the default rich menu set with the Messaging API.

```swift
let line: Line = Line()             // Line Service
let request: Request = Request()    // Client Request

line.richmenu.defaultMenu(request) 	// return LineRichmenuResponseObject
```

#### Response

Returns status code `200` and a JSON object with the rich menu ID.

### Cancel default rich menu

Cancels the default rich menu set with the Messaging API.

```swift
let line: Line = Line()             // Line Service
let request: Request = Request()    // Client Request

line.richmenu.defaultMenu(request)
```

#### Response

Returns status code `200` and an empty JSON object.

### Link rich menu to user

Links a rich menu to a user. Only one rich menu can be linked to a user at one time. If a user already has a rich menu linked, calling this endpoint replaces the existing rich menu with the one specified in your request.

The rich menu is displayed in the following order of priority (highest to lowest):

1. The per-user rich menu set with the Messaging API
1. The [default rich menu set with the Messaging API](https://developers.line.biz/en/reference/messaging-api/#set-default-rich-menu)
1. The [default rich menu set with LINE Official Account Manager](https://developers.line.biz/en/docs/messaging-api/using-rich-menus/#creating-a-rich-menu-with-the-line-manager)

```swift
let line: Line = Line()             // Line Service
let request: Request = Request()    // Client Request
let menuID: String = "richmenu-97e6230f699a6ad3b9e5c973d1ef68ea"

line.richmenu.lineMenu(request, menuID: menuID, userID: "line-user-id")
```

#### Response

Returns status code `200` and an empty JSON object.

### Link rich menu to multiple users

Links a rich menu to multiple users.

The rich menu is displayed in the following order of priority (highest to lowest):

1. The per-user rich menu set with the Messaging API
1. The [default rich menu set with the Messaging API](https://developers.line.biz/en/reference/messaging-api/#set-default-rich-menu)
1. The [default rich menu set with LINE Official Account Manager](https://developers.line.biz/en/docs/messaging-api/using-rich-menus/#creating-a-rich-menu-with-the-line-manager)

```swift
let line: Line = Line()             // Line Service
let request: Request = Request()    // Client Request
let menuID: String = "richmenu-97e6230f699a6ad3b9e5c973d1ef68ea"

line.richmenu.lineMenu(request, menuID: menuID, userIDs: ["line-user-id"])
line.richmenu.lineMenu(request, menuID: menuID, userIDs: "line-user-id-1", "line-user-id-2", …)
```

#### Response

Returns status code `202` and an empty JSON object.

Unlike [linking a rich menu to a user](https://developers.line.biz/en/reference/messaging-api/#link-rich-menu-to-user), this request is processed asynchronously in the background. Normally, the process is completed within a few seconds.

To verify whether the request was processed successfully, [get the rich menu ID linked to the users](https://developers.line.biz/en/reference/messaging-api/#get-rich-menu-id-of-user) and check if the rich menu is actually linked to the users.

### Create rich menu alias

Creates a rich menu alias.

To create a rich menu alias, make sure to finish these tasks in advance. For more information, see [Switching between multiple rich menus](https://developers.line.biz/en/docs/messaging-api/using-rich-menus/#switching-between-multiple-rich-menus) in the Messaging API documentation.

- [Create a rich menu](https://developers.line.biz/en/reference/messaging-api/#create-rich-menu)
- [Upload a rich menu image](https://developers.line.biz/en/reference/messaging-api/#upload-rich-menu-image)

Using the Messaging API, you can create up to 1000 rich menu aliases per one LINE Official Account.

```swift
let line: Line = Line()             // Line Service
let request: Request = Request()    // Client Request
let menuID: String = "richmenu-97e6230f699a6ad3b9e5c973d1ef68ea"
let aliasID: String = "richmenu-alias-1"

line.richmenu.createAlias(request, menuID: menuID, aliasID: aliasID)
```

#### Response

Returns status code `200` and an empty JSON object.

> **Error Response**
>
> Returns the `400` HTTP status code and an error response. For more information, see [error responses](https://developers.line.biz/en/reference/messaging-api/#error-responses) in [common specifications](https://developers.line.biz/en/reference/messaging-api/#common-specifications).

### Delete rich menu alias

Deletes rich menu alias.

```swift
let line: Line = Line()             // Line Service
let request: Request = Request()    // Client Request
let aliasID: String = "richmenu-alias-1"

line.richmenu.deleteAlias(request, aliasID: aliasID)
```

#### Response

Returns status code `200` and an empty JSON object.

> **Error Response**
>
> Returns the `400` HTTP status code and an error response. For more information, see [error responses](https://developers.line.biz/en/reference/messaging-api/#error-responses) in [common specifications](https://developers.line.biz/en/reference/messaging-api/#common-specifications).

### Update rich menu alias

Updates rich menu aliases. You can specify an existing rich menu alias to modify the associated rich menu.

```swift
let line: Line = Line()             // Line Service
let request: Request = Request()    // Client Request
let menuID: String = "richmenu-97e6230f699a6ad3b9e5c973d1ef68ea"
let aliasID: String = "richmenu-alias-1"

line.richmenu.updateAlias(request, menuID: menuID, aliasID: aliasID)
```

#### Response

Returns status code `200` and an empty JSON object.

> **Error Response**
>
> Returns the `400` HTTP status code and an error response. For more information, see [error responses](https://developers.line.biz/en/reference/messaging-api/#error-responses) in [common specifications](https://developers.line.biz/en/reference/messaging-api/#common-specifications).

### Get rich menu alias information

Specifies rich menu alias ID to get information of the rich menu alias.

```swift
let line: Line = Line()             // Line Service
let request: Request = Request()    // Client Request
let aliasID: String = "richmenu-alias-1"

line.richmenu.alias(request, aliasID: aliasID) 	// return LineRichmenuAliasResponse
```

#### Response

Returns the `200` HTTP status code and a JSON object containing these values.

> **LineRichmenuAliasResponse**
>
> | proterty | type | |
> | :-- | :-: | :-- |
> | aliasID | String | Rich menu alias ID |
> | menuID | String | The rich menu ID associated with the rich menu alias |

> **Error Response**
>
> Returns the `400` HTTP status code and an error response. For more information, see [error responses](https://developers.line.biz/en/reference/messaging-api/#error-responses) in [common specifications](https://developers.line.biz/en/reference/messaging-api/#common-specifications).

### Get list of rich menu alias

Gets the rich menu alias list.

```swift
let line: Line = Line()             // Line Service
let request: Request = Request()    // Client Request
let aliasID: String = "richmenu-alias-1"

line.richmenu.alias(request, aliasID: aliasID) 	// return array of LineRichmenuAliasResponse
```

#### Response

Returns the `200` HTTP status code and a JSON object containing these values.

> **LineRichmenuAliasResponse**
>
> | proterty | type | |
> | :-- | :-: | :-- |
> | aliasID | String | Rich menu alias ID |
> | menuID | String | The rich menu ID associated with the rich menu alias |

> **Error Response**
>
> Returns the `400` HTTP status code and an error response. For more information, see [error responses](https://developers.line.biz/en/reference/messaging-api/#error-responses) in [common specifications](https://developers.line.biz/en/reference/messaging-api/#common-specifications).

### Get rich menu ID of user

Gets the ID of the rich menu linked to a user.

```swift
let line: Line = Line()             // Line Service
let request: Request = Request()    // Client Request

line.richmenu.lineMenu(request, userID: "line-user-id")
```

#### Response

Returns status code `200` and a JSON object with the rich menu ID.

### Unlink rich menu from user

API that removes the per-user rich menu linked to a specified user.

```swift
let line: Line = Line()             // Line Service
let request: Request = Request()    // Client Request

line.richmenu.unlinkMenu(request, userID: "line-user-id")
```

#### Response

Returns status code `200` and a JSON object with the rich menu ID.

### Unlink rich menus from multiple users

Unlinks rich menus from multiple users.

```swift
let line: Line = Line()             // Line Service
let request: Request = Request()    // Client Request

line.richmenu.unlinkMenu(request, userIDs: ["line-user-id"])
line.richmenu.unlinkMenu(request, userIDs: "line-user-id-1", "line-user-id-2", …)
```

#### Response

Returns status code `202` and an empty JSON object.

Unlike [unlinking a rich menu from a user](https://developers.line.biz/en/reference/messaging-api/#unlink-rich-menu-from-user), this request is processed asynchronously in the background. Normally, the process is completed within a few seconds.

To verify whether the request was processed successfully, [get the rich menu ID linked to the users](https://developers.line.biz/en/reference/messaging-api/#get-rich-menu-id-of-user) and check if the unlinked rich menus are actually not linked to the users.
