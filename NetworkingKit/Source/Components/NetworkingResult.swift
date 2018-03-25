//
//  NKResult.swift
//  NetworkingKit
//
//  Created by Bruno Miguêns on 13/03/2017.
//  Copyright © 2018 Bruno Filipe Miguêns. All rights reserved.
//

import Foundation

public typealias NKHandler = (_ result: NKResult<Any>) -> Void
public typealias NKArrayHandler = (_ result: NKResult<NKArray>) -> Void
public typealias NKJsonHandler = (_ result: NKResult<NKDictionary>) -> Void

// swiftlint:disable shorthand_operator

/// This enum represents the kind of types that a result handler could return.
public enum NKResult<T> {

    /// This indicates that everything worked as expected and will return a Generic (T), will return what you prefer.
    case Success(T)

    /// If something goes wrong this '.Failure' will be used, will return 'NKError' enum to know what happens.
    case Failure(NKError)

    /// This property should return the value inside of the success case, if applicable.
    var value: T? {
        switch self {

        case .Success(let obj): return obj
        default: return nil

        }
    }

    /// This property should return the value of type `NKError` inside of the error case, in case of nonexistent value should return a `.unknown` value.
    var error: NKError {
        switch self {

        case .Failure(let error): return error
        default: return .unknown

        }
    }

    /// This property should return a boolean value representing if is a success case or not.
    var isSuccess: Bool {
        switch self {

        case .Success: return true
        default: return false

        }
    }

}

// swiftlint:enable shorthand_operator
