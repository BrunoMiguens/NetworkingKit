//
//  NetworkingError+CustomErrors.swift
//  NetworkingKit
//
//  Created by Bruno Miguêns on 03/04/2017.
//  Copyright © 2018 Bruno Filipe Miguêns. All rights reserved.
//

import Foundation

extension NetworkingError {

    // MARK: Custom Errors

    /// Use this error when the user doesn't exist and you need to check that.
    static var unknownUser: NetworkingError {
        return NetworkingError.custom(code: -10, description: "No user found to complete the request successfully.")
    }

}
