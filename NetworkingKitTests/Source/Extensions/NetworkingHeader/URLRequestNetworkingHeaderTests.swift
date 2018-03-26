//
//  URLRequestNetworkingHeaderTests.swift
//  NetworkingKitTests
//
//  Created by Bruno Miguêns on 16/03/2018.
//  Copyright © 2018 Bruno Filipe Miguêns. All rights reserved.
//

import XCTest
@testable import NetworkingKit

class URLRequestNetworkingHeaderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testShouldInitURLRequestWithHeaders() {
        
        let request = URLRequest(url: URL(string: "http://apple.com/pt")!, headers: NetworkingMethod.get.defaultHeaders)
        
        XCTAssertEqual(request.allHTTPHeaderFields?.count, 1)
        XCTAssertTrue(request.allHTTPHeaderFields?.keys.contains(NetworkingHeader.contentType.rawValue) ?? false)
        XCTAssertTrue(request.allHTTPHeaderFields?.values.contains(NetworkingHeader.Value.applicationJson.rawValue) ?? false)
    }
    
    func testShouldSetHeaders() {
        
        var request = URLRequest(url: URL(string: "http://apple.com/pt")!)
        
        XCTAssertNil(request.allHTTPHeaderFields)
        
        request.set(headers: NetworkingMethod.post.defaultHeaders)
        
        XCTAssertEqual(request.allHTTPHeaderFields?.count, 1)
        XCTAssertTrue(request.allHTTPHeaderFields?.keys.contains(NetworkingHeader.contentType.rawValue) ?? false)
        XCTAssertTrue(request.allHTTPHeaderFields?.values.contains(NetworkingHeader.Value.formUrlEncoded.rawValue) ?? false)
    }
    
}
