//
//  ViewController.swift
//  TestCode
//
//  Created by Anil Prasad on 10/5/18.
//  Copyright © 2018 Anil Prasad. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    // TRACK: https://github.com/Flight-School/Guide-to-Codable-Sample-Code
    var dataTask: URLSessionTask? = nil
    var results: [SearchResult] = []
    
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        let v1 = UIView(frame: CGRect(100, 111, 132, 194))
        v1.backgroundColor = .gray
        let v2 = UIView()
        v2.backgroundColor = .black
        let v3 = UIView()
        v3.backgroundColor = .lightGray
        
        self.view.addSubview(v1)
        v1.addSubview(v2)
        v1.addSubview(v3)
        
        v2.translatesAutoresizingMaskIntoConstraints = false
        v3.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            v2.leadingAnchor.constraint(equalTo: v1.leadingAnchor),
            v2.trailingAnchor.constraint(equalTo: v1.trailingAnchor),
            v2.topAnchor.constraint(equalTo: v1.topAnchor),
            v2.heightAnchor.constraint(equalToConstant: 10),
            v3.widthAnchor.constraint(equalToConstant: 20),
            v3.heightAnchor.constraint(equalToConstant: 20),
            v3.trailingAnchor.constraint(equalTo: v1.trailingAnchor),
            v3.bottomAnchor.constraint(equalTo: v1.bottomAnchor)
            ])
        
        
        
        
        
        
        
        
        
        //simpleExample()
        //nestedJSON()
        //flightPlan()
        //unknownKeys()
        //unknownKeysRoute()
        //unknownKeysCategory()
        //unknownKeysGenericCodingKeys()
        //indeterminateTypes()
        //unknownAllKeys()
        //inheritedTypes()
        //Generics()
        //inFlightService()
        //userdafaultWithCodable()
        //networkingTasks()
        //measurementU()
        //extendedArray()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func networkingTasks() {
        var finalPosts = [Post]()
        getPosts(for: 1) { (result) in
            switch result {
                case .success(let posts):
                    finalPosts = posts
                    print(finalPosts)
//                savePostsToDisk(posts: finalPosts)
                case .failure(let error):
                    fatalError(error.localizedDescription)
            }
        }
        
        /*
        let posts = getPostsFromDisk()
        print(posts)
        */
       
        let post = Post(userId: 562342342, id: 562342342, title: "The title..", body: "we should receive this response from JSONPlaceholder")
        submitPost(post: post) { (error) in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    func userdafaultWithCodable() {
        PlayerVC()
    }
    
    func inFlightService() {
        
        UserDefaults.standard.register(defaults: ["orders": []])
        
        guard let url = Bundle.main.url(forResource: "Inventory", withExtension: "plist") else {
            fatalError("Inventory.plist missing form main bundle")
        }
        
        let inventory: [Item]
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let plist = try decoder.decode([String: [Item]].self, from: data)
            inventory = plist["items"]!
            //print(inventory)
            
            
        } catch {
            fatalError(error.localizedDescription)
        }
        
        // MARK: Loading Orders
        let orders: [Order]
        do {
            if let data = UserDefaults.standard.object(forKey: "orders") as? Data {
                let decoder = PropertyListDecoder()
                orders = try decoder.decode([Order].self, from: data)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        /*
        // MARK: Saving Orders
        do {
            let encoder = PropertyListEncoder()
            UserDefaults.standard.set(try encoder.encode(orders), forKey: "orders")
        } catch {
            print(error.localizedDescription)
        }
        */
        
        // MARK: Deleting Orders
        UserDefaults.standard.removeObject(forKey: "orders")
    }
    
    /*
    func generics() {
        let gen = Generics()
        gen.generics()
    }
    */
    
    // $ curl -o documentation.html "https://affiliate.itunes.apple.com/resources/documentation/itunes-store-web-service-search-api/"
    // $ cat documentation.html | hxnormalize -x | hxselect -c -s "\n" -i "table:last-of-type td:first-child" | tr , '\n' | tr -d " " | sort > documented-attributes.txt
    // $ curl -o actual.json "https://itunes.apple.com/search?term=jack+johnson&limit=1"
    // $ cat actual.json | jq ".results[0] | keys" | tr -d '[] ",' | sed '/^$/d' | sort > actual-attributes.txt
    // $ comm -1 -3 documented-attributes.txt actual-attributes.txt > undocumented-attributes.txt
    
     /*
     Using the jq utility from before, we extract the values of the artworkUrl30, artworkUrl60, and artworkUrl100 keys from the first element of the results array.
     $ cat actual.json | jq '.results[0] | .artworkUrl30, .artworkUrl60, .artworkUrl100'
     
     Get the value of the artworkUrl100 attribute from jq, pipe that into sed 9 to replace the dimensions with a custom size, and then pipe the result to xargs 10 to open the resulting URL.
     $ cat actual.json | jq '.results[0].artworkUrl100' | sed s/100x100/512x512/ | xargs open
     >>>>> sed is a Unix utility that transforms text.
     >>>>> xargs is a Unix utility that converts piped input into arguments.
     
     
     */
    
    func iTunes() {
        
        
    }
    
    public func search<T>(for type: T.Type, with term: String) where T: MediaType {
        let components = AppleiTunesSearchURLComponents<T>(term: term)
        guard let url = components.url else {
            fatalError("Error creating URL")
        }
        
        self.dataTask?.cancel()
        self.dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                fatalError("Networking error \(String(describing: error)) \(String(describing: response))")
            }
            
            do {
                let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
                self.results = searchResponse.nonExplicitResults
            } catch {
                fatalError("Decoding error \(error)")
            }
            
            DispatchQueue.main.async {
                
            }
        }
        self.dataTask?.resume()
    }
    
    // MARK:
    // MARK: TestCases
    func inheritedTypes() {
        let json = """
        {
            "number": 56,
            "letter": "Something bla bla",
            "mealPreference": "Veg"
        }
        """.data(using: .utf8)!
        do {
            let decodedData = try JSONDecoder().decode(PremimunEconomySeat.self, from: json)
            print(decodedData.mealPreference!)
            print(decodedData.letter)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func indeterminateTypes() {
        let json = """
        [
            {
                "type": "bird",
                "genus": "Chaetura",
                "species": "Vauxi"
            },
            {
                "type": "bird",
                "genus": "Nightengle",
                "species": "Raptor"
            },
            {
                "type": "car",
                "identifier": "NA12345"
            },
            {
                "type": "bird",
                "genus": "Chaetura",
                "species": "Vauxi",
                "color": "White"
            },
        ]
        """.data(using: .utf8)!
        
        do {
            let objects = try JSONDecoder().decode([Either<Bird, Car>].self, from: json)
            
            for object in objects {
                switch object {
                case .left(let bird):
                    print("\(bird.genus) and \(bird.species)")
                    
                case .right(let car):
                    print("\(car.identifier)")
                    
                }
            }
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func unknownAllKeys() {
        let json = """
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
        """.data(using: .utf8)!
        do {
            let decodedJSON = try JSONDecoder().decode(EntityModel.self, from: json)
            print(decodedJSON.entities.first!)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func unknownKeysGenericCodingKeys() {
        
        /*
         The "values" Object is having unknown keys and unknown number of objects. Eg. "cpap", "bi_level", etc.
        */
        
        let json = """
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
        """.data(using: .utf8)!
        
        do {
            let decodedData = try JSONDecoder().decode(MyModel.self, from: json)
            print(decodedData.values)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func unknownKeysCategory() {
        let json = """
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
            },
            {
              "categoryName": "Comedy",
              "Comedy": [
                    {
                      "category": "Comedy",
                      "trailerPrice": "",
                      "isFavourit": null,
                      "isWatchlist": null
                    }
              ]
            }
        ]
        """.data(using: .utf8)!
        let categories = try! JSONDecoder().decode([Category].self, from: json)
        print(categories)
        
    }
    
    func unknownKeysRoute() {
        let json = """
        {
            "points": ["KSQL", "KWVI"],
            "KSQL": {
                "code": "KSQL",
                "name": "San Carlos Airport"
            },
            "KWVI": {
                "code": "KWVI",
                "name": "Watsonville Municipal Airport"
            }
        }
        """.data(using: .utf8)!
        
        do {
            let route = try JSONDecoder().decode(Route.self, from: json)
            let airport = route.points
            print(airport[0].code)
            print(airport)
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func flightPlan() {
        let json = """
        {
            "aircraft": {
                "identification": "NA12345",
                "color": "Blue/White"
            },
            "route": ["KTTD", "KHIO"],
            "flight_rules": "IFR",
            "departure_time": {
                "proposed": "2018-04-27T14:15:00-0700",
                "actual": "2018-04-27T14:20:00-0700"
            },
            "remarks": null
        }
        """.data(using: .utf8)!
        
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let plan = try decoder.decode(FlightPlan.self, from: json)
            print(plan.route)
            print()
            print(plan.flightRules)
            print(plan.aircraft.identification)
            print(plan.proposedDepartureDate!)
            
            let encoder = JSONEncoder()
            
            /*
            // Custom Date formatting
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE, MMM d, yyyy"
            encoder.dateEncodingStrategy = .formatted(formatter)
            */
            
            encoder.dateEncodingStrategy = .iso8601
            let reEncodedJSON = try encoder.encode(plan)
            print(String(data: reEncodedJSON, encoding: .utf8)!)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func nestedJSON() {
        let json = """
        {
            "id": 1,
            "user": {
                "user_name": "Tester",
                "real_info": {
                    "full_name":"Jon Doe"
                }
            },
            "reviews_count": [
                {
                "count": 4
                }
            ]
        }
        """.data(using: .utf8)!
        
        do {
            let decodedData = try JSONDecoder().decode(ServerResponse.self, from: json)
            print(decodedData.fullName)
            print(decodedData.userName)
            print(decodedData.id)
            print(decodedData.reviewCount)

        } catch {
            print(error.localizedDescription)
        }
    }
    func simpleExample() {
        let json = """
        {
            "planes": [
                {
                    "manufacturer": "Air India",
                    "model": "Jet way 4",
                    "seats": 19
                },
                {
                    "manufacturer": "Piper",
                    "model": "PA-28 Cherokee",
                    "seats": 4
                }
            ]
        }
        """.data(using: .utf8)!
        do {
            /*
            let plane = try JSONDecoder().decode([String: [Plane]].self, from: json)
            guard let planes = plane["planes"] else {
                print("Some error..")
                return
            }
            print(planes[0].manufacturer)
            */
            
            //************ OR ****************//
            
            let fleet = try JSONDecoder().decode(Fleet.self, from: json)
            let plane = fleet.planes
            print(plane[0].manufacturer)
        } catch {
            print(error.localizedDescription)
        }
    }
}

