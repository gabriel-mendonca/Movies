//
//  MovieCoordinator.swift
//  Movies
//
//  Created by Gabriel Mendonça Sousa Gonçalves  on 01/02/21.
//  Copyright © 2021 Gabriel Mendonça. All rights reserved.
//

import UIKit

class MovieCoordinator: Coordinator {
    var view: MovieViewController?
    var movieViewModel: MovieTableViewCellViewModel!
    var navigation: NavigationController?
    
    var movieDescriptionCoordinator: MovieDescriptionCoordinator?
    
    
    init() {
        movieViewModel = MovieTableViewCellViewModel(coordinator: self)
        view = MovieViewController(viewModel: movieViewModel)
        view?.movieTableViewCellViewModel = movieViewModel
        view?.movieTableViewCellViewModel.delegate = self
    }
    
    func showMovieDescription(_ movie: Movie) {
        guard let navigation = navigation else { return }
        movieDescriptionCoordinator = MovieDescriptionCoordinator(id: movie.id ?? 0)
        movieDescriptionCoordinator?.start(usingPresentation: .push(navigation: navigation))
    }
    
    func showMovieRecommendation(_ movie: Movie) {
        guard let navigation = navigation else { return }
        movieDescriptionCoordinator = MovieDescriptionCoordinator(id: movie.id ?? 0)
        movieDescriptionCoordinator?.start(usingPresentation: .push(navigation: navigation))
    }
    
    
    func stop() {
    }
    
}

extension MovieCoordinator: MovieCollectionViewCellDelegate {
    func cellTappedRecommendation(_ movie: Movie) {
        showMovieRecommendation(movie)
    }
    
    func cellTapped(movie: Movie) {
        showMovieDescription(movie)
    }
    
    
    
}
