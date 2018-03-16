//
//  NetworkingErrorTests.swift
//  NetworkingKitTests
//
//  Created by Bruno Miguêns on 16/03/2018.
//  Copyright © 2018 Bruno Filipe Miguêns. All rights reserved.
//

import XCTest
@testable import NetworkingKit

class NetworkingErrorTests: XCTestCase {
    
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
    
    func testNetworkingError_ShouldCreateResponseInvalid() {
        
        let result: NetworkingError = NetworkingError.responseInvalid(description: exMessage)
        
        XCTAssertEqual(result.message, exMessage, "Should create an '.responseInvalid' with this description '\(exMessage)'")
        
    }
    
    func testNetworkingError_ShouldCreateApiMessage() {
        
        let result = NetworkingError.apiMessage(message: exMessage)
        
        XCTAssertEqual(result.message, exMessage, "Should create an '.apiMessage' with this message '\(exMessage)'")
        
    }
    
    func testNetworkingError_ShouldCreateApiForm() {
        
        let result = NetworkingError.apiForm(form: exDictionary)
        
        switch result {
        case .apiForm(let dictionary):
            XCTAssertEqual(dictionary.count, exDictionary.count, "Should create an '.apiForm' with this dictionary '\(exDictionary)'")
            
        default:
            XCTFail("Networking has returned this wrong output: \(result)")
        }
        
    }
    
    func testNetworkingError_ShouldCreateCustomError() {
        
        let result = NetworkingError.custom(code: exCode, description: exMessage)
        
        XCTAssertEqual(result.code, exCode, "Should create an '.custom' with this code '\(exCode)'")
        XCTAssertEqual(result.message, exMessage, "Should create an '.custom' with this message '\(exMessage)'")
        
    }
    
    func testNetworkingError_ShouldNotConstructError() {
        
        let result = NetworkingError.construct(with: nil)
        
        switch result {
        case .invalidData: break
            
        default:
            XCTFail("Should return an '.invalidData' error.")
        }
        
    }
    
    func testNetworkingError_ShouldConstructError() {
        
        let result = NetworkingError.construct(with: exError)
        
        XCTAssertEqual(result.code, exCode, "Should create an '.custom' with this code '\(exCode)'")
        XCTAssertEqual(result.message, exMessage, "Should create an '.custom' with this message '\(exMessage)'")
        
    }
    
    func testNetworkingError_ShouldNotConstructUrlResponseError() {
        
        var result = NetworkingError.construct(with: nil, and: nil)
        
        switch result {
        case .unknown: break
            
        default:
            XCTFail("Should return an '.unknown' error.")
        }
        
        result = NetworkingError.construct(with: exError, and: nil)
        
        switch result {
        case .unexpected(let objects):
            XCTAssertGreaterThan(objects.count, 0, "Should return at least one object inside of an '.unexpected' error.")
            XCTAssertNotNil(objects.first!, "Should return one object inside of an '.unexpected' error.")
            XCTAssertEqual(objects.first as! NSError, exError, "Should return an error equal to '\(exError)'.")
            
        default:
            XCTFail("Should return an '.unexpected' error.")
        }
        
        result = NetworkingError.construct(with: nil, and: exResponse)
        
        switch result {
        case .invalidRequest(let response):
            XCTAssertEqual(response, exResponse)
            
        default:
            XCTFail("Should return an '.unexpected' or 'invalidRequest' error.")
        }
        
    }
    
    func testNetworkingError_ShouldConstructUrlResponseError() {
        
        let result = NetworkingError.construct(with: exError, and: exResponse)
        
        XCTAssertEqual(result.code, exCode, "Should create an '.custom' with this code '\(exCode)'")
        XCTAssertEqual(result.message, exError.localizedDescription, "Should create an '.custom' with this message '\(exError.localizedDescription)'")
        
    }
    
    func testNetworkingError_ShouldConstructSomeError() {
        
        let result = NetworkingError.construct(with: exError)
        
        XCTAssertEqual(result.code, exCode, "Should create an '.custom' with this code '\(exCode)'")
        XCTAssertEqual(result.message, exMessage, "Should create an '.custom' with this message '\(exMessage)'")
        
    }
    
    func testNetworkingError_CheckCustomErrorUnknownUser() {
        
        let unknownUser: NetworkingError = NetworkingError.unknownUser
        
        XCTAssertEqual(unknownUser.code, -11)
        XCTAssertEqual(unknownUser.message, "No user found to complete the request successfully.")
    }
    
    func testNetworkingErrorShouldReturnMessage() {
        
        XCTAssertEqual(NetworkingError.apiMessage(message: exMessage).message, exMessage)
        
        XCTAssertEqual(NetworkingError.responseInvalid(description: exMessage).message, exMessage)
        
        XCTAssertEqual(NetworkingError.custom(code: 0, description: exMessage).message, exMessage)
    }
    
    func testNetworkingErrorShouldNotReturnMessage() {
        
        XCTAssertNil(NetworkingError.apiForm(form: [:]).message, "The error 'apiForm' should not return a valid message.")
        
        XCTAssertNil(NetworkingError.unknown.message, "The error 'unknown' should not return a valid message.")
        
        XCTAssertNil(NetworkingError.unexpected(objects: [""]).message, "The error 'unexpected' should not return a valid message.")
        
        XCTAssertNil(NetworkingError.invalidUrl.message, "The error 'invalidUrl' should not return a valid message.")
        
        XCTAssertNil(NetworkingError.invalidData.message, "The error 'invalidData' should not return a valid message.")
        
        XCTAssertNil(NetworkingError.invalidToken.message, "The error 'invalidToken' should not return a valid message.")
    }
    
    func testNetworkingErrorShouldReturnCode() {
        
        XCTAssertEqual(NetworkingError.unknown.code, -1)
        
        XCTAssertEqual(NetworkingError.unexpected(objects: [""]).code, -2)
        
        XCTAssertEqual(NetworkingError.invalidUrl.code, -3)
        
        XCTAssertEqual(NetworkingError.invalidData.code, -4)
        
        XCTAssertEqual(NetworkingError.invalidToken.code, -5)
        
        XCTAssertEqual(NetworkingError.responseInvalid(description: "").code, -6)
        
        XCTAssertEqual(NetworkingError.apiMessage(message: "").code, -7)
        
        XCTAssertEqual(NetworkingError.apiForm(form: [:]).code, -8)
        
        XCTAssertEqual(NetworkingError.operationCanceled.code, -9)
        
        XCTAssertEqual(NetworkingError.invalidRequest(response: nil).code, -10)
        
        XCTAssertEqual(NetworkingError.custom(code: 0, description: "").code, 0)
    }
    
    func testNetworkingErrorShouldCompareErrors() {
        
        XCTAssertTrue(NetworkingError.unknown == NetworkingError.unknown, "The comparison method should return 'true'.")
        
        XCTAssertFalse(NetworkingError.unknown == NetworkingError.invalidUrl, "The comparison method should return 'false'.")
    }
    
}
