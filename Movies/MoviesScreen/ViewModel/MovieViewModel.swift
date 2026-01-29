//
//  MovieViewModel.swift
//  Movies
//
//  Created by Gabriel Mendonça on 09/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation

/// Protocolo para melhorar testabilidade e seguir Dependency Inversion Principle
protocol MovieViewModelProtocol {
    var genreMovie: [Genre] { get }
    func numberOfMoviesGenre() -> Int
    func getMovie(at row: Int) -> (String, Int)
    func loadGenres(completion: @escaping () -> Void)
}

class MovieViewModel: MovieViewModelProtocol {
    
    // MARK: - Properties
    private(set) var genreMovie: [Genre] = []
    private let service: MovieEndPoint
    
    // MARK: - Initialization
    init(service: MovieEndPoint = TheMovieDb()) {
        self.service = service
    }
    
    // MARK: - Public Methods
    func numberOfMoviesGenre() -> Int {
        return genreMovie.count
    }

    func getMovie(at row: Int) -> (String, Int) {
        guard row >= 0 && row < genreMovie.count else {
            return ("", 0)
        }
        return (genreMovie[row].name, genreMovie[row].id)
    }
    
    func loadGenres(completion: @escaping () -> Void) {
        service.fetchNameGenre { [weak self] result in
            switch result {
            case .sucess(let listGenre):
                self?.genreMovie = listGenre
                completion()
            case .failure(let error):
                self?.handleError()
            }
        }
    }
    
    private func handleError() {
        // Implementar tratamento de erro adequado
    }
}
