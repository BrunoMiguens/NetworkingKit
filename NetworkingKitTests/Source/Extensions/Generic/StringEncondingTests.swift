//
//  StringEncondingTests.swift
//  NetworkingKitTests
//
//  Created by Bruno Miguêns on 16/03/2018.
//  Copyright © 2018 Bruno Filipe Miguêns. All rights reserved.
//

import XCTest
@testable import NetworkingKit

class StringEncondingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEncodeString() {
        XCTAssertEqual("123abc_+[]".encode, "123abc_%2B%5B%5D")
    }
    
    func testDecodeString() {
        XCTAssertEqual("123abc_%2B%5B%5D".decode, "123abc_+[]")
    }
    
}
