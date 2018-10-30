//
//  Item.swift
//  TestCode
//
//  Created by Anil Prasad on 10/13/18.
//  Copyright © 2018 Anil Prasad. All rights reserved.
//

import Foundation

struct Item: Codable, Hashable, Equatable {
    var name: String
    var unitPrice: Int
}
