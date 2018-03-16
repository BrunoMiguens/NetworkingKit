//
//  ArrayEncodingTests.swift
//  NetworkingKitTests
//
//  Created by Bruno Miguêns on 23/10/2017.
//  Copyright © 2018 Bruno Filipe Miguêns. All rights reserved.
//

import XCTest
@testable import NetworkingKit

class ArrayEncodingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testShouldNotConvertArray() {
        
        let encoded = [String]().encodedParameters(with: "test")
        
        XCTAssertEqual(encoded, "")
    }
    
    func testShouldConvertArrayWithOneValue() {
        
        let encoded = [123].encodedParameters(with: "test")
        
        XCTAssertEqual(encoded, "test[]=123")
    }
    
    func testShouldConvertArrayWithoutEncoding() {
        
        let encoded = [123, "test/slash"].encodedParameters(with: "test", encode: false)
        
        XCTAssertEqual(encoded, "test[]=123&test[]=test/slash")
    }
    
    func testShouldConvertArrayWithEncoding() {
        
        let encoded = [123, "test/slash"].encodedParameters(with: "test")
        
        XCTAssertEqual(encoded, "test[]=123&test[]=test%2Fslash")
    }
    
}
