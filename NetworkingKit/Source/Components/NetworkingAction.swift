//
//  NetworkingAction.swift
//  NetworkingKit
//
//  Created by Bruno Miguêns on 30/08/2017.
//  Copyright © 2018 Bruno Filipe Miguêns. All rights reserved.
//

import Foundation
/**
 This enumerator should be used every time you need to inform the networking layer of the kind of the action that you are performing, such as create, delete and so on.

 **Example:**
 Imagine when you have the same endpoint to create and edit some information, in that case, the `NetworkingRouter` will ask you which action do you want to perform to choose the best way to communicate with the API.
 */
public enum NetworkingAction {

    /// This case is to be used when you want to fetch information.
    case fetch

    /// This case is to be used when you want to create a new record.
    case create

    /// This case is to be used when you want to update information.
    case update

    /// This case is to be used when you want to delete information.
    case delete
}
