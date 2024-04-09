//
//  ConvertPosterLink.swift
//  Movies
//
//  Created by Gabriel Mendonça Sousa Gonçalves  on 01/02/21.
//  Copyright © 2021 Gabriel Mendonça. All rights reserved.
//

import UIKit

extension ConvertPosterLink {
    var posterURL: String? {
        if let posterPath = self.posterPath?.replacingOccurrences(of: "^/", with: "", options: .regularExpression) {
            return "https://image.tmdb.org/t/p/w200/\(posterPath)"
            
        }
        return nil
    }
}

extension ConvertBackdropLink {
    var backdropURL: String? {
        if let backdropPath = self.backdropPath?.replacingOccurrences(of: "^/", with: "", options: .regularExpression) {
            return "https://image.tmdb.org/t/p/original/\(backdropPath)"
        }
        return nil
    }
}
