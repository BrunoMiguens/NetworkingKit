//
//  ProcessInfo+Extension.swift
//  NetworkingKit
//
//  Created by Bruno Miguêns on 15/03/2018.
//  Copyright © 2018 Bruno Filipe Miguêns. All rights reserved.
//

import Foundation


public extension ProcessInfo {
    
    // MARK: Properties
    
    /// This property will indicate if the actual app is running some of the unit tests.
    class var runningUnitTests: Bool {
        return ProcessInfo.processInfo.environment["XCInjectBundleInto"] != nil
    }
    
}
