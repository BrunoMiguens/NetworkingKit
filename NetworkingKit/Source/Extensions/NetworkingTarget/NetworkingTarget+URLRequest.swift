//
//  NetworkingTarget+URLRequest.swift
//  NetworkingKit
//
//  Created by Bruno Miguêns on 15/03/2018.
//  Copyright © 2018 Bruno Filipe Miguêns. All rights reserved.
//

import Foundation

extension NetworkingTarget {
    
    private var urlString: String {
        return "\(baseUrl)\(endpoint)"
    }
    
    func urlRequest(for headers: NetworkingHeaderDictionary? = nil) -> NetworkingResult<URLRequest> {
        
        guard !urlString.isEmpty else {
            return NetworkingResult.Failure(.invalidUrl)
        }
        
        guard let result = construct() else {
            return NetworkingResult.Failure(.invalidToken)
        }
        
        guard let url = URL(string: result.path) else {
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
    
    fileprivate func construct() -> NKRouterTupple? {
        
        var bodyData: NKPostTuple = (nil, nil)
        var path: NKGetTuple = (nil, urlString)
        
        bodyData = constructPost(with: parameters, encode: encodeParameters)
        path = constructGet(for: path.url, with: parameters, encode: encodeParameters)
        
        let finalParameters = method == .post ? bodyData.parameters : path.parameters
        return (path.url, method, finalParameters, bodyData.data)
        
    }
    
    private func constructGet(for path: String, with parameters: NKStringDictionary, encode: Bool = false) -> NKGetTuple {
        
        guard path.hasSuffix("?") || path.hasSuffix("&") else {
            return (nil, "")
        }
        
        let query = encode ? parameters.formDataParameters(encode: true) : parameters.httpParameters
        
        let url = parameters.isEmpty ? path : "\(path)&\(query)"
        
        return (parameters, url)
    }
    
    private func constructPost(with parameters: NKStringDictionary, encode: Bool = true) -> NKPostTuple {
        
        let queryString = parameters.formDataParameters(encode: encode)
        
        var data = Data()
        if let queryData = queryString.data(using: .utf8) {
            data = queryData
        }
        
        return (parameters, NetworkingResult.Success(data))
    }
    
}
