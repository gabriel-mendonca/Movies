//
//  SearchCoordinator.swift
//  Movies
//
//  Created by Gabriel Mendonça Sousa Gonçalves  on 04/02/21.
//  Copyright © 2021 Gabriel Mendonça. All rights reserved.
//

import UIKit

class SearchCoordinator: Coordinator {
    var view: SearchViewController?
    var navigation: NavigationController?
    var searchViewModel: SearchViewModel!
    
    var movieDescriptionCoordinator: MovieDescriptionCoordinator?
    var serieDescriptionCoordinator: SerieDescriptionCoordinator?
    
    init() {
        searchViewModel = SearchViewModel(coordinator: self)
        view = SearchViewController(viewModel: searchViewModel)
        view?.searchViewModel = searchViewModel
        view?.searchViewModel.delegate = self
    }
    
    func stop() {
        view = nil
        searchViewModel = nil
    }
    
    func sendToDescription(indexPath: Int) {
        guard let navigation = navigation else { return }
        let type = searchViewModel.searchMovie[indexPath].mediaType
        switch type {
        case "movie":
            movieDescriptionCoordinator = MovieDescriptionCoordinator(id: searchViewModel.searchMovie[indexPath].id ?? 0)
            movieDescriptionCoordinator?.start(usingPresentation: .push(navigation: navigation))
        case "tv":
            serieDescriptionCoordinator = SerieDescriptionCoordinator(id: searchViewModel.searchMovie[indexPath].id ?? 0)
            serieDescriptionCoordinator?.start(usingPresentation: .push(navigation: navigation))
        default:
           break
        }
    }
}

extension SearchCoordinator: SearchViewModelDelegate {
    func sendToMovieOrSerie(indexPath: Int) {
        sendToDescription(indexPath: indexPath)
    }
}
