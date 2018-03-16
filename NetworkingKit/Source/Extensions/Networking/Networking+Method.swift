//
//  Networking+Method.swift
//  NetworkingKit
//
//  Created by Bruno Miguêns on 15/03/2018.
//  Copyright © 2018 Bruno Filipe Miguêns. All rights reserved.
//

import Foundation

/// This enum represents the HTTP request method.
public enum NetworkingMethod: String {
    
    /// Will perform a GET call.
    case get = "GET"
    
    /// Will perform a POST call.
    case post = "POST"
    
    /// Will perform a PUT call.
    case put = "PUT"
    
    /// Will perform a DELETE call.
    case delete = "DELETE"
    
    public var defaultHeaders: NetworkingHeaderDictionary {
        
        switch self {
            
        case .post, .put: return NetworkingHeader.post
        case .get, .delete: return NetworkingHeader.get
            
        }
    }
}
