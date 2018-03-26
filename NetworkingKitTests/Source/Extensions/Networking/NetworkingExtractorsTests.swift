//
//  NetworkingExtractorsTestsswift
//  NetworkingKitTests
//
//  Created by Bruno Miguêns on 08/09/2017.
//  Copyright © 2018 Bruno Filipe Miguêns. All rights reserved.
//

import XCTest
@testable import NetworkingKit

class NetworkingExtractorsTests: XCTestCase {
    
    var resultsDictionary: NKDictionary = ["objects": [["id": "123", "is_valid": false],  ["id": "234", "is_valid": true], ["is_valid": true]]]
    
    func testShouldNotExtractResults() {
        
        let dictionary: NKDictionary = [:]
        let asyncExpectation = expectation(description: "testShouldNotExtractResults")
        
        let parser: NKParserHandler<MockObject> = { dict -> (object: MockObject, key: String) in
            return (MockObject(dictionary: dict), "objects")
        }
        
        Networking.extractResults(with: NKResult.Success(dictionary), parser: parser) { final in
            
            switch final.error {
                
            case .invalidData: break
                
            default:
                XCTFail("The returned error should be '.invalidData'.")
            }
            
            asyncExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testShouldExtractResults() {
        
        let asyncExpectation = expectation(description: "testShouldExtractResults")
        
        let parser: NKParserHandler<MockObject> = { dict -> (object: MockObject?, key: String) in
            guard dict["id"] != nil else {
                return (nil, "objects")
            }
            
            return (MockObject(dictionary: dict), "objects")
        }
        
        Networking.extractResults(with: NKResult.Success(resultsDictionary), parser: parser) { final in
            
            XCTAssertNotNil(final.value, "Should exist a valid value.")
            
            XCTAssertTrue(final.value?.count ?? 0 == 2, "The returned value should be an 'Array<MockObject>' with more then 0 ads.")
            
            asyncExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testShouldExtractResultsWithOneObject() {
        
        let asyncExpectation = expectation(description: "testShouldExtractResultsWithOneObject")
        
        let parser: NKParserHandler<MockObject> = { dict -> (object: MockObject, key: String) in
            return (MockObject(dictionary: dict), "")
        }
        
        Networking.extractResults(with: NKResult.Success(["id": "1234"]), parser: parser) { result in
            
            XCTAssertNotNil(result.value, "Should exist a valid value.")
            
            XCTAssertEqual(result.value?.count ?? 0, 1)
            
            XCTAssertEqual(result.value?.first?.identifier, "1234")
            
            asyncExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testShouldParseResults() {
        
        let asyncExpectation = expectation(description: "testShouldParseResults")
        
        let parser: NKParserHandler<MockObject> = { dict -> (object: MockObject, key: String) in
            return (MockObject(dictionary: dict), "objects")
        }
        
        let array = resultsDictionary["objects"] as? [NKDictionary] ?? []
        Networking.parseResults(array, with: parser) { result in
            
            XCTAssertNotNil(result.value, "Should exist a valid value.")
            
            XCTAssertEqual(result.value?.count ?? 0, 3)
            
            asyncExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testShouldParseResult() {
        
        let asyncExpectation = expectation(description: "testShouldParseResult")
        
        let parser: NKParserHandler<MockObject> = { dict -> (object: MockObject, key: String) in
            return (MockObject(dictionary: dict), "")
        }
        
        Networking.parseResult(["id": "1234"], with: parser) { result in
            
            XCTAssertNotNil(result.value, "Should exist a valid value.")
            
            XCTAssertEqual(result.value?.count ?? 0, 1)
            
            XCTAssertEqual(result.value?.first?.identifier, "1234")
            
            asyncExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testShouldParseResultWithKey() {
        
        let asyncExpectation = expectation(description: "testShouldParseResultWithKey")
        
        let parser: NKParserHandler<MockObject> = { dict -> (object: MockObject, key: String) in
            return (MockObject(dictionary: dict), "obj")
        }
        
        Networking.parseResult(["obj": ["id": "1234"]], with: parser) { result in
            
            XCTAssertNotNil(result.value, "Should exist a valid value.")
            
            XCTAssertEqual(result.value?.count ?? 0, 1)
            
            XCTAssertEqual(result.value?.first?.identifier, "1234")
            
            asyncExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testShouldNotParseResultNullObject() {
        
        let asyncExpectation = expectation(description: "testShouldNotParseResultNullObject")
        
        let parser: NKParserHandler<MockObject> = { dict -> (object: MockObject?, key: String) in
            return (nil, "obj")
        }
        
        Networking.parseResult(["obj": ["id": "1234"]], with: parser) { result in
            
            switch result.error {
                
            case .invalidData: break
                
            default:
                XCTFail("The returned error should be '.invalidData'.")
            }
            
            asyncExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
}
