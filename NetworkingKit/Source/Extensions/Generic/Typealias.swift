//
//  Typealias.swift
//  NetworkingKit
//
//  Created by Bruno Miguêns on 15/03/2018.
//  Copyright © 2018 Bruno Filipe Miguêns. All rights reserved.
//

import Foundation

public typealias NKURLRequestHanlder = (Any?, URLResponse?, Error?) -> Void

typealias NKGetTuple = (parameters: NKDictionary?, url: String)
typealias NKPostTuple = (parameters: NKDictionary?, data: NKResult<Data>?)
typealias NKRouterTupple = (path: String, method: NetworkingMethod, parameters: NKDictionary?, postBody: NKResult<Data>?)

public typealias NKArray = [Any]
public typealias NKDictionary = [AnyHashable: Any]
public typealias NKStringDictionary = [String: Any]

public typealias NKResultHandler<T> = (NKResult<Array<T>>) -> Void
public typealias NKParserHandler<T> = (NKDictionary) -> (object: T?, key: String)
