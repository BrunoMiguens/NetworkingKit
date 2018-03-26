//
//  NetworkingHeaderTests.swift
//  NetworkingKitTests
//
//  Created by bruno.miguens on 26/03/2018.
//  Copyright © 2018 Bruno Filipe Miguêns. All rights reserved.
//

import XCTest
@testable import NetworkingKit

class NetworkingHeaderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testShouldReturnRawAndHashValue() {
        
        XCTAssertEqual(NetworkingHeader.custom(key: "CustomKey").rawValue, "CustomKey")
        XCTAssertEqual(NetworkingHeader.custom(key: "CustomKey").hashValue, -3809955243953086068)
        
        XCTAssertEqual(NetworkingHeader.accept.rawValue, "Accept")
        XCTAssertEqual(NetworkingHeader.accept.hashValue, 4795217978461398007)
        
        XCTAssertEqual(NetworkingHeader.contentMD5.rawValue, "Content-MD5")
        XCTAssertEqual(NetworkingHeader.contentMD5.hashValue, -381193680838012168)
        
        XCTAssertEqual(NetworkingHeader.contentType.rawValue, "Content-Type")
        XCTAssertEqual(NetworkingHeader.contentType.hashValue, -7986832229421639017)
        
        XCTAssertEqual(NetworkingHeader.cacheControl.rawValue, "Cache-Control")
        XCTAssertEqual(NetworkingHeader.cacheControl.hashValue, 144653837138404814)
        
        XCTAssertEqual(NetworkingHeader.authorization.rawValue, "Authorization")
        XCTAssertEqual(NetworkingHeader.authorization.hashValue, -5715220190327829409)
        
        XCTAssertEqual(NetworkingHeader.contentLength.rawValue, "Content-Length")
        XCTAssertEqual(NetworkingHeader.contentLength.hashValue, 2849783147190465881)
        
        XCTAssertEqual(NetworkingHeader.acceptCharset.rawValue, "Accept-Charset")
        XCTAssertEqual(NetworkingHeader.acceptCharset.hashValue, 4149671098850114420)
        
        XCTAssertEqual(NetworkingHeader.acceptEncoding.rawValue, "Accept-Encoding")
        XCTAssertEqual(NetworkingHeader.acceptEncoding.hashValue, -939559416034448238)
        
        XCTAssertEqual(NetworkingHeader.acceptLanguage.rawValue, "Accept-Language")
        XCTAssertEqual(NetworkingHeader.acceptLanguage.hashValue, 914907109574654609)
    }

}
