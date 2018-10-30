/*
 
 If any of the objects has less than defined keys, it won't read the JSON
 
[
    {
        "type": "bird",
        "genus": "Chaetura",
        "species": "Vauxi" },
    {
        "type": "car",
        "identifier": "NA12345"
    }
]
*/

import Foundation

struct Bird: Decodable {
    var genus: String
    var species: String
}

struct Car: Decodable {
    var identifier: String
}

enum Either<T, U> {
    case left(T)
    case right(U)
}

extension Either: Decodable where T: Decodable, U: Decodable {
    init(from decoder: Decoder) throws {
        if let value = try? T(from: decoder) {
            self = .left(value)
        } else if let value = try? U(from: decoder) {
            self = .right(value)
        } else {
            let context = DecodingError.Context(codingPath: decoder.codingPath,
                                                debugDescription: "Cannot decode \(T.self) or \(U.self)")
            throw DecodingError.dataCorrupted(context)
        }
    }
}
