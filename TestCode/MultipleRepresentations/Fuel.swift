/*
[
    {
        "fuel": "100LL",
        "price": 5.60
    },
    {
        "fuel": "Jet A",
        "price": 4.10
    }
]

{
    "fuels": [
        {
        "type": "100LL",
        "price": 2.54
        },
        {
        "type": "Jet A",
        "price": 3.14
        },
        {
        "type": "Jet B",
        "price": 3.03
        }
    ]
}
*/

import Foundation

enum Fuel: String, Decodable {
    case jetA = "Jet A"
    case jetB = "Jet B"
    case oneHundredLowLead = "100LL"
}
