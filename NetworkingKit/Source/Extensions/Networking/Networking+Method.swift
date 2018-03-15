//
//  Networking+Method.swift
//  NetworkingKit
//
//  Created by Bruno Miguêns on 15/03/2018.
//  Copyright © 2018 Bruno Filipe Miguêns. All rights reserved.
//

import Foundation

extension Networking {
    
    /// This enum represents the HTTP request method.
    enum Method: String {
        
        /// Will perform a GET call.
        case get = "GET"
        
        /// Will perform a POST call.
        case post = "POST"
        
        var defaultHeaders: NetworkingHeaderDictionary {
            
            switch self {
                
            case .get: return NetworkingHeader.get
            case .post: return NetworkingHeader.post
                
            }
        }
    }
    
}
