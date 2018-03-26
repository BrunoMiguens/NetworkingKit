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
public enum NetworkingHeader: Hashable {
    
    public static func ==(lhs: NetworkingHeader, rhs: NetworkingHeader) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
    
    /// This case should give you the possibility of add any header key you want.
    case custom(key: String)
    
    /// This case should give the key to represent the 'Accept' header.
    case accept
    
    /// This case should give the key to represent the 'Content-MD5' header.
    case contentMD5
    
    /// This case should give the key to represent the 'Content-Type' header.
    case contentType
    
    /// This case should give the key to represent the 'Cache-Control' header.
    case cacheControl
    
    /// This case should give the key to represent the 'Content-Length' header.
    case contentLength
    
    /// This case should give the key to represent the 'Authorization' header.
    case authorization
    
    /// This case should give the key to represent the 'Accept-Charset' header.
    case acceptCharset
    
    /// This case should give the key to represent the 'Accept-Encoding' header.
    case acceptEncoding
    
    /// This case should give the key to represent the 'Accept-Language' header.
    case acceptLanguage

    /// This enumerator should be used every time you need to the value for a specific header.
    public enum Value: String {
        
        /// This case should give this value 'text/html' to a header, such as the `.accept` and so on.
        case textCsv = "text/csv"
        
        /// This case should give this value 'text/html' to a header, such as the `.accept` and so on.
        case textXml = "text/xml"

        /// This case should give this value 'text/html' to a header, such as the `.accept` and so on.
        case textHtml = "text/html"
        
        /// This case should give this value 'text/html' to a header, such as the `.accept` and so on.
        case textPlain = "text/plain"

        /// This case should give this value 'application/json' to a header, such as the `.contentType` and so on.
        case applicationJson = "application/json"

        /// This case should give this value 'application/x-json' to a header, such as the `.contentType` and so on.
        case applicationJsonX = "application/x-json"

        /// This case should give this value 'application/x-www-form-urlencoded' to a header, such as the `.contentType` and so on.
        case formUrlEncoded = "application/x-www-form-urlencoded"

    }

}

extension NetworkingHeader {
    
    // MARK: Getters
    
    public var hashValue: Int {
        return rawValue.hashValue
    }
    
    public var rawValue: String {
        
        switch self {
            
        case .custom(let key): return key
            
        case .accept: return "Accept"
        case .contentMD5: return "Content-MD5"
        case .contentType: return "Content-Type"
        case .cacheControl: return "Cache-Control"
        case .authorization: return "Authorization"
        case .contentLength: return "Content-Length"
        case .acceptCharset: return "Accept-Charset"
        case .acceptEncoding: return "Accept-Encoding"
        case .acceptLanguage: return "Accept-Language"
            
        }
    }
    
}
