//
//  NetworkingError+Helpers.swift
//  NetworkingKit
//
//  Created by Bruno Miguêns on 02/10/2017.
//  Copyright © 2018 Bruno Filipe Miguêns. All rights reserved.
//

import Foundation

extension NetworkingError: Equatable {

    // MARK: Helpers (Equatable)

    /// Using this method you'll be able to compare two `NetworkingError`, will check for the code and message, just using the operator `==`.
    ///
    /// - Parameters:
    ///   - lhs: This parameter should be the one you want to compare.
    ///   - rhs: This parameter should be the one you want to make sure that is equal to the first one.
    /// - Returns: Returns a `Boolean` value indicating whether or not the two options are equal.
    public static func == (lhs: NetworkingError, rhs: NetworkingError) -> Bool {
        return lhs.code == rhs.code && lhs.message == rhs.message
    }

}

extension NetworkingError {

    // MARK: Properties

    /// This property should be an auxiliary way to get the error code to a specific `NetworkingError`.
    var code: Int {

        switch self {

        case .unknown: return -1
        case .unexpected: return -2
        case .invalidUrl: return -3
        case .invalidData: return -4
        case .invalidToken: return -5
        case .responseInvalid: return -6
        case .apiMessage: return -7
        case .apiForm: return -8
        case .operationCanceled: return -9
        case .invalidRequest: return -10
        case .custom (let code, _): return code

        }

    }

    /// This property should be an auxiliary way to get the error message to a specific `NetworkingError`, if applicable.
    var message: String? {

        switch self {

        case .custom (_, let message): return message
        case .apiMessage (let message): return message
        case .responseInvalid (let message): return message

        default: return nil

        }

    }

}
