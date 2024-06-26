//
//  Protocols.swift
//  Movies
//
//  Created by Gabriel Mendonça Sousa Gonçalves  on 28/01/21.
//  Copyright © 2021 Gabriel Mendonça. All rights reserved.
//

import Foundation

protocol ConvertBackdropLink {
    var backdropPath: String? { get }
    var backdropURL: String? { get }
}

protocol ConvertPosterLink {
    var posterPath: String? { get }
    var posterURL: String? { get }
}

protocol MovieEndPoint {
    func fetchGenreMovie(id: Int, completion: @escaping ( _ result: resultGenreMovie) -> Void)
    func fetchNameGenre(completion: @escaping ( _ result: resultNameGenre) -> Void)
    func fetchMoviePopular(completion: @escaping (_ result: resultMoviePopular) -> Void)
}

protocol DescriptionEndPoint {
    func fetchMovieDescription(id: Int, completion: @escaping( _ result: resultMovieDescription) -> Void)
    func fetchMovieRecommendations(id: Int, completion: @escaping(_ result: ResultRecommendation) -> Void)
    func fetchMovieVideo(id: Int, completion: @escaping(_ result: resultMovieVideo ) -> Void)
}

protocol SerieDescriptionEndPoint {
    func fetchSerieDescription(id: Int, completion: @escaping(_ result: ResultSerieDescription) -> Void)
}

