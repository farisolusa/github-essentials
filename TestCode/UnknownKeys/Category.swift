/*
[
    {
        "categoryName": "Trending",
        "Trending": [
            {
            "category": "Trending",
            "trailerPrice": "",
            "isFavourit": null,
            "isWatchlist": null
            }
        ]
    }
]
*/

import Foundation

struct Category: Decodable {
    struct Detail: Decodable {
        var category: String
        var trailerPrice: String
        var isFavourit: Bool?
        var isWatchList: Bool?
    }
    
    var name: String
    var detail: Detail
    
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
        
        static let name = CodingKeys(stringValue: "categoryName")!
        static func makeKey(name: String) -> CodingKeys {
            return CodingKeys(stringValue: name)!
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.detail = try container.decode([Detail].self, forKey: CodingKeys.makeKey(name: name)).first!
    }
}
