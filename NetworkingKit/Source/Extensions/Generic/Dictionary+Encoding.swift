//
//  Dictionary+Encoding.swift
//  NetworkingKit
//
//  Created by Bruno Miguêns on 15/09/2017.
//  Copyright © 2018 Bruno Filipe Miguêns. All rights reserved.
//

import UIKit

extension Dictionary where Key: ExpressibleByStringLiteral, Value: Any {

    // MARK: Encoding

    /// This helper property shall convert a simple dictionary into HTTP parameters (by default will encode characters such as '-' and so on).
    public var httpParameters: String {
        let mapped = self.map { key, value -> String in

            let keyString = String(describing: key)
            let valueString = String(describing: value)

            return "\(keyString.encode)=\(valueString.encode)"
        }

        return mapped.joined(separator: "&")
    }

    /// This helper method shall convert an dictionary into HTTP parameters (by default will encode characters such as '-' and so on).
    ///
    /// - Parameters: encode: Using this `Boolean` value you'll be able to encode or not the values inside the array.
    /// - Returns: Returns the string corresponding to the dictionary converted into HTTP parameters.
    public func formDataParameters(encode: Bool = true) -> String {
        let mapped = self.map { key, value -> String in

            var percentEscapedKey = String(describing: key)
            var percentEscapedValue = String(describing: value)

            if encode {
                percentEscapedKey = percentEscapedKey.encode
                percentEscapedValue = percentEscapedValue.encode
            }

            if let dict = value as? NKStringDictionary {
                return dict.encodedParameters(baseKey: percentEscapedKey)
            }

            if let array = value as? NKArray {
                return "\(array.encodedParameters(with: percentEscapedKey))"
            }

            return "\(percentEscapedKey)=\(percentEscapedValue)"
        }

        return mapped.joined(separator: "&")
    }

    /// This helper method shall convert an dictionary into HTTP parameters (by default will encode characters such as '-' and so on).
    ///
    /// **Note:** This method should be used as a complement of `formDataParameters(encode:)`, so use that instead.
    ///
    /// - Parameters:
    ///   - baseKey: The key to associate the values, for instance, the key to a value containing a dictionary in order to convert them to this format `example[id]=1`.
    ///   - encode: Using this `Boolean` value you'll be able to encode or not the values inside the array.
    /// - Returns: Returns the string corresponding to the dictionary converted into HTTP parameters.
    public func encodedParameters(baseKey: String? = nil, encode: Bool = true) -> String {

        var values = [String]()

        forEach { key, value in

            var valueString = value as? String ?? ""
            if valueString.isEmpty {
                valueString = String(describing: value)
            }

            var newKey = "\(key)"
            if let escapedKey = baseKey {
                newKey = "\(escapedKey)[\(key)]"
            }

            if let valueDict = value as? NKStringDictionary {
                valueString = valueDict.encodedParameters(baseKey: "\(key)", encode: encode)
                values.append(valueString)
            } else if let valueArray = value as? NKArray {
                valueString = valueArray.encodedParameters(with: newKey, encode: encode)
                values.append(valueString)
            } else {
                valueString = encode ? valueString.encode : valueString
                values.append("\(newKey)=\(valueString)")
            }
        }

        return values.joined(separator: "&")
    }

}
