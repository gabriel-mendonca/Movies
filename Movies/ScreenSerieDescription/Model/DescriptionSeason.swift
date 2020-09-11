//
//  DescriptionSeason.swift
//  Movies
//
//  Created by Gabriel Mendonça on 17/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation

struct DescriptionSeason:Codable, ConvertPosterLink {
    let posterPath: String?
    let name: String?
    
    init(posterPath: String?, name: String?) {
        self.posterPath = posterPath
        self.name = name
    }

    enum MovieKey: String, CodingKey {
        case posterPath = "poster_path"
        case name
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieKey.self)
        let posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        let name = try container.decodeIfPresent(String.self, forKey: .name)
        self.init(posterPath: posterPath, name: name)
    }
}
