//
//  NetworkingMethodTests.swift
//  NetworkingKitTests
//
//  Created by Bruno Miguêns on 16/03/2018.
//  Copyright © 2018 Bruno Filipe Miguêns. All rights reserved.
//

import XCTest
@testable import NetworkingKit

class NetworkingMethodTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCheckGetDefaultHeaders() {
        
        let defaultHeaders = NetworkingMethod.get.defaultHeaders
        
        XCTAssertEqual(defaultHeaders.count, 1)
        XCTAssertTrue(defaultHeaders.keys.contains(.contentType))
        XCTAssertTrue(defaultHeaders.values.contains(NetworkingHeader.HeaderValue.applicationJson.rawValue))
    }
    
    func testCheckDeleteDefaultHeaders() {
        
        let defaultHeaders = NetworkingMethod.delete.defaultHeaders
        
        XCTAssertEqual(defaultHeaders.count, 1)
        XCTAssertTrue(defaultHeaders.keys.contains(.contentType))
        XCTAssertTrue(defaultHeaders.values.contains(NetworkingHeader.HeaderValue.applicationJson.rawValue))
    }
    
    func testCheckPostDefaultHeaders() {
        
        let defaultHeaders = NetworkingMethod.post.defaultHeaders
        
        XCTAssertEqual(defaultHeaders.count, 1)
        XCTAssertTrue(defaultHeaders.keys.contains(.contentType))
        XCTAssertTrue(defaultHeaders.values.contains(NetworkingHeader.HeaderValue.formUrlEncoded.rawValue))
    }
    
    func testCheckPutDefaultHeaders() {
        
        let defaultHeaders = NetworkingMethod.put.defaultHeaders
        
        XCTAssertEqual(defaultHeaders.count, 1)
        XCTAssertTrue(defaultHeaders.keys.contains(.contentType))
        XCTAssertTrue(defaultHeaders.values.contains(NetworkingHeader.HeaderValue.formUrlEncoded.rawValue))
    }
    
}
