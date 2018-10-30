//
//  FlightPlan.swift
//  TestCode
//
//  Created by Anil Prasad on 10/9/18.
//  Copyright © 2018 Anil Prasad. All rights reserved.
//

import Foundation

struct FlightPlan: Codable {
    var aircraft: Aircraft
    
    var route: [String]
    
    var flightRules: FlightRules
    
    private var departureDates: [String: Date]
    
    var proposedDepartureDate: Date? {
        return departureDates["proposed"]
    }
    
    var actualDepartureDate: Date? {
        return departureDates["actual"]
    }
    
    var remarks: String?
    
    private enum CodingKeys: String, CodingKey {
        case aircraft
        case route
        case flightRules = "flight_rules"
        case departureDates = "departure_time"
        case remarks
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.aircraft = try container.decode(Aircraft.self, forKey: .aircraft)
        self.route = try container.decode([String].self, forKey: .route)
        self.flightRules = try container.decode(FlightRules.self, forKey: .flightRules)
        self.departureDates = try container.decode([String: Date].self, forKey: .departureDates)
        self.remarks = try container.decode(String?.self, forKey: .remarks)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.aircraft, forKey: .aircraft)
        try container.encode(self.route, forKey: .route)
        try container.encode(self.flightRules, forKey: .flightRules)
        try container.encode(self.departureDates, forKey: .departureDates)
        try container.encode(self.remarks, forKey: .remarks)
    }
}
