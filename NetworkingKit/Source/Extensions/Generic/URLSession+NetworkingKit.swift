//
//  URLSession+NetworkingKit.swift
//  NetworkingKit
//
//  Created by Bruno Miguêns on 15/03/2018.
//  Copyright © 2018 Bruno Filipe Miguêns. All rights reserved.
//

import Foundation

extension URLSession {
    
    // MARK: Networking Helper
    
    /// This method should be used to replace the `dataTask` and shall return, if exists, any `sampleData` on the router and if is running tests, otherwise shall execute the http request.
    ///
    /// - Parameters:
    ///   - router: This is a `NetworkingTarget` object indicating which router should be used to gather the `sampleData` object.
    ///   - request: The `URLRequest` object to make the http request, if doesn't exist any `sampleData`.
    ///   - completionHandler: The handler to notify when the request is finished.
    /// - Returns: Returns a `URLSessionDataTask`.
    func task(router: NetworkingTarget, request: URLRequest, runningTests: Bool = false, completionHandler: NKURLRequestHanlder?) -> URLSessionDataTask? {
        
        if let sample = router.sampleData, runningTests {
            completionHandler?(sample, nil, nil)
            return nil
        }
        
        return dataTask(with: request) { data, response, error in
            var object: Any? = nil
            if let dt = data, let obj = try? JSONSerialization.jsonObject(with: dt, options: []) {
                object = obj
            }
            completionHandler?(object, response, error)
        }
    }
    
}
