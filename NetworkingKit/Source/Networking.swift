//
//  Networking.swift
//  NetworkingKit
//
//  Created by Bruno Miguêns on 10/03/2017.
//  Copyright © 2018 Bruno Filipe Miguêns. All rights reserved.
//

import Foundation

/**
 This class will be the networking layer responsible to communicate with an API in a most generic way possible. Should be possible to incorporate this networking layer inside of the app or app extensions without much effort, due to the usage of system services suach as the `URLSession` and so on.
 
 In case of you need to change something, remember of keeping the tweaks or features as generic as possible and usable in all iOS environments (app extension and so on).
 
 **Note:**
 You should not change much the following class, in case of you need to create a communication with the API about some specific thing then create an extension inside of the 'Requests' folder and use the `perform(for:completion:)` to make the call.
 */
class Networking {

    // MARK: Methods

    /// This method is responsible to perform a traditional HTTP GET call, based on a route and a given completion.
    ///
    /// - Parameters:
    ///   - router: Represents the route that you want to follow using 'NetworkingRouter' enum, if exists, some routers have the ability to transport parameters or other objects.
    ///   - completion: This is a typical completion handler based on 'NetworkingResult' enum.
    class func perform(for router: NetworkingTarget, headers: NetworkingHeaderDictionary? = nil, completion: @escaping NetworkingHandler) {
        let result = router.urlRequest(for: headers)

        guard let request = result.value, result.isSuccess else {
            completion(NetworkingResult.Failure(result.error))
            return
        }

        URLSession.shared.task(router: router, request: request) { (object, response, error) in
            self.deserialize(response: response, with: object, and: error, to: completion)
        }?.resume()
    }

}

extension Networking {

    // MARK: Response Handlers

    /// 'deserialize' contains the entire logic about how to handle a JSON/Array response.
    ///
    /// - Parameters:
    ///   - response: This is a 'URLResponse' object retrieved on 'URLSession'.
    ///   - data: This is a 'Data' object with a possible serialized json.
    ///   - error: Object with the error description.
    ///   - completion: Handler to dispatch the logic result with a '.Success(T)' or an '.Failure(NetworkingError)'.
    fileprivate class func deserialize(response: URLResponse?, with object: Any?, and error: Error?, to completion: @escaping NetworkingHandler) {

        if let array = object as? NKArray {
            completion(.Success(array))
        } else if let dictionary = object as? NKDictionary {
            completion(.Success(dictionary))
        } else {
            completion(.Failure(NetworkingError.construct(with: error)))
        }

    }

}
