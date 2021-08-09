# Webhook

## Introduction

This document introduce the api for **Line Webhooks**.
For more information about **Line Webhooks** api, See [Webhooks | LINE Developers](https://developers.line.biz/en/reference/messaging-api/#webhooks).

## APIs

- [Signature validation](#signature-validation)
- [Webhook Settings](#webhook-settings)
	- [Set webhook endpoint URL](#set-webhook-endpoint-url)
	- [Get webhook endpoint information](#get-webhook-endpoint-information)
	- [Test webhook endpoint](#test-webhook-endpoint)

### Signature validation

The signature in the `x-line-signature` request header must be verified to confirm that the request was sent from the LINE Platform.

Authentication is performed as follows:

1. With the channel secret as the secret key, your application retrieves the digest value in the request body created using the **HMAC-SHA256** algorithm.
1. The server confirms that the `x-line-signature` in the request header matches the Base64-encoded digest value.

```swift
let line: Line = Line()             // Line Service
let request: Request = Request()    // Client Request

guard let signature = request.headers["x-line-signature"].first,
      let body = request.body.string else { return }
      
let result: Result<Bool, LineError> = line.webhook.verify(signature, body)
```

#### Response

If signature validation is fail, you will get an error of **LineError**.

## Webhook Settings

You can configure, test, and get information on channel webhook endpoints.

### Set webhook endpoint URL

Sets the webhook endpoint URL. It may take up to 1 minute for changes to take place due to caching.

```swift
let line: Line = Line()             // Line Service
let request: Request = Request()    // Client Request
      
line.webhook.endpoint(request, endpoint: "webhook-endpoint")
```

#### Response

Returns status code `200` and an empty JSON object.

> Error Response
>
> Returns a `400` HTTP status code if the webhook URL is invalid.

### Get webhook endpoint information

Gets information on a webhook endpoint.

```swift
let line: Line = Line()             // Line Service
let request: Request = Request()    // Client Request
      
line.webhook.endpoint(request, endpoint: "webhook-endpoint")
```

#### Response

Returns status code `200` and a JSON object with the following information.

> **LineWebhookEndpointResponse**
>
> | property | type | |
> | :-- | :-: | :-- |
> | endpoint | String | Webhook URL |
> | active | Bool | Webhook usage status. Send a webhook event from the LINE platform to the webhook URL only if enabled. <ul><li>`true`: Webhook usage is enabled.</li><li>`false`: Webhook usage is disabled.</li></ul> |

### Test webhook endpoint

Checks if the configured webhook endpoint can receive a test webhook event.

```swift
let line: Line = Line()             // Line Service
let request: Request = Request()    // Client Request

line.webhook.test(request)      
line.webhook.test(request, endpoint: "webhook-endpoint")
```

#### Response

Returns status code `200` and a JSON object with the following information.

> **LineWebhookTestResponse**
>
> | property | type | |
> | :-- | :-: | :-- |
> | success | Bool | Result of the communication from the LINE platform to the webhook URL. <ul><li>`true`: Success</li><li>`false`: Failure</li></ul> |
> | timestamp | String | See [Common Properties](https://developers.line.biz/en/reference/messaging-api/#common-properties). |
> | statusCode | Int | The HTTP status code. If the webhook response isn't received, the status code is set to zero or a negative number. |
> | reason | String | Reason for the response. See table below for more information. |
> | detail | String | Details of the response. See table below for more information. |
>
>> | `reason` | `detail` | Description |
>> | --- | --- | --- |
>> | ok | `200` | Successfully sent the webhook |
>> | COULD_NOT_CONNECT | Failure to connect message (Example: Connection failed: {webhook endpoint url}) | Failed to connect |
>> | ERROR_STATUS_CODE | HTTP status code (Example: `400`) | HTTP status code error response |
>> | REQUEST_TIMEOUT | Request timeout | Request time out |
>> | UNCLASSIFIED | N/A | Unknown error |
>
>> **Error response**
>> - Returns a `400` HTTP status code if the webhook URL isn't valid.
>> - Returns a `404` HTTP status code if the webhook URL isn't set.
