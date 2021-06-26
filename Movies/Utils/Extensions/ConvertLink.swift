//
//  ConvertPosterLink.swift
//  Movies
//
//  Created by Gabriel Mendonça Sousa Gonçalves  on 01/02/21.
//  Copyright © 2021 Gabriel Mendonça. All rights reserved.
//

import UIKit

extension ConvertPosterLink {
    var posterURL: URL? {
        if let posterPath = self.posterPath?.replacingOccurrences(of: "^/", with: "", options: .regularExpression) {
            return URL(string: posterPath, relativeTo: URL(string: "https://image.tmdb.org/t/p/w200/"))
            
        }
        return nil
    }
}

extension ConvertBackdropLink {
    var backdropURL: URL? {
        if let backdropPath = self.backdropPath?.replacingOccurrences(of: "^/", with: "", options: .regularExpression) {
            return URL(string: backdropPath, relativeTo: URL(string: "https://image.tmdb.org/t/p/original/"))
        }
        return nil
    }
}
