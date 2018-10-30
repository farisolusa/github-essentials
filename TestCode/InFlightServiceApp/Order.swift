//
//  Order.swift
//  TestCode
//
//  Created by Anil Prasad on 10/13/18.
//  Copyright © 2018 Anil Prasad. All rights reserved.
//

import Foundation

struct Order: Codable {
    private(set) var seat: String
    
    struct LineItem: Codable {
        var item: Item
        var count: Int
        var price: Int {
            return item.unitPrice * count
        }
    }
    
    private(set) var lineItems: [LineItem]
    let creationDate: Date = Date()
    
    var totalPrice: Int {
        return lineItems.map{ $0.price }.reduce(0, +)
    }
    
    init(seat: String, itemCounts: [Item: Int]) {
        self.seat = seat
        self.lineItems = itemCounts.compactMap{ $1 > 0 ? LineItem(item: $0, count: $1) : nil }
        /*
        // long-method
        var lineItems: [LineItem] = []
        for (item, count) in itemCounts {
            guard count > 0 else {
                continue
            }
            let lineItem = LineItem(item: item, count: count)
            lineItems.append(lineItem)
        }
        */
    }
}
