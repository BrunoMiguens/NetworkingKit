//
//  Typealias.swift
//  NetworkingKit
//
//  Created by Bruno Miguêns on 15/03/2018.
//  Copyright © 2018 Bruno Filipe Miguêns. All rights reserved.
//

import Foundation

public typealias NKURLRequestHanlder = (Any?, URLResponse?, Error?) -> Void

public typealias NKGetTuple = (parameters: NKDictionary?, url: String)
public typealias NKPostTuple = (parameters: NKDictionary?, data: NetworkingResult<Data>?)
public typealias NKRouterTupple = (path: String, method: NetworkingMethod, parameters: NKDictionary?, postBody: NetworkingResult<Data>?)

public typealias NKArray = [Any]
public typealias NKDictionary = [AnyHashable: Any]
public typealias NKStringDictionary = [String: Any]
