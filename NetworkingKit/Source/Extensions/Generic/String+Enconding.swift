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
        if let encoded = addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)?.replacingOccurrences(of: "+", with: "%2B") {
            output = encoded
        }
        return output
    }
    
    var decode: String {
        return self.removingPercentEncoding ?? self
    }
    
}
