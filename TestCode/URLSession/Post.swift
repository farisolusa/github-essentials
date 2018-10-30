//
//  Post.swift
//  TestCode
//
//  Created by Anil Prasad on 10/18/18.
//  Copyright © 2018 Anil Prasad. All rights reserved.
//

import Foundation

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
