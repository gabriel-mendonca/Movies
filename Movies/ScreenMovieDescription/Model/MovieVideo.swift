//
//  MovieVideo.swift
//  Movies
//
//  Created by Gabriel Mendonça Sousa Gonçalves  on 23/01/21.
//  Copyright © 2021 Gabriel Mendonça. All rights reserved.
//

import Foundation


struct MovieReponse: Codable {
    var results: [MovieVideo]
}

struct MovieVideo: Codable {
    let id: String
    let key: String

    init(id: String, key: String) {
        self.id = id
        self.key = key
    }
    
    enum MovieVideoKeys: String, CodingKey {
        case id
        case key
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieVideoKeys.self)
        let id: String? = try container.decodeIfPresent(String.self, forKey: .id)
        let key: String? = try container.decodeIfPresent(String.self, forKey: .key)
        self.init(id: id!, key: key!)
    }
    
}
