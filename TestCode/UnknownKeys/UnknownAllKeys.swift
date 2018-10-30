
/*
 
 Convert it into an array of 3 elements
 
{
    "18348b9b-9a49-4e04-ac35-37e38a8db1e2": {
        "isActive": false,
        "age": 29,
        "company": "BALOOBA"
    },
    "20aca96e-663a-493c-8e9b-cb7b8272f817": {
        "isActive": false,
        "age": 39,
        "company": "QUONATA"
    },
    "bd0c389b-2736-481a-9cf0-170600d36b6d": {
        "isActive": false,
        "age": 35,
        "company": "EARTHMARK"
    }
}
*/

import Foundation

struct Entity: Decodable {
    var isActive: Bool
    var age: Int
    var company: String
}

struct EntityModel: Decodable {
    var entities = [Entity]()
    
    private struct CodingKeys: CodingKey {
        var stringValue: String
        var intValue: Int?
        
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        init?(intValue: Int) {
            self.intValue = intValue
            self.stringValue = "\(intValue)"
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        for key in container.allKeys {
            let entity = try container.decode(Entity.self, forKey: key)
            entities.append(entity)
        }
    }
}
