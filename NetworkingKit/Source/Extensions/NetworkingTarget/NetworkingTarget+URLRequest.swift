//
//  NetworkingTarget+URLRequest.swift
//  NetworkingKit
//
//  Created by Bruno Miguêns on 15/03/2018.
//  Copyright © 2018 Bruno Filipe Miguêns. All rights reserved.
//

import Foundation

extension NetworkingTarget {
    
    public func urlRequest(for headers: NetworkingHeaderDictionary? = nil) -> NetworkingResult<URLRequest> {
        
        let result = construct()
        
        guard let url = URL(string: result.path), !urlString.isEmpty else {
            return NetworkingResult.Failure(.invalidUrl)
        }
        
        var finalHeaders: NetworkingHeaderDictionary = result.method.defaultHeaders
        if let hdrs = headers {
            finalHeaders = hdrs
        }
        
        var request = URLRequest(url: url, headers: finalHeaders)
        request.httpMethod = result.method.rawValue
        
        if let resultBody = result.postBody, let body = resultBody.value {
            request.httpBody = body
        }
        
        return NetworkingResult.Success(request)
        
    }
    
}

extension NetworkingTarget {
    
    fileprivate var urlString: String {
        return "\(baseUrl)\(endpoint)"
    }
    
    fileprivate func construct() -> NKRouterTupple {
        
        var bodyData: NKPostTuple = (nil, nil)
        var path: NKGetTuple = (nil, urlString)
        
        switch method {
            
        case .get, .delete:
            path = constructGet(for: path.url, with: parameters, encode: encodeParameters)
            return (path.url, method, path.parameters, nil)
            
        case .post, .put:
            bodyData = constructPost(with: parameters, encode: encodeParameters)
            return (path.url, method, bodyData.parameters, bodyData.data)
            
        }
        
    }
    
    fileprivate func constructGet(for path: String, with parameters: NKStringDictionary, encode: Bool = false) -> NKGetTuple {
        guard parameters.count > 0 else {
            return (parameters, path)
        }
        
        guard path.contains("?") else {
            let newPath = "\(path)?"
            return constructGet(for: newPath, with: parameters)
        }
        
        let query = encode ? parameters.formDataParameters(encode: true) : parameters.httpParameters
        
        let endpointSeparator = path.hasSuffix("?")
        let separator = endpointSeparator ? "" : "&"
        
        return (parameters, "\(path)\(separator)\(query)")
    }
    
    fileprivate func constructPost(with parameters: NKStringDictionary, encode: Bool = true) -> NKPostTuple {
        
        let queryString = parameters.formDataParameters(encode: encode)
        
        var data = Data()
        if let queryData = queryString.data(using: .utf8) {
            data = queryData
        }
        
        return (parameters, NetworkingResult.Success(data))
    }
    
}
