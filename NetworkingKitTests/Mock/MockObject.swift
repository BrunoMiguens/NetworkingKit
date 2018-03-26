//
//  MockObject.swift
//  NetworkingKitTests
//
//  Created by bruno.miguens on 26/03/2018.
//  Copyright © 2018 Bruno Filipe Miguêns. All rights reserved.
//

import Foundation

struct MockObject {
    
    var isValid: Bool = false
    var identifier: String = ""
    
    init(dictionary: [AnyHashable: Any]) {
        
        if let value = dictionary["is_valid"] as? Bool {
            isValid = value
        }
        
        if let value = dictionary["id"] as? String {
            identifier = value
        }
    }
    
}
