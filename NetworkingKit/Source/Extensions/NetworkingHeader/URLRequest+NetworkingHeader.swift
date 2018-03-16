//
//  URLRequest+NetworkingHeader.swift
//  NetworkingKit
//
//  Created by Bruno Miguêns on 30/08/2017.
//  Copyright © 2018 Bruno Filipe Miguêns. All rights reserved.
//

import Foundation

extension URLRequest {

    // MARK: NetworkingHeader (Helpers)

    /// This initializer will allow you to create a `URLRequest` object with the headers given by you.
    ///
    /// - Parameters:
    ///   - url: The URL for the request.
    ///   - headers: The headers to be set into the `URLRequest`.
    public init(url: URL, headers: NetworkingHeaderDictionary) {
        self.init(url: url)

        set(headers: headers)
    }

    /// This auxiliary method will provide you an easier way to set all the header created using the `NetworkingHeader`.
    ///
    /// - Parameter headers: This is an object of type ` [NetworkingHeader: String]` containing all the headers that you want to set.
    public mutating func set(headers: NetworkingHeaderDictionary = NetworkingHeader.get) {
        headers.forEach { key, value in
            setValue(value, forHTTPHeaderField: key.rawValue)
        }
    }

}
