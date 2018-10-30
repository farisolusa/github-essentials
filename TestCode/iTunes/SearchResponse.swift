//
//  Model.swift
//  TestCode
//
//  Created by Anil Prasad on 10/12/18.
//  Copyright © 2018 Anil Prasad. All rights reserved.
//

import Foundation

struct SearchResponse: Decodable {
    let results: [SearchResult]
}

extension SearchResponse {
    var nonExplicitResults: [SearchResult] {
        return self.results.filter { (result) in
            result.trackExplicitness != .explicit
        }
    }
}
