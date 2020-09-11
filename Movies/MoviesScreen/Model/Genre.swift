//
//  Genre.swift
//  Movies
//
//  Created by Gabriel Mendonça on 09/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation

struct GenreList: Decodable {
    let genres: [Genre]
}

struct Genre: Decodable {
    let name: String
    let id: Int
}
