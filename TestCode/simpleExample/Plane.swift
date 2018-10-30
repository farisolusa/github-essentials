//
//  Plane.swift
//  TestCode
//
//  Created by Anil Prasad on 10/9/18.
//  Copyright © 2018 Anil Prasad. All rights reserved.
//

import Foundation

struct Plane: Codable {
    var manufacturer: String
    var model: String
    var seats: Int
    
    private enum CodingKeys: String, CodingKey {
        case manufacturer
        case model
        case seats
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.manufacturer = try container.decode(String.self, forKey: .manufacturer)
        self.model = try container.decode(String.self, forKey: .model)
        self.seats = try container.decode(Int.self, forKey: .seats)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.manufacturer, forKey: .manufacturer)
        try container.encode(self.model, forKey: .model)
        try container.encode(self.seats, forKey: .seats)
    }
 
}
