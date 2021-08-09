# Vapor Line

A Vapor extension package for [Line Messaging Api](https://developers.line.biz/en/docs/messaging-api/)

## Features

- [x] [Verify webhook message](#webhook-verify)
- [x] [Validation middleware](#line-middleware)
- [x] [Richmenu APIs](https://github.com/nier-spm/vapor-line/blob/develop/Documents/Richmenu.md)
- [x] [Webhook Setting APIs](https://github.com/nier-spm/vapor-line/blob/develop/Documents/Webhook.md)

## Installation

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/nier-spm/vapor-line.git", from: "0.0.2")
],
```

## Usage

```swift
// Package.swift
targets: [
    .target(
        name: "App",
        dependencies: [
            .product(name: "VaporLine", package: "vapo-line"),
            ...
        ],
    }
],
```

## Import

```swift
import VaporLine
```

### Create Line Service Instance

```swift
let id: String = "{{your_line_channel_id}}"
let secret: String = "{{your_line_channel_secret}}"
let accessToken: String = "{{your_line_channel_access_token}}"

let line: Line = Line(id, secret, accessToken)
```

If you store `channel id`, `channel secret` and `channel access token` in `.env`, use: 

```swift
let idKey: String = "{{your_line_channel_id_key}}"
let secretKey: String = "{{your_line_channel_secret_key}}"
let accessTokenKey: String = "{{your_line_channel_access_token_key}}"

let line: Line = try Line.environment(idKey, secretKey, accessTokenKey)
```

If your **enviornment keys** with the same **prefix** with `_ID`, `_SECRET` and `_ACCESS_TOKEN`, for example: `LINE_CHANNEL_ID`, `LINE_CHANNEL_SECRET`, and `LINE_CHANNEL_ACCESS_TOKEN`, use: 

```swift
let line: Line = try Line.environment("{{your_enviornment_prefix}}")
```

### Webhook Verify

```swift
let line: Line = Line()             // Line Service
let request: Request = Request()    // Client Request

guard let signature = request.headers["x-line-signature"].first,
      let body = request.body.string else { return }
      
let result: Result<Bool, LineError> = line.webhook.verify(signature, body)
```

If webhook message come from Line, the `result` is `success`.

### Line Middleware

Vapor Line also provide **middleware** to verify webhook.

```swift
let line: Line = Line() // Line Service

func boot(routes: RoutesBuilder) throws {
    let middleware: LineMiddleware = LineMiddleware(service: self.line)
    
    let protectRoutes = routes.grouped(middleware)
}
```