# FFNetworking

[![CI Status](http://img.shields.io/travis/ArKalmykov/FFNetworking.svg?style=flat)](https://travis-ci.org/ArKalmykov/FFNetworking)
[![Version](https://img.shields.io/cocoapods/v/FFNetworking.svg?style=flat)](http://cocoapods.org/pods/FFNetworking)
[![License](https://img.shields.io/cocoapods/l/FFNetworking.svg?style=flat)](http://cocoapods.org/pods/FFNetworking)
[![Platform](https://img.shields.io/cocoapods/p/FFNetworking.svg?style=flat)](http://cocoapods.org/pods/FFNetworking)

FFNetworking is an HTTP networking framework built upon Alamofire in Swift. Doing just one request may seem more complicated than in Alamofire, but it proves itself in real projects.

## Features
- [x] Simple-to-use overlay over Alamofire.
- [x] Request URL handling.
- [x] Global request headers control.
- [ ] Custom headers for specific requests.
- [x] Error categorization.
- [x] Constants for HTTP status codes.
- [ ] Automatic errors handling.
- [x] Request cancellation and delayed start.
- [x] Raw and JSON response types.
- [x] Request timeout control.
- [x] Request cancellation.
- [ ] Mocked requests.
- [ ] File uploads.
- [ ] Request progress updates.
- [ ] Automatic and manual request retrying on failure.
- [ ] Request grouping and chaining.

## Requirements

- iOS 8.0+
- Xcode 8.3+
- Swift 4.0+

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

FFNetworking is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "FFNetworking"
```

## Usage

### Making a simple request

```swift
enum ExampleRequest
{
    case simpleGET
}

extension ExampleRequest: RequestProvider
{
    var relativeURL: String
    {
        return "ip"
    }
}

Networking.baseURL = "https://httpbin.org/"
Networking.sendRequest(ExampleRequest.simpleGET) { (success, responseObject, error) in
    print("Success: \(success)")
    print("Response object: \(String(describing: responseObject))")
    print("Error: \(String(describing: error))")
}
```

`RequestProvider` protocol provides a lot of other optional functionality.

### Specifying HTTP method

Default HTTP method is `GET`. Supported methods: `GET`, `POST`, `PUT`, `DELETE`, `HEAD`, `OPTIONS` and `CONNECT`.

```swift
enum ExampleRequest
{
    case simpleGET
    case simplePOST
}

extension ExampleRequest: RequestProvider
{
    var httpMethod: HTTPMethod
    {
        switch self
        {
        case .simpleGET:
            return .get
        case .simplePOST:
            return .post
        }
    }
}
```

### Specifying parameters and encoding

Default parameters are `nil`. Default encoding is `.url`. Another options is only `.json`

```swift
enum ExampleRequest
{
    case simpleGET
    case simplePOST
}

extension ExampleRequest: RequestProvider
{
    var parameters: Any?
    {
        switch self
        {
        case .simpleGET:
            return ["arg1": 1]
        case .simplePOST:
            return ["arg1": 2]
        }
    }
    
    var parameterEncoding: NetworkingParametersEncoding
    {
        switch self
        {
        case .simpleGET:
            return .url
        case .simplePOST:
            return .json
        }
    }
}
```

### Specifying response type

Response could be either raw data (`.data`) or json (`.json`):

```swift
enum ExampleRequest
{
    case simpleGET
    case simplePOST
}

extension ExampleRequest: RequestProvider
{
    var responseType: NetworkingResponseType
    {
        switch self
        {
        case .simpleGET:
            return .data
        case .simplePOST:
            return .json
        }
    }
}
```

### Request headers

Headers are set globally for all requests.

To add a new header:

```swift
Networking.addDefaultHeader(forKey: "Authorization", value: "auth-h")
```

To obtain list of currently active headers:

```swift
Networking.defaultHeaders
```

To remove a header:

```swift
Networking.removeDefaultHeader(withKey: "Authorization")
```

### Timeouts

Timeout can be set globally for all requests and overriden for a specific ones.

To modify global timeout (10 seconds by default):

```swift
Networking.requestTimeout = 20.0
```

To set a custom timeout for a specific request:

```swift
extension ExampleRequest: RequestProvider
{
    var timeout: Double
    {
        return 20.0
    }
}
```

### Cancelling request

```swift
let request = Networking.sendRequest(ExampleRequest.simpleGET)
request.cancel()
```

### Delayed request start

By default requests are started immediately after initialization. To bypass this behaviour, `automaticallyStartRequest` should be set to `false` in `RequestProvider`:

```swift
extension ExampleRequest: RequestProvider
{
    var automaticallyStartRequest: Bool
    {
        return false
    }
}

let request = Networking.sendRequest(ExampleRequest.simpleGET)
request.start()
```

### Request URL control

By default, request's relative URL is appended to global base URL, defined in `Networking`. If such functionality is not required, it can be turned off for a specific request:

```swift
extension ExampleRequest: RequestProvider
{
    var usesBaseURL: Bool
    {
        return false
    }
}
```

### Error handling

Error is returned in request's completion handler. If request succeeds, error is `nil`. There are 3 types of errors:

- Connection errors. Happen on timeouts, no connection, bad connection etc.
- Server errors. Happen if request reaches server, but server couldn't process the request.
- Serialization errors. Happen if server successfully replies, but the response couldn't be parsed. Doesn't happen for raw data requests.

## Author

ArKalmykov, ar.kalmykov@gmail.com

## License

FFNetworking is available under the MIT license. See the LICENSE file for more info.
