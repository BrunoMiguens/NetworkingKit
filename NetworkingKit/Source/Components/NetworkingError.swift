//
//  NKError.swift
//  NetworkingKit
//
//  Created by Bruno Miguêns on 13/03/2017.
//  Copyright © 2018 Bruno Filipe Miguêns. All rights reserved.
//

import Foundation

/// This enum represents a variety of possible errors, related with the construction of the request or about the response.
public enum NKError: Error {

    /// Represents an unknown error, will return an array of nullable objects. could happen if some cast won't work correctly.
    case unknown

    /// Represents a problem with the error initialization, when the error is initialized if something goes wrong (ex: nullable or unexpected object type) this error will be returned.
    case unexpected(objects: [Any?])

    /// Represents an invalid url error, for some reason, on construction process if the url isn't valid this error will be returned.
    case invalidUrl

    /// Represents an invalid data error, this error would be thrown in case of invalid/unexpected json or missing data to deserialize.
    case invalidData

    /// Represents an invalid token error, if the token doesn't exist this error will be returned.
    case invalidToken

    /// Represents a problem with the response deserialization, if something go wrong this error will be returned, with a description about the error.
    case responseInvalid(description: String)

    /// Represents a problem returned from api with an message, any message that the api returns will be returned as a parameter.
    case apiMessage(message: String)

    /// Represents a problem returned from api meaning that some parameters are wrong, a form will be returned as a parameter.
    case apiForm(form: NKDictionary)

    /// Represents an error that are known but not expected, will return a code and a description.
    case custom(code: Int, description: String)

    /// Use this error when the user cancels some action and you need to check that.
    case operationCanceled

    case invalidRequest(response: URLResponse?)

}

extension NKError {

    // MARK: Converters/Constructors

    /// This method should convert a simple object of type `Error` into a `NKError`.
    ///
    /// - Parameter error: This is the object containing the error information.
    /// - Returns: Returns a `NKError` object, in case of nonexistent error should return a `.unknown` value.
    public static func construct(with error: Error?) -> NKError {
        guard let oldError = error as NSError? else {
            return .invalidData
        }

        return .custom(code: oldError.code, description: oldError.localizedDescription)
    }

    /// This method should convert a simple object of type `Error` or a `URLResponse` object into a `NKError`.
    ///
    /// - Parameters:
    ///   - error: This is the object containing the error information.
    ///   - response: This is the URL response object containing the response information with a possible error.
    /// - Returns: Returns a `NKError` object, in case of nonexistent error should return a `.unknown` value.
    public static func construct(with error: Error?, and response: URLResponse?) -> NKError {
        guard let fail = error else {
            return response == nil ? .unknown : .invalidRequest(response: response)
        }

        guard let operation = response as? HTTPURLResponse else {
            return .unexpected(objects: [fail])
        }

        return .custom(code: operation.statusCode, description: fail.localizedDescription)
    }

}
