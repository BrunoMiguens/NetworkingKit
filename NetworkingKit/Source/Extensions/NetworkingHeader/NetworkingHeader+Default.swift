//
//  NetworkingHeader+Default.swift
//  NetworkingKit
//
//  Created by Bruno Miguêns on 30/08/2017.
//  Copyright © 2018 Bruno Filipe Miguêns. All rights reserved.
//

import Foundation

extension NetworkingHeader {

    // MARK: Default Headers

    /// This stored property will gather all the default and needed headers for a GET request.
    public static var get: NetworkingHeaderDictionary {
        return [.contentType: HeaderValue.applicationJson.rawValue]
    }

    /// This stored property will gather all the default and needed headers for a POST request.
    public static var post: NetworkingHeaderDictionary {
        return [.contentType: HeaderValue.formUrlEncoded.rawValue]
    }

}
