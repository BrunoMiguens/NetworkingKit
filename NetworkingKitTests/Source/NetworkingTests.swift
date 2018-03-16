//
//  NetworkingTests.swift
//  NetworkingKitTests
//
//  Created by Bruno Miguêns on 16/03/2018.
//  Copyright © 2018 Bruno Filipe Miguêns. All rights reserved.
//

import XCTest
@testable import NetworkingKit

class NetworkingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testShouldNotPerformInvalidUrl() {
        
        let mock = MockNetworkingTarget()
        mock.overrideBaseUrl = ""
        mock.overrideEndpoint = ""
        
        let async = expectation(description: "testShouldNotPerformInvalidUrl")
        
        Networking.perform(for: mock) { result in
            
            XCTAssertNil(result.value)
            XCTAssertFalse(result.isSuccess)
            XCTAssertEqual(result.error, .invalidUrl)
            
            async.fulfill()
        }
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testShouldPerformRequestReturnArray() {
        
        let mock = MockNetworkingTarget()
        mock.overrideSampleData = [1, 2, 3]
        
        let async = expectation(description: "testShouldPerformRequestReturnArray")
        
        Networking.perform(for: mock, runningTests: true) { result in
            
            XCTAssertNotNil(result.value)
            XCTAssertTrue(result.isSuccess)
            XCTAssertTrue(result.value is NKArray)
            XCTAssertEqual(result.error, .unknown)
            
            async.fulfill()
        }
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testShouldPerformRequestReturnDictionary() {
        
        let mock = MockNetworkingTarget()
        let async = expectation(description: "testShouldPerformRequestReturnDictionary")
        
        Networking.perform(for: mock, runningTests: true) { result in
            
            XCTAssertNotNil(result.value)
            XCTAssertTrue(result.isSuccess)
            XCTAssertEqual(result.error, .unknown)
            XCTAssertTrue(result.value is NKDictionary)
            
            async.fulfill()
        }
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testShouldPerformRequestReturnError() {
        
        let mock = MockNetworkingTarget()
        mock.overrideSampleData = UIView()
        
        let async = expectation(description: "testShouldPerformRequestReturnDictionary")
        
        Networking.perform(for: mock) { result in
            
            XCTAssertNil(result.value)
            XCTAssertFalse(result.isSuccess)
            XCTAssertEqual(result.error.code, NetworkingError.invalidRequest(response: nil).code)
            
            async.fulfill()
        }
        
        waitForExpectations(timeout: 1.5, handler: nil)
    }
    
}
