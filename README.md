# NetworkingKit

[![CI Status](https://travis-ci.org/BrunoMiguens/NetworkingKit.svg?branch=master)](https://travis-ci.org/BrunoMiguens/NetworkingKit)
[![codecov](https://codecov.io/gh/BrunoMiguens/NetworkingKit/branch/master/graph/badge.svg)](https://codecov.io/gh/BrunoMiguens/NetworkingKit)
[![CocoaPods compatible](https://img.shields.io/badge/CocoaPods-compatible-4BC51D.svg?style=flat)](https://github.com/BrunoMiguens/NetworkingKit/releases)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/BrunoMiguens/NetworkingKit/releases)

This library was created with the purpose of creating a simple networking layer with a easy integration with iOS App Extensions. Although there's a lot of networking managers, this class may be an opportunity to create new and custom libraries.

## Requirements
 - iOS 8.0+
 - Xcode 9.0+
 - Swift 4.0+

## Instalation

#### CocoaPods

CocoaPods is a dependency manager for Cocoa projects. You can install it by following this [guide](https://guides.cocoapods.org/using/getting-started.html).

```ruby
  use_frameworks!

  # Add the instruction below inside your targets on your Podfile.
  pod 'NetworkingKit'
```

After saving the file, please run the command `pod install` to download and integrate the framework into your project.

#### Carthage

Carthage is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.You can install it by following this [guide](https://github.com/Carthage/Carthage#installing-carthage).


```ruby
  # Add the instruction below inside your Cartfile.
  github "BrunoMiguens/NetworkingKit"
```

After saving the file, please run the command `carthage update` to download and build the framework, after finish, copy the `NetworkingKit.framework` into your project.

## Usage

This framework is somehow inspired on [Moya](https://github.com/Moya/Moya) (combined with [Alamofire](https://github.com/Alamofire/Alamofire)), please check those project due to the fact they're stable, having a huge community behind and they deserve the credit.

We'll start by creating a `class` or `enum` (enumerators are normally better for this cases due to how versatile they're) to generate the routing of our API:

```swift
enum ApiService {

  case login(email: String, password: String)
  case fetchArticles(query: String, page: Int?)

  // Continue by adding as many cases as you want.

}
```

Is mandatory that your `ApiService` conforms to the protocol `NetworkingTarget` in order to be used by the `NetworkingKit`:

```swift
extension ApiService: NetworkingTarget {

  // The base URL of your API goes here.
  var baseUrl: String {
    return "https://yourapiurl.com"
  }

  // Use this property to add specific endpoints depending on the service that you want (you can omit the parameters you don't need them)
  var endpoint: String {
    switch value:

      case login: return "/login"
      case fetchArticles: return "/fetch"

    }
  }

  // The HTTP method for each case (get, post, put or delete).
  var method: NetworkingMethod {
    switch value:

      case login: return .post
      case fetchArticles: return .get

    }
  }

  // Use the parameters of each case to construct the dictionary for your HTTP request (NKStringDictionary is a type alias for [String: Any]).
  var parameters: NKStringDictionary {
    switch value:

      case login(let email, let password):
        return ["email": email, "password": password]

      case fetchArticles(let query, let page):
        if let newPage = page {
          return ["query": query, "page": newPage]
        }
        return ["query": query]

    }
  }

  // Sometimes your API may need to encode some parameter, especially if is a get request, for instance, "search[query]=something" in this case the brackets need to be encoded.
  var encodeParameters: Bool {
      return true
  }

  // By requesting something using `NetworkingKit` and giving the parameter `runningTests: true`, the library will return and parse the `sampleData` property, if exists, that way you avoid using the internet and a real API for your Unit/UI tests.
  var sampleData: Any? {
    switch value:

      case login: return ["test": 123]

      // By returning nil the library will ignore your choice and make the HTTP request.
      case fetchArticles: return nil

    }
  }

}
```

Now the only thing you need to do is perform your requests using the `Networking` statement:

```swift
  let login = ApiService.login(email: "email@email.com", password: "12345")

  Networking.perform(for: login) { result in

    // Check the `NKResult` to understand the type of property that `result` represents.

    if let value = result.value, result.isSuccess {
      // Your code
    }

  }
```

Use the statement `Networking.perform(for: login, runningTests: true)`, when you do your request, to tell the networking to fetch for the `sampleData` property , if is not `nil`.

#### Advanced Options

You may want to add custom headers to your requests, to do that you can use the `NetworkingHeaderDictionary` (aka `[NetworkingHeader: String]`) as a parameter.

```swift
  Networking.perform(for: login, headers: yourCustomHeaders) { result in
      // Your code
  }
```

## Author

Feel free to contribute, give feedback or whatever you feel that you need to share.

[GitHub](https://github.com/BrunoMiguens) | [Twitter](https://twitter.com/BrunoMiguns)

## License

NetworkingKit is available under the MIT license. See the LICENSE file for more info.
