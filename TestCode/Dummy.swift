import Foundation

struct Person {
    var name: String
    var age: Int
}

func extendedArray() {
    findLargestNumber()
    findOldestPerson()
    openCollection()
    personsAllowedToDrive(age: 19)
}

func findLargestNumber() {
    let numbers = [10, 45, 4, 8, 6, 67, 0, 56, 4, 25]
    print(numbers.largestumber!)
    print(numbers.largestumber ?? 0)
}

func findOldestPerson() {
    let persons = [
        Person(name: "A", age: 23),
        Person(name: "G", age: 21),
        Person(name: "AS", age: 2),
        Person(name: "H", age: 45),
        Person(name: "O", age: 19)
    ]
    
    if let oldestPerson = persons.oldestPerson {
        print("Oldest person is \(oldestPerson.name)")
    }
    
    
}


extension Array where Element == Int {
    var largestumber: Element? {
        return sorted().last
    }
}

extension Array where Element == Person {
    var oldestPerson: Element? {
        return sorted(by: {$0.age > $1.age}).first
    }
}

//MARK: Open Collection Ranges

func openCollection() {
    /*
    Fully open-ended range
    X... where X is an integer indicating the first index of the collection to include in the range.
     
    Fully open-starting range
    ...X where X is an integer indicating the last index of the collection to include in the range.
     
    Half open-starting range
    ..<X where X is an integer indicating the index that follows the end of the collection.
    */
    
    let names = ["abc", "efg", "hij", "klm", "nop"]
    print(names.dropFirst())
    print(names.dropLast())
    print(names[...2]) // ["abc", "efg", "hij"]
    print(names[3...]) // ["klm", "nop"]
    print(names[..<3]) // ["abc", "efg", "hij"]
    
}

func personsAllowedToDrive(age: Int) {
    switch age {
    case 20...:
        print("Allowed")
    case ..<21:
        print("Not allowed")
    default:
        print("NO")
    }
}
