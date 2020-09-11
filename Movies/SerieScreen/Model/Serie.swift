//
//  Serie.swift
//  Movies
//
//  Created by Gabriel Mendonça on 13/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation

struct ListSeries: Codable {
    let results: [Serie]
}

struct Serie: Codable, ConvertPosterLink {
    let posterPath: String?
    let id: Int?
    
    init(posterPath: String?, id: Int?) {
        self.posterPath = posterPath
        self.id = id
    }
    
    enum MovieKey: String, CodingKey {
        case posterPath = "poster_path"
        case id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieKey.self)
        let posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        let id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.init(posterPath: posterPath, id: id)
    }
}
