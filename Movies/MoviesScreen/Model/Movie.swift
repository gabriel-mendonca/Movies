//
//  Movie.swift
//  Movies
//
//  Created by Gabriel Mendonça on 09/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation


protocol ConvertPosterLink {
    var posterPath: String? { get }
    var posterURL: URL? { get }
}

extension ConvertPosterLink {
    var posterURL: URL? {
        if let posterPath = self.posterPath?.replacingOccurrences(of: "^/", with: "", options: .regularExpression) {
            return URL(string: posterPath, relativeTo: URL(string: "https://image.tmdb.org/t/p/w200/"))
            
        }
        return nil
    }
    
}

struct ListMovie: Codable {
    let results: [Movie]
}

struct Movie: Codable, ConvertPosterLink {
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
        let posterPath: String? = try container.decodeIfPresent(String.self, forKey: .posterPath)
        let id: Int? = try container.decodeIfPresent(Int.self, forKey: .id)
        self.init(posterPath: posterPath, id: id)
    }
    
}
