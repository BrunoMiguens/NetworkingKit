//
//  DictionaryEncodingTests.swift
//  NetworkingKitTests
//
//  Created by Bruno Miguêns on 23/10/2017.
//  Copyright © 2018 Bruno Filipe Miguêns. All rights reserved.
//

import XCTest
@testable import NetworkingKit

class DictionaryEncodingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testShouldNotConvertHttpParameters() {
        
        let encoded = NKStringDictionary().httpParameters
        
        XCTAssertEqual(encoded, "")
    }
    
    func testShouldConvertHttpParametersOneKey() {
        
        let encoded = ["test": 123].httpParameters
        
        XCTAssertEqual(encoded, "test=123")
    }
    
    func testShouldConvertHttpParametersOneKeyDouble() {
        
        let encoded = ["test": 120.3].httpParameters
        
        XCTAssertEqual(encoded, "test=120.3")
    }
    
    func testShouldConvertHttpParametersTwoKeys() {
        
        let encoded = ["test": 123, "test/slash": "abc"].httpParameters
        
        XCTAssertEqual(encoded, "test=123&test%2Fslash=abc")
    }
    
    func testShouldNotConvertFormDataParameters() {
        
        let encoded = NKStringDictionary().formDataParameters()
        
        XCTAssertEqual(encoded, "")
    }
    
    func testShouldConvertFormDataOneKey() {
        
        let encoded = ["test": 123].formDataParameters()
        
        XCTAssertEqual(encoded, "test=123")
    }
    
    func testShouldConvertFormDataDictionaryInside() {
        
        let encoded = ["test": ["id": 123]].formDataParameters()
        
        XCTAssertEqual(encoded, "test[id]=123")
    }
    
    func testShouldConvertFormDataArrayInside() {
        
        let encoded = ["test": [12, 123]].formDataParameters()
        
        XCTAssertEqual(encoded, "test[]=12&test[]=123")
    }
    
    func testShouldConvertFormDataWithEncode() {
        
        let encoded = ["test": [12, 123], "user":  ["id": 123], "phone": 12345, "email": "@"].formDataParameters()
        
        XCTAssertEqual(encoded, "phone=12345&user[id]=123&email=%40&test[]=12&test[]=123")
    }
    
    func testShouldConvertFormDataWithoutEncode() {
        
        let encoded = ["test": [12, 123], "user":  ["id": 123], "phone": 12345, "email": "@", "extra": "N/A"].formDataParameters(encode: false)
        
        XCTAssertEqual(encoded, "phone=12345&user[id]=123&email=@&test[]=12&test[]=123&extra=N/A")
    }
    
    func testShouldNotConvertEncodedParameters() {
        
        let encoded = NKStringDictionary().encodedParameters()
        
        XCTAssertEqual(encoded, "")
    }
    
    func testShouldConvertEncodedOneKey() {
        
        let encoded = ["test": 123].encodedParameters()
        
        XCTAssertEqual(encoded, "test=123")
    }
    
    func testShouldConvertEncodedDictionaryInside() {
        
        let encoded = ["id": 123].encodedParameters(baseKey: "test")
        
        XCTAssertEqual(encoded, "test[id]=123")
    }
    
    func testShouldConvertEncodedArrayInside() {
        
        let encoded = ["test": [12, 123]].encodedParameters()
        
        XCTAssertEqual(encoded, "test[]=12&test[]=123")
    }
    
    func testShouldConvertEncodedDictionaryInsideDictionary() {
        
        let encoded = ["test": ["id": 123]].encodedParameters()
        
        XCTAssertEqual(encoded, "test[id]=123")
    }
    
    func testShouldConvertEncodedStringInside() {
        
        let encoded = ["id": "@"].encodedParameters()
        
        XCTAssertEqual(encoded, "id=%40")
    }
    
    func testShouldConvertEncodedStringInsideWithoutEncode() {
        
        let encoded = ["id": "@"].encodedParameters(encode: false)
        
        XCTAssertEqual(encoded, "id=@")
    }
    
}
