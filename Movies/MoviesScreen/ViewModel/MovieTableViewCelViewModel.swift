//
//  MovieTableViewCelViewModel.swift
//  Movies
//
//  Created by Gabriel Mendonça on 09/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation

protocol MovieCollectionViewCellDelegate: AnyObject {
    func cellTapped(movie: Movie)
    func cellTappedRecommendation(_ movie: Movie)
}

/// Protocolo para melhorar testabilidade
protocol MovieTableViewCellViewModelProtocol {
    var listGenreMovie: [Movie] { get }
    var id: Int { get set }
    func numberOfMovies() -> Int
    func get(at row: Int) -> String?
    func loadMovies(completion: @escaping () -> Void)
    func loadPopularMovies(completion: @escaping () -> Void)
}

class MovieTableViewCellViewModel: MovieTableViewCellViewModelProtocol {
    
    // MARK: - Properties
    private(set) var listGenreMovie: [Movie] = []
    var id: Int = 0
    weak var delegate: MovieCollectionViewCellDelegate?
    
    private let service: MovieEndPoint
    
    // MARK: - Initialization
    init(coordinator: MovieCoordinator? = nil, service: MovieEndPoint = TheMovieDb()) {
        self.service = service
        self.delegate = coordinator
    }
    
    // MARK: - Public Methods
    func showMovieDescription(_ movie: Movie) {
        delegate?.cellTapped(movie: movie)
    }
    
    func showMovieRecommendation(_ movie: Movie) {
        delegate?.cellTappedRecommendation(movie)
    }
    
    func numberOfMovies() -> Int {
        return listGenreMovie.count
    }
    
    func get(at row: Int) -> String? {
        guard row >= 0 && row < listGenreMovie.count else {
            return nil
        }
        return listGenreMovie[row].posterURL ?? ""
    }
    
    func loadMovies(completion: @escaping () -> Void) {
        service.fetchGenreMovie(id: id) { [weak self] result in
            switch result {
            case .sucess(let movies):
                self?.listGenreMovie = movies
                completion()
            case .failure(let error):
                self?.handleError(error: error)
            }
        }
    }
    
    func loadPopularMovies(completion: @escaping () -> Void) {
        service.fetchMoviePopular { [weak self] result in
            switch result {
            case .sucess(let popular):
                self?.listGenreMovie = popular
                completion()
            case .failure(let error):
                self?.handleError(error: error)
            }
        }
    }
    
    private func handleError(error: Erro) {
        // Implementar tratamento de erro adequado
    }
}
