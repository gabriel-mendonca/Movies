//
//  Description.swift
//  Movies
//
//  Created by Gabriel Mendonça on 16/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation

protocol ConvertBackdropLink {
    var backdropPath: String? { get }
    var backdropURL: URL? { get }
}

extension ConvertBackdropLink {
    var backdropURL: URL? {
        if let backdropPath = self.backdropPath?.replacingOccurrences(of: "^/", with: "", options: .regularExpression) {
            return URL(string: backdropPath, relativeTo: URL(string: "https://image.tmdb.org/t/p/original/"))
        }
        return nil
    }
}


struct MovieDescription: Codable, ConvertPosterLink, ConvertBackdropLink {
    let adult: Bool
    let backdropPath: String?
    let voteAverage: Float?
    let releaseDate: String?
    let overview: String?
    let tagline: String?
    let title: String?
    let homepage: String?
    let posterPath: String?
    
    init(adult: Bool, backdropPath: String?, voteAverage: Float?, releaseDate: String?, overview: String?, tagline: String?, title: String?, homepage: String?, posterPath: String?) {
        self.adult = adult
        self.backdropPath = backdropPath
        self.voteAverage = voteAverage
        self.releaseDate = releaseDate
        self.overview = overview
        self.tagline = tagline
        self.title = title
        self.homepage = homepage
        self.posterPath = posterPath
    }

    enum MovieKey: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case overview
        case tagline
        case title
        case homepage
        case posterPath = "poster_path"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieKey.self)
        let adult: Bool = try container.decode(Bool.self, forKey: .adult)
        let backdropPath: String? = try container.decodeIfPresent(String.self, forKey: .backdropPath)
        let voteAverage: Float? = try container.decodeIfPresent(Float.self, forKey: .voteAverage)
        let releaseDate: String? = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        let overview: String? = try container.decodeIfPresent(String.self, forKey: .overview)
        let tagline: String? = try container.decodeIfPresent(String.self, forKey: .tagline)
        let title: String? = try container.decodeIfPresent(String.self, forKey: .title)
        let homepage: String? = try container.decodeIfPresent(String.self, forKey: .homepage)
        let posterPath: String? = try container.decodeIfPresent(String.self, forKey: .posterPath)
        self.init(adult: adult, backdropPath: backdropPath, voteAverage: voteAverage, releaseDate: releaseDate, overview: overview, tagline: tagline, title: title, homepage: homepage, posterPath: posterPath)
    }
}
