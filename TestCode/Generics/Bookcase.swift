//
//  Bookcase.swift
//  TestCode
//
//  Created by Anil Prasad on 10/13/18.
//  Copyright © 2018 Anil Prasad. All rights reserved.
//

import Foundation

protocol Storage {
    associatedtype Item
    func store(item: Item)
    func retrive(index: Int) -> Item
}

class Bookcase<Book>: Storage {
    var items: [Book] = [Item]()
    func store(item: Book) {
        items.append(item)
    }
    
    func retrive(index: Int) -> Book {
        return items[index]
    }
}
