//
//  NetworkingTasks.swift
//  TestCode
//
//  Created by Anil Prasad on 10/17/18.
//  Copyright © 2018 Anil Prasad. All rights reserved.
//

import Foundation
import UIKit

class NetworkingTasks {
    init() {
        getRequest()
    }
    
    func getRequest() {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let url = URL(string: "https://httpbin.org/anything")!
        
        let task = session.dataTask(with: url) { data, response, error in
            guard let content = data, error == nil else {
                print("Networking error: \(error), \(response)")
                return
            }
            
            do {
                let json = try JSONDecoder().decode([String: AnyDecodable].self, from: content)
                //let headers = Dictionary(json["headers"]!)
                print(json["headers"]!)
                
                // Output
                let _ = """
                [
                    "json": AnyDecodable(nil),
                    "headers": AnyDecodable([
                        "Accept-Encoding": "br, gzip, deflate",
                        "Accept-Language": "en-us",
                        "Host": "httpbin.org",
                        "Connection": "close",
                        "Accept": "*/*",
                        "User-Agent": "TestCode/1 CFNetwork/974.2.1 Darwin/17.7.0"
                        ]),
                    "data": AnyDecodable(""),
                    "files": AnyDecodable([
                        :
                        ]),
                    "origin": AnyDecodable("61.12.32.74"),
                    "form": AnyDecodable([
                        :
                        ]),
                    "method": AnyDecodable("GET"),
                    "url": AnyDecodable("https://httpbin.org/anything"),
                    "args": AnyDecodable([
                        :
                        ])
                ]
                """
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func postRequest() {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let url = URL(string: "https://httpbin.org/anything")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let postDict: [String: AnyEncodable] = ["current": "a value",
                                                "hash": "some value",
                                                "values": ["cpap": "34",
                                                           "bi_level": "5",
                                                           "auto_cpap": "23",
                                                           "st": "6",
                                                           "auto_st": "0"]]
        
    }
    
    
}
