//
//  PremimumEconomySeat.swift
//  TestCode
//
//  Created by Anil Prasad on 10/11/18.
//  Copyright © 2018 Anil Prasad. All rights reserved.
//

import Foundation

class PremimunEconomySeat: EconomySeat {
    var mealPreference: String?
    
    private enum CodingKeys: String, CodingKey {
        case mealPreference
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.mealPreference = try container.decodeIfPresent(String.self, forKey: .mealPreference)
        
        try super.init(from: decoder)
    }
}
