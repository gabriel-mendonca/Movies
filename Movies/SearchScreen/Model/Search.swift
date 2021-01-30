//
//  Search.swift
//  Movies
//
//  Created by Gabriel Mendonça on 14/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation

struct SearchMovieResult: Codable {
    var results: [MovieSearch]
}

struct MovieSearch: Codable,ConvertPosterLink {
    
    let mediaType: String?
    let posterPath: String?
    let id: Int?

    init(mediaType: String?,posterPath: String?, id: Int?) {
        self.mediaType = mediaType
        self.posterPath = posterPath
        self.id = id
    }
    
   private enum MovieKey: String, CodingKey {
        case mediaType = "media_type"
        case posterPath = "poster_path"
        case id
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieKey.self)
        let mediaType = try container.decodeIfPresent(String.self, forKey: .mediaType)
        let posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        let id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.init(mediaType: mediaType,posterPath: posterPath, id: id)
    }
    
}
