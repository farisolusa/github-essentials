//
//  Result.swift
//  TestCode
//
//  Created by Anil Prasad on 10/18/18.
//  Copyright © 2018 Anil Prasad. All rights reserved.
//

import Foundation


enum Result<Value> {
    case success(Value)
    case failure(Error)
}

func getPosts(for userId: Int, completion:((Result<[Post]>) -> Void)?) {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "jsonplaceholder.typicode.com"
    urlComponents.path = "/posts"
    
    let userIdItem = URLQueryItem(name: "userId", value: "\(userId)")
    urlComponents.queryItems = [userIdItem]
    
    guard let url = urlComponents.url else {
        fatalError("Could not create URL!")
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    let task = session.dataTask(with: request){ responseData, response, responseError in
        if let error = responseError {
            completion?(.failure(error))
        } else if let jsonData = responseData {
            do {
                let posts = try JSONDecoder().decode([Post].self, from: jsonData)
                completion?(.success(posts))
            } catch {
                completion?(.failure(error))
            }
        } else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unable to load data.."]) as Error
            completion?(.failure(error))
        }
    }
    task.resume()
}

func submitPost(post: Post, completion:((Error?) -> Void)?) {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "jsonplaceholder.typicode.com"
    urlComponents.path = "/posts"
    
    guard let url = urlComponents.url else {
        fatalError("Couldn't create URL!")
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
    var headers = request.allHTTPHeaderFields ?? [:]
    headers["Content-Type"] = "application/json"
    request.allHTTPHeaderFields = headers
    
    do {
        let jsonData = try JSONEncoder().encode(post)
        request.httpBody = jsonData
        
        print("JSON Data:", String(data: request.httpBody!, encoding: .utf8) ?? "No body data!")
    } catch {
        completion?(error)
    }
    
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    let task = session.dataTask(with: request) { responseData, response, responseError in
        guard responseError == nil else {
            completion?(responseError)
            return
        }
        
        if let data = responseData, let utfRepresentation = String(data: data, encoding: .utf8) {
            print("response", utfRepresentation)
        } else {
            print("no data received")
        }
    }
    task.resume()
}
