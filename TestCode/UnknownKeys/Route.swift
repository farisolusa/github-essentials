
/*
{
    "points": ["KSQL", "KWVI"],
    "KSQL": {
        "code": "KSQL",
        "name": "San Carlos Airport"
    },
    "KWVI": {
        "code": "KWVI",
        "name": "Watsonville Municipal Airport"
    }
}
*/

import Foundation

struct Route: Decodable{
    struct Airport: Decodable {
        var code: String
        var name: String
    }
    
    var points: [Airport]
    
    struct CodingKeys: CodingKey {
        var stringValue: String
        var intValue: Int?
        
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        init?(intValue: Int) {
            self.intValue = intValue
            self.stringValue = "\(intValue)"
        }
        
        static let points = CodingKeys(stringValue: "points")!
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        var points: [Airport] = []
        let codes = try container.decode([String].self, forKey: .points)
        
        for code in codes {
            let key = CodingKeys(stringValue: code)!
            let airport = try container.decode(Airport.self, forKey: key)
            points.append(airport)
        }
        self.points = points
    }
}
