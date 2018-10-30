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

protocol FuelPrice {
    var type: Fuel {get}
    var pricePerLiter: Double {get}
    var currency: String {get}
}

struct AmericanFuelPrice: Decodable {
    let fuel: Fuel
    let price: Double
}

struct CanadianFuelPrice: Decodable {
    let type: Fuel
    let price: Double
}

extension AmericanFuelPrice: FuelPrice {
    var type: Fuel {
        return self.fuel
    }
    
    var pricePerLiter: Double {
        return self.price / 3.78541
    }
    
    var currency: String {
        return "USD"
    }
}

extension CanadianFuelPrice: FuelPrice {
    var pricePerLiter: Double {
        return self.price
    }
    
    var currency: String {
        return "CAD"
    }
}

/*
struct FuelPrice: Decodable {
    let type: Fuel
    let pricePerLiter: Double
    let currency: String
}

struct AmericanFuelPrice: Decodable {
    let fuel: Fuel
    let price: Double
}

struct CanadianFuelPrice: Decodable {
    let type: Fuel
    let price: Double
}


extension FuelPrice {
    init(_ other: AmericanFuelPrice) {
        self.type = other.fuel
        self.pricePerLiter = other.price / 3.78541
        self.currency = "USD"
    }
}

extension FuelPrice {
    init(_ other: CanadianFuelPrice) {
        self.type = other.type
        self.pricePerLiter = other.price
        self.currency = "CAD"
    }
}
*/



