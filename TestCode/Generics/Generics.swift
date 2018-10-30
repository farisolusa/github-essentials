//
//  Generics.swift
//  TestCode
//
//  Created by Anil Prasad on 10/13/18.
//  Copyright © 2018 Anil Prasad. All rights reserved.
//

import Foundation

class Generics {
    init() {
        generics()
    }
    
    func generics() {
        print(addFunc(a: 2.3, b: 3))
        print(addFunc(a: Double.pi, b: Double.pi))
        print(findIndex(of: 23, in: [1, 3, 34, 23, 4, 44, 65])!)
        
        withProtocolsAndAssociatedTypes()
    }
    
    func addFunc<T: Numeric>(a: T, b: T) -> T {
        return a + b
    }
    
    func findIndex<T: Equatable>(of foundItem:T, in items: [T]) -> Int? {
        for (index, item) in items.enumerated() {
            if item == foundItem {
                return index
            }
        }
        return nil
    }
    
    func withProtocolsAndAssociatedTypes() {
        struct PaperBook {
            var bookName: String
            var pages: Int
        }
        
        struct eBook {
            var bookName: String
            var pages: Int
            var ISBN: String
            var isAvailable: Bool
        }
        
        let book1 = Bookcase<PaperBook>()
        book1.store(item: PaperBook(bookName: "Swift Book", pages: 350))
        book1.store(item: PaperBook(bookName: "PHP", pages: 444))
        book1.store(item: PaperBook(bookName: "Indian Culture", pages: 500))
        print(book1.retrive(index: 1).bookName)
        
        let book2 = Bookcase<eBook>()
        book2.store(item: eBook(bookName: "Java", pages: 1145, ISBN: "KA23422", isAvailable: true))
        book2.store(item: eBook(bookName: "Python", pages: 5455, ISBN: "8789ASJ", isAvailable: true))
        print(book2.retrive(index: 0))
    }
}
