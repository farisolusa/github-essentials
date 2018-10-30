/*
 The "values" Object is having unknown keys and unknown number of objects. Eg. "cpap", "bi_level", etc.
 
{
    "current": "a value",
    "hash": "some value",
    "values": {
        "cpap": "34",
        "bi_level": "5",
        "auto_cpap": "23",
        "st": "6",
        "auto_st": "0"
    }
}
*/

import Foundation

struct GenericCodingKeys: CodingKey {
    var intValue: Int?
    var stringValue: String
    
    init?(intValue: Int) {
        self.intValue = intValue
        self.stringValue = "\(intValue)"
    }
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    static func makeKey(name: String) -> GenericCodingKeys {
        return GenericCodingKeys(stringValue: name)!
    }
}


struct MyModel: Decodable {
    var current: String
    var hash: String
    var values: [String: String]
    
    private enum CodingKeys: String, CodingKey {
        case current
        case hash
        case values
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        current = try container.decode(String.self, forKey: .current)
        hash = try container.decode(String.self, forKey: .hash)
        
        values = [String: String]()
        let subContainer = try container.nestedContainer(keyedBy: GenericCodingKeys.self, forKey: .values)
        for key in subContainer.allKeys {
            values[key.stringValue] = try subContainer.decode(String.self, forKey: key)
        }
    }
}

/*
 
 If changing variable is the name of the dictionary. (customName)
{
    "customName": {
        "constantKey": Double,
        "constantKey2": Double,
    }
}
*/

struct MyModel2: Decodable {
    struct InnerModel: Decodable {
        var constantKey1: Double
        var constantKey2: Double
    }
    
    var customName: InnerModel
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: GenericCodingKeys.self)
        
        // Assume that there's only 1 key at the top level in the JSON
        if let key = container.allKeys.first {
            customName = try container.decode(InnerModel.self, forKey: key)
        } else {
            throw NSError(domain: NSCocoaErrorDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: "JSON is empty"])
        }
    }
}
