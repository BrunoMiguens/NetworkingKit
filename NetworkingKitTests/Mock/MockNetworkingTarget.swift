//
//  MockNetworkingTarget.swift
//  NetworkingKitTests
//
//  Created by Bruno Miguêns on 16/03/2018.
//  Copyright © 2018 Bruno Filipe Miguêns. All rights reserved.
//

import Foundation
@testable import NetworkingKit

class MockNetworkingTarget: NetworkingTarget {
    
    var overrideSampleData: Any?
    var overrideBaseUrl: String?
    var overrideEndpoint: String?
    var overrideMethod: NetworkingMethod?
    var overrideParameters: NKStringDictionary?
    
    var baseUrl: String {
        return overrideBaseUrl ?? "https://apple.com/pt"
    }
    
    var endpoint: String {
        return overrideEndpoint ?? "/test/?"
    }
    
    var method: NetworkingMethod {
        return overrideMethod ?? .get
    }
    
    var parameters: NKStringDictionary {
        return overrideParameters ?? ["key": 123]
    }
    
    var encodeParameters: Bool {
        return true
    }
    
    var sampleData: Any? {
        return overrideSampleData ?? ["sampleData": 123]
    }
    
}
