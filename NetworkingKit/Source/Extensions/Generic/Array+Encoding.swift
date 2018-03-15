//
//  Array+Encoding.swift
//  NetworkingKit
//
//  Created by Bruno Miguêns on 15/09/2017.
//  Copyright © 2018 Bruno Filipe Miguêns. All rights reserved.
//

import UIKit

extension Array {

    // MARK: Encoding

    /// This helper method shall convert an array into HTTP parameters (by default will encode characters such as '-' and so on).
    ///
    /// - Parameters:
    ///   - key: The key to associate the array values, due to PHP limitations, this method will append an `[]` to the key.
    ///   - encode: Using this `Boolean` value you'll be able to encode or not the values inside the array.
    /// - Returns: Returns the string corresponding to the array converted into HTTP parameters.
    public func encodedParameters(with key: String, encode: Bool = true) -> String {

        let values = map { value -> String in
            var valueString = value as? String ?? ""

            valueString = valueString.isEmpty ? String(describing: value) : valueString

            if encode {
                valueString = valueString.encode
            }

            return "\(key)[]=\(valueString)"
        }

        let valuesString = values.joined(separator: "&")
        return valuesString
    }

}
