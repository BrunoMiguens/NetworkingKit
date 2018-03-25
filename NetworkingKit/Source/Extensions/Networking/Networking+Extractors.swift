//
//  Networking+Extractors.swift
//  NetworkingKit
//
//  Created by Bruno Miguêns on 15/03/2018.
//  Copyright © 2018 Bruno Filipe Miguêns. All rights reserved.
//

import Foundation

extension Networking {

    // MARK: Extractors

    /// Use this method to extract and parse the paginated data, the array itself.
    ///
    /// - Parameters:
    ///   - response: A `NKResult` object containing an `Any` object.
    ///   - parser: This parser will be executed while parsing the result type, using a `T` object.
    ///   - completion: This handler will be executed after the request and extract process giving a `NKResult<Array<T>>` object.
    public class func extractResults<T>(with response: NKResult<Any>, parser: NKParserHandler<T>, to completion: NKResultHandler<T>) {

        let key = parser([:]).key

        guard let resultsData = response.value as? NKDictionary, resultsData.count > 0 else {
            completion(NKResult.Failure(.invalidData))
            return
        }

        guard let resultsArray = resultsData[key] as? [NKDictionary] else {
            parseResult(resultsData, with: parser, and: completion)
            return
        }

        parseResults(resultsArray, with: parser, and: completion)
    }

    // MARK: Extractors: Parsers

    /// This method shall use a `NKParserHandler` to get the key to parse information and give the dictionary to the parser to create an object.
    ///
    /// Should work only with one object, for instance, a dictionary with only one object to be parsed.
    ///
    /// - Parameters:
    ///   - resultsData: This parameter should have the dictionary raw data to be parsed.
    ///   - parser: This parser will be executed while parsing the result type, using a `T` object.
    ///   - completion: This handler will be executed after the request and extract process giving a `NKResult<Array<T>>` object.
    public class func parseResult<T>(_ resultsData: NKDictionary, with parser: NKParserHandler<T>, and completion: NKResultHandler<T>) {

        let key = parser([:]).key
        var dict = resultsData
        if let dictionary = resultsData[key] as? NKDictionary, !key.isEmpty {
            dict = dictionary
        }

        guard let obj = parser(dict).object else {
            completion(NKResult.Failure(.invalidData))
            return
        }

        completion(NKResult.Success([obj]))
    }

    /// This method shall use a `NKParserHandler` to get the key to parse information and give the dictionary to the parser to create an array of objects.
    ///
    /// Should work with an array of objects, for instance, a dictionary with some objects to be parsed.
    ///
    /// - Parameters:
    ///   - resultsArray: This parameter should have the array raw data to be parsed.
    ///   - parser: This parser will be executed while parsing the result type, using a `T` object.
    ///   - completion: This handler will be executed after the request and extract process giving a `NKResult<Array<T>>` object.
    public class func parseResults<T>(_ resultsArray: [NKDictionary], with parser: NKParserHandler<T>, and completion: NKResultHandler<T>) {

        var results: Array<T> = []
        resultsArray.forEach { dict in
            if let result = parser(dict).object {
                results.append(result)
            }
        }

        completion(NKResult.Success(results))
    }

}
