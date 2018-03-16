//
//  String+Enconding.swift
//  NetworkingKit
//
//  Created by Bruno Miguêns on 15/03/2018.
//  Copyright © 2018 Bruno Filipe Miguêns. All rights reserved.
//

import Foundation

extension String {
    
    var encode: String {
        var output: String = self
        if let encoded = addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed) {
            output = encoded.replacingOccurrences(of: "+", with: "%2B")
        }
        return output
    }
    
    var decode: String {
        var output: String = self
        if let decoded = removingPercentEncoding {
            output = decoded
        }
        return output
    }
    
}
