//
//  NetworkingHeader.swift
//  NetworkingKit
//
//  Created by Bruno Miguêns on 22/03/2017.
//  Copyright © 2018 Bruno Filipe Miguêns. All rights reserved.
//

import Foundation

/// This tuple type alias will allocate a dictionary with a `NetworkingHeader` as key and a string value.
public typealias NetworkingHeaderDictionary = [NetworkingHeader: String]

/// This enumerator should be used every time you need to indicate or create some specific headers to your requests.
public enum NetworkingHeader: String {

    /// This case should give the key to represent the 'Content-Type' header.
    case contentType = "Content-Type"

    /// This enumerator should be used every time you need to the value for a specific header.
    enum HeaderValue: String {

        /// This case should give this value 'text/html' to a header, such as the `.accept` and so on.
        case textHtml = "text/html"

        /// This case should give this value 'application/json' to a header, such as the `.contentType` and so on.
        case applicationJson = "application/json"

        /// This case should give this value 'application/x-json' to a header, such as the `.contentType` and so on.
        case applicationJsonX = "application/x-json"

        /// This case should give this value 'application/x-www-form-urlencoded' to a header, such as the `.contentType` and so on.
        case formUrlEncoded = "application/x-www-form-urlencoded"

    }

}
