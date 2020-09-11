//
//  GenreSerie.swift
//  Movies
//
//  Created by Gabriel Mendonça on 13/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation

struct SerieGenreList: Codable {
    let genres: [SerieGenre]
}

struct SerieGenre: Codable {
    let name: String
    let id: Int
}
