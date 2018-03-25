//
//  NKErrorTests.swift
//  NetworkingKitTests
//
//  Created by Bruno Miguêns on 16/03/2018.
//  Copyright © 2018 Bruno Filipe Miguêns. All rights reserved.
//

import XCTest
@testable import NetworkingKit

class NKErrorTests: XCTestCase {
    
    let url = URL(string: "http://apple.com/pt")!
    
    var exCode = 0
    var exMessage = ""
    var exError = NSError()
    var exResponse = HTTPURLResponse()
    var exDictionary: NKDictionary = [:]
    
    override func setUp() {
        super.setUp()
        
        exCode = 1000
        exDictionary = ["id": 20]
        exMessage = "This is a custom error."
        exResponse = HTTPURLResponse(url: url, statusCode: exCode, httpVersion: "1.0", headerFields: nil)!
        exError = NSError(domain: "Domain", code: exCode, userInfo: [NSLocalizedDescriptionKey: exMessage])
    }
    
    func testNKError_ShouldCreateResponseInvalid() {
        
        let result: NKError = NKError.responseInvalid(description: exMessage)
        
        XCTAssertEqual(result.message, exMessage, "Should create an '.responseInvalid' with this description '\(exMessage)'")
        
    }
    
    func testNKError_ShouldCreateApiMessage() {
        
        let result = NKError.apiMessage(message: exMessage)
        
        XCTAssertEqual(result.message, exMessage, "Should create an '.apiMessage' with this message '\(exMessage)'")
        
    }
    
    func testNKError_ShouldCreateApiForm() {
        
        let result = NKError.apiForm(form: exDictionary)
        
        switch result {
        case .apiForm(let dictionary):
            XCTAssertEqual(dictionary.count, exDictionary.count, "Should create an '.apiForm' with this dictionary '\(exDictionary)'")
            
        default:
            XCTFail("Networking has returned this wrong output: \(result)")
        }
        
    }
    
    func testNKError_ShouldCreateCustomError() {
        
        let result = NKError.custom(code: exCode, description: exMessage)
        
        XCTAssertEqual(result.code, exCode, "Should create an '.custom' with this code '\(exCode)'")
        XCTAssertEqual(result.message, exMessage, "Should create an '.custom' with this message '\(exMessage)'")
        
    }
    
    func testNKError_ShouldNotConstructError() {
        
        let result = NKError.construct(with: nil)
        
        switch result {
        case .invalidData: break
            
        default:
            XCTFail("Should return an '.invalidData' error.")
        }
        
    }
    
    func testNKError_ShouldConstructError() {
        
        let result = NKError.construct(with: exError)
        
        XCTAssertEqual(result.code, exCode, "Should create an '.custom' with this code '\(exCode)'")
        XCTAssertEqual(result.message, exMessage, "Should create an '.custom' with this message '\(exMessage)'")
        
    }
    
    func testNKError_ShouldNotConstructUrlResponseError() {
        
        var result = NKError.construct(with: nil, and: nil)
        
        switch result {
        case .unknown: break
            
        default:
            XCTFail("Should return an '.unknown' error.")
        }
        
        result = NKError.construct(with: exError, and: nil)
        
        switch result {
        case .unexpected(let objects):
            XCTAssertGreaterThan(objects.count, 0, "Should return at least one object inside of an '.unexpected' error.")
            XCTAssertNotNil(objects.first!, "Should return one object inside of an '.unexpected' error.")
            XCTAssertEqual(objects.first as! NSError, exError, "Should return an error equal to '\(exError)'.")
            
        default:
            XCTFail("Should return an '.unexpected' error.")
        }
        
        result = NKError.construct(with: nil, and: exResponse)
        
        switch result {
        case .invalidRequest(let response):
            XCTAssertEqual(response, exResponse)
            
        default:
            XCTFail("Should return an '.unexpected' or 'invalidRequest' error.")
        }
        
    }
    
    func testNKError_ShouldConstructUrlResponseError() {
        
        let result = NKError.construct(with: exError, and: exResponse)
        
        XCTAssertEqual(result.code, exCode, "Should create an '.custom' with this code '\(exCode)'")
        XCTAssertEqual(result.message, exError.localizedDescription, "Should create an '.custom' with this message '\(exError.localizedDescription)'")
        
    }
    
    func testNKError_ShouldConstructSomeError() {
        
        let result = NKError.construct(with: exError)
        
        XCTAssertEqual(result.code, exCode, "Should create an '.custom' with this code '\(exCode)'")
        XCTAssertEqual(result.message, exMessage, "Should create an '.custom' with this message '\(exMessage)'")
        
    }
    
    func testNKError_CheckCustomErrorUnknownUser() {
        
        let unknownUser: NKError = NKError.unknownUser
        
        XCTAssertEqual(unknownUser.code, -11)
        XCTAssertEqual(unknownUser.message, "No user found to complete the request successfully.")
    }
    
    func testNKErrorShouldReturnMessage() {
        
        XCTAssertEqual(NKError.apiMessage(message: exMessage).message, exMessage)
        
        XCTAssertEqual(NKError.responseInvalid(description: exMessage).message, exMessage)
        
        XCTAssertEqual(NKError.custom(code: 0, description: exMessage).message, exMessage)
    }
    
    func testNKErrorShouldNotReturnMessage() {
        
        XCTAssertNil(NKError.apiForm(form: [:]).message, "The error 'apiForm' should not return a valid message.")
        
        XCTAssertNil(NKError.unknown.message, "The error 'unknown' should not return a valid message.")
        
        XCTAssertNil(NKError.unexpected(objects: [""]).message, "The error 'unexpected' should not return a valid message.")
        
        XCTAssertNil(NKError.invalidUrl.message, "The error 'invalidUrl' should not return a valid message.")
        
        XCTAssertNil(NKError.invalidData.message, "The error 'invalidData' should not return a valid message.")
        
        XCTAssertNil(NKError.invalidToken.message, "The error 'invalidToken' should not return a valid message.")
    }
    
    func testNKErrorShouldReturnCode() {
        
        XCTAssertEqual(NKError.unknown.code, -1)
        
        XCTAssertEqual(NKError.unexpected(objects: [""]).code, -2)
        
        XCTAssertEqual(NKError.invalidUrl.code, -3)
        
        XCTAssertEqual(NKError.invalidData.code, -4)
        
        XCTAssertEqual(NKError.invalidToken.code, -5)
        
        XCTAssertEqual(NKError.responseInvalid(description: "").code, -6)
        
        XCTAssertEqual(NKError.apiMessage(message: "").code, -7)
        
        XCTAssertEqual(NKError.apiForm(form: [:]).code, -8)
        
        XCTAssertEqual(NKError.operationCanceled.code, -9)
        
        XCTAssertEqual(NKError.invalidRequest(response: nil).code, -10)
        
        XCTAssertEqual(NKError.custom(code: 0, description: "").code, 0)
    }
    
    func testNKErrorShouldCompareErrors() {
        
        XCTAssertTrue(NKError.unknown == NKError.unknown, "The comparison method should return 'true'.")
        
        XCTAssertFalse(NKError.unknown == NKError.invalidUrl, "The comparison method should return 'false'.")
    }
    
}
