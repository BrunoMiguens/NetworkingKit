//
//  NetworkingTargetURLRequestTests.swift
//  NetworkingKitTests
//
//  Created by Bruno Miguêns on 16/03/2018.
//  Copyright © 2018 Bruno Filipe Miguêns. All rights reserved.
//

import XCTest
@testable import NetworkingKit

class NetworkingTargetURLRequestTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testShouldReturnUrlErrorWithEmptyUrl() {
        
        let mock = MockNetworkingTarget()
        mock.overrideBaseUrl = ""
        mock.overrideEndpoint = ""
        
        let request = mock.urlRequest()
        
        XCTAssertNil(request.value)
        XCTAssertFalse(request.isSuccess)
        XCTAssertEqual(request.error, .invalidUrl)
    }
    
    func testShouldReturnUrlWithoutChanges() {
        
        let mock = MockNetworkingTarget()
        mock.overrideParameters = [:]
        
        let request = mock.urlRequest()
        
        XCTAssertNotNil(request.value)
        XCTAssertTrue(request.isSuccess)
        XCTAssertEqual(request.error, .unknown)
        
        XCTAssertEqual(request.value?.url?.absoluteString, "https://apple.com/pt/test/?")
    }
    
    func testShouldReturnUrlAlreadyWithParams() {
        
        let mock = MockNetworkingTarget()
        mock.overrideEndpoint = "/test?testKey=1"
        
        let request = mock.urlRequest()
        
        XCTAssertNotNil(request.value)
        XCTAssertTrue(request.isSuccess)
        XCTAssertEqual(request.error, .unknown)
        
        XCTAssertEqual(request.value?.url?.absoluteString, "https://apple.com/pt/test?testKey=1&key=123")
    }
    
    func testShouldReturnUrlWithEndpointCharacterAuto() {
        
        let mock = MockNetworkingTarget()
        mock.overrideEndpoint = "/test/"
        
        let request = mock.urlRequest()
        
        XCTAssertNotNil(request.value)
        XCTAssertTrue(request.isSuccess)
        XCTAssertEqual(request.error, .unknown)
        
        XCTAssertEqual(request.value?.url?.absoluteString, "https://apple.com/pt/test/?key=123")
    }
    
    func testShouldReturnUrlWithDefaultHeaders() {
        
        let mock = MockNetworkingTarget()
        let request = mock.urlRequest()
        
        XCTAssertNotNil(request.value)
        XCTAssertTrue(request.isSuccess)
        XCTAssertEqual(request.error, .unknown)
        
        XCTAssertEqual(request.value?.url?.absoluteString, "https://apple.com/pt/test/?key=123")
        
        XCTAssertEqual(request.value?.allHTTPHeaderFields?.count, 1)
        XCTAssertTrue(request.value?.allHTTPHeaderFields?.keys.contains(NetworkingHeader.contentType.rawValue) ?? false)
        XCTAssertTrue(request.value?.allHTTPHeaderFields?.values.contains(NetworkingHeader.HeaderValue.applicationJson.rawValue) ?? false)
    }
    
    func testShouldReturnUrlWithCustomHeaders() {
        
        let mock = MockNetworkingTarget()
        let request = mock.urlRequest(for: [.contentType: NetworkingHeader.HeaderValue.textHtml.rawValue])
        
        XCTAssertNotNil(request.value)
        XCTAssertTrue(request.isSuccess)
        XCTAssertEqual(request.error, .unknown)
        
        XCTAssertEqual(request.value?.url?.absoluteString, "https://apple.com/pt/test/?key=123")
        
        XCTAssertEqual(request.value?.allHTTPHeaderFields?.count, 1)
        XCTAssertTrue(request.value?.allHTTPHeaderFields?.keys.contains(NetworkingHeader.contentType.rawValue) ?? false)
        XCTAssertTrue(request.value?.allHTTPHeaderFields?.values.contains(NetworkingHeader.HeaderValue.textHtml.rawValue) ?? false)
    }
    
    func testShouldReturnUrlForGET() {
        
        let mock = MockNetworkingTarget()
        mock.overrideMethod = .get
        
        let request = mock.urlRequest()
        
        XCTAssertNotNil(request.value)
        XCTAssertTrue(request.isSuccess)
        XCTAssertEqual(request.error, .unknown)
        
        XCTAssertEqual(request.value?.url?.absoluteString, "https://apple.com/pt/test/?key=123")
        
        XCTAssertNil(request.value?.httpBody)
    }
    
    func testShouldReturnUrlForDELETE() {
        
        let mock = MockNetworkingTarget()
        mock.overrideMethod = .delete
        
        let request = mock.urlRequest()
        
        XCTAssertNotNil(request.value)
        XCTAssertTrue(request.isSuccess)
        XCTAssertEqual(request.error, .unknown)
        
        XCTAssertEqual(request.value?.url?.absoluteString, "https://apple.com/pt/test/?key=123")
        
        XCTAssertNil(request.value?.httpBody)
    }
    
    func testShouldReturnUrlForPOST() {
        
        let mock = MockNetworkingTarget()
        mock.overrideMethod = .put
        
        let request = mock.urlRequest()
        
        XCTAssertNotNil(request.value)
        XCTAssertTrue(request.isSuccess)
        XCTAssertEqual(request.error, .unknown)
        
        XCTAssertEqual(request.value?.url?.absoluteString, "https://apple.com/pt/test/?")
        
        XCTAssertNotNil(request.value?.httpBody)
    }
    
    func testShouldReturnUrlForPUT() {
        
        let mock = MockNetworkingTarget()
        mock.overrideMethod = .post
        
        let request = mock.urlRequest()
        
        XCTAssertNotNil(request.value)
        XCTAssertTrue(request.isSuccess)
        XCTAssertEqual(request.error, .unknown)
        
        XCTAssertEqual(request.value?.url?.absoluteString, "https://apple.com/pt/test/?")
        
        XCTAssertNotNil(request.value?.httpBody)
    }
    
}
