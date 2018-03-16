//
//  NetworkingTarget.swift
//  NetworkingKit
//
//  Created by Bruno Miguêns on 25/01/2018.
//  Copyright © 2018 Bruno Filipe Miguêns. All rights reserved.
//

import Foundation

/**
 This protocol shall be used to make the `NetworkingRouter` conforms with the properties bellow in order to join all the networking logic such as parameters, methods and so on.
 */
protocol NetworkingTarget {
    
    var baseUrl: String { get }
    
    var endpoint: String { get }
    
    /// Return a `NetworkingMethod` value indicating the method (get, post and so on) type for each parameter.
    var method: NetworkingMethod { get }
    
    /// Return a `NKDictionary` value indicating the final constructed parameters to used on the http request.
    var parameters: NKStringDictionary { get }
    
    /// Return a `Boolean` value indicating whether or not the `parameters` should be encoded.
    var encodeParameters: Bool { get }

    /// Return a `NKDictionary` value indicating the sample dictionary to be used on unit tests, if nil then should make the http request.
    var sampleData: Any? { get }

}
