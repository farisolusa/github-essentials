//
//  SearchResult.swift
//  TestCode
//
//  Created by Anil Prasad on 10/12/18.
//  Copyright © 2018 Anil Prasad. All rights reserved.
//

import Foundation

struct SearchResult: Decodable {
    let trackName: String?
    let trackExplicitness: Explicitness?
    let trackViewURL: URL?
    let previewURL: URL?
    let artistName: String?
    let collectionName: String?
    private let artworkURL100: URL?
}

extension SearchResult {
    private enum CodingKeys: String, CodingKey {
        case trackName
        case trackExplicitness
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artistName
        case collectionName
        case artworkURL100 = "artworkUrl100"
    }
    
    func artworkURL(size dimension: Int = 100) -> URL? {
        guard dimension > 0, dimension != 100, var url = self.artworkURL100 else {
            return self.artworkURL100
        }
        url.deleteLastPathComponent()
        url.appendPathComponent("\(dimension)x\(dimension)bb.jpg")
        
        return url
    }
}


