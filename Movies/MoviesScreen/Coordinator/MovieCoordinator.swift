//
//  MovieCoordinator.swift
//  Movies
//
//  Created by Gabriel Mendonça Sousa Gonçalves  on 01/02/21.
//  Copyright © 2021 Gabriel Mendonça. All rights reserved.
//

import UIKit

class MovieCoordinator: Coordinator {
    typealias V = MovieViewController
    
    // MARK: - Properties
    var view: MovieViewController?
    var navigation: NavigationController?
    
    private var movieViewModel: MovieTableViewCellViewModel
    private var movieDescriptionCoordinator: MovieDescriptionCoordinator?
    
    // MARK: - Initialization
    init() {
        self.movieViewModel = MovieTableViewCellViewModel()
        setupViewController()
    }
    
    // MARK: - Private Methods
    private func setupViewController() {
        let movieListViewModel = MovieViewModel()
        view = MovieViewController(viewModel: movieViewModel, movieViewModel: movieListViewModel)
        view?.movieTableViewCellViewModel = movieViewModel
        view?.movieTableViewCellViewModel.delegate = self
    }
    
    // MARK: - Public Methods
    func showMovieDescription(_ movie: Movie) {
        navigateToMovieDescription(movie)
    }
    
    func showMovieRecommendation(_ movie: Movie) {
        navigateToMovieDescription(movie)
    }
    
    private func navigateToMovieDescription(_ movie: Movie) {
        guard let navigation = navigation,
              let movieId = movie.id else { return }
        
        movieDescriptionCoordinator = MovieDescriptionCoordinator(id: movieId)
        movieDescriptionCoordinator?.start(usingPresentation: .push(navigation: navigation))
    }
    
    func stop() {
        movieDescriptionCoordinator = nil
        view = nil
    }
}

// MARK: - MovieCollectionViewCellDelegate
extension MovieCoordinator: MovieCollectionViewCellDelegate {
    func cellTappedRecommendation(_ movie: Movie) {
        showMovieRecommendation(movie)
    }
    
    func cellTapped(movie: Movie) {
        showMovieDescription(movie)
    }
}
