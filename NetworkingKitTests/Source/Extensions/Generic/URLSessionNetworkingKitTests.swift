//
//  URLSessionNetworkingKitTests.swift
//  NetworkingKitTests
//
//  Created by Bruno Miguêns on 16/03/2018.
//  Copyright © 2018 Bruno Filipe Miguêns. All rights reserved.
//

import XCTest
@testable import NetworkingKit

class URLSessionNetworkingKitTests: XCTestCase {
    
    let mock = MockNetworkingTarget()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testShouldNotPerformWebRequestWithSampleDataAndRunningTests() {
        
        let task = URLSession.shared.task(router: mock, request: URLRequest(url: URL(string: mock.baseUrl)!), runningTests: true, completionHandler: nil)
        
        XCTAssertNil(task)
    }
    
    func testShouldPerformWebRequestWithOnlySampleData() {
        
        let task = URLSession.shared.task(router: mock, request: URLRequest(url: URL(string: mock.baseUrl)!), completionHandler: nil)
        
        XCTAssertNotNil(task)
    }
    
    func testShouldPerformWebRequest() {
        
        var request = URLRequest(url: URL(string: "https://dog.ceo/api/breeds/list/all")!)
        request.httpMethod = NetworkingMethod.get.rawValue
        request.set(headers: NetworkingHeader.get)
        
        let async = expectation(description: "testShouldPerformWebRequest")
        
        let task = URLSession.shared.task(router: mock, request: request) { object, rqt, error in
            XCTAssertNil(error)
            XCTAssertNotNil(object)
            XCTAssertTrue(object is NKDictionary)
            
            async.fulfill()
        }
        
        task?.resume()
        
        XCTAssertNotNil(task)
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
}
