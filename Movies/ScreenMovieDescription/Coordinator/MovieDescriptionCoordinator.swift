//
//  MovieDescriptionCoordinator.swift
//  Movies
//
//  Created by Gabriel Mendonça Sousa Gonçalves  on 26/06/21.
//  Copyright © 2021 Gabriel Mendonça. All rights reserved.
//

import Foundation


class MovieDescriptionCoordinator: Coordinator {
    var view: MovieDescriptionViewController?
    var navigation: NavigationController?
    var viewModel: MovieDescriptionViewModel!
    
    init(id: Int) {
        viewModel = MovieDescriptionViewModel(id: id, coordinator: self)
        view = MovieDescriptionViewController(movieDescriptionViewModel: viewModel)
    }
    
    func stop() {
        view = nil
        viewModel = nil
    }
    
    func sendMovieRecomendation(id: Int) {
        guard let navigation = navigation else { return }
        let descriptionMovie = MovieDescriptionCoordinator(id: id)
        descriptionMovie.start(usingPresentation: .push(navigation: navigation))
        
    }
    
    
}

extension MovieDescriptionCoordinator: MovieDescriptionViewModelDelegate {
    func cellTappedRecomendation(id: Int) {
        sendMovieRecomendation(id: id)
    }
    
    
}
